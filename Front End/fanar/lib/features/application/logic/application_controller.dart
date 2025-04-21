import 'package:fanar/core/common/model/status.dart';
import 'package:fanar/core/network/api_constants.dart';
import 'package:fanar/core/network/custom_http_client.dart';
import 'package:fanar/features/application/data/application.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/opportunity/logic/model/opportunity.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApplicationController extends GetxController {
  static ApplicationController to = Get.find();

  final authController = AuthController.to;

  final List<Application> _performerApplications = [];

  List<Application> get performerApplication => [..._performerApplications];

  final dio = CustomHttpClient().dio;

  Future<void> fetchPerformerApplications() async {
    try {
      final result = await dio.get(
        ApiConstants.performerApplications,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${authController.user.token}',
          },
        ),
      );

      print(result.statusCode);
      print(result.data);

      if (result.statusCode != 200) {
        return;
      }

      final applications = result.data['data'] as List<dynamic>;

      _performerApplications.clear();

      for (var application in applications) {
        _performerApplications.add(
          Application(
            id: application['id'],
            opportunity: Opportunity.fromJson(application['opportunity']),
            performerId: application['performer_id'],
            coverLetter: application['cover_letter'],
            status: Status.fromJson(application['status']),
            createdAt: DateTime.parse(application['created_at']),
          ),
        );
      }
      update();
    } catch (error) {
      print(error);
    }
  }

  Future<(bool, String)> sendApplication(
      int id, String letter, String token) async {
    try {
      final result = await dio.post(
        ApiConstants.createApplication,
        data: {
          'opportunity_id': id,
          'cover_letter': letter,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (result.statusCode != 201) {
        print('status code problem');
        print(result.statusCode);
        print(result.data);
        return (false, 'failed');
      }

      final data = result.data['data'];
      return (true, 'success');
    } catch (error) {
      print(error);
      return (false, 'failed');
    }
  }

  Future<(bool, String, Map)> switchApplicationStatus(
      int applicationId, int statusId) async {
    try {
      final result = await dio.post(
        ApiConstants.switchApplicationStatus,
        data: {
          'application_id': applicationId,
          'status': statusId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthController.to.user.token}',
          },
        ),
      );

      if (result.statusCode != 200) {
        return (false, 'failed', {});
      }

      print(result.data);
      final data = result.data['data'] as Map<String, dynamic>;
      return (true, 'success', (data['status'] as Map));
    } catch (error) {
      print(error);
      return (false, 'failed', {});
    }
  }
}
