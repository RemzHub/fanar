import 'dart:convert';

import 'package:fanar/core/network/api_constants.dart';
import 'package:fanar/core/network/custom_http_client.dart';
import 'package:fanar/features/application/data/recruiter_applications.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/auth/logic/model/profile.dart';
import 'package:fanar/features/opportunity/logic/model/opportunity.dart';
import 'package:fanar/features/opportunity/logic/model/recruiter_opportunity.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class OpportunityController extends GetxController {
  static OpportunityController get to => Get.find();

  final dio = CustomHttpClient().dio;

  final List<Opportunity> _opportunities = [];

  List<Opportunity> get opportunity => [..._opportunities];

  final List<RecruiterOpportunity> _recruiterOpportunities = [];

  List<RecruiterOpportunity> get recruiterOpportunities =>
      [..._recruiterOpportunities];

  Future<(bool, String)> fetchOpportunities() async {
    print('hrere');
    try {
      final result = await dio.get(ApiConstants.opportunitiesPath);
      print('here0.5');

      if (result.statusCode != 200) {
        print('not 200');
        return (false, 'failed');
      }

      print('hrer2');

      final data = result.data['data'] as List<dynamic>;
      final message = result.data['message'];

      print(data);
      print(message);

      _opportunities.clear();

      for (var opportunity in data) {
        _opportunities.add(
          Opportunity.fromJson(opportunity),
        );
      }
      update();
      return (true, '$message');
    } catch (error) {
      print(error);
      return (false, 'failed');
    }
  }

  Future<(bool, String)> createOpportunity(
      Map<String, dynamic> body, String token) async {
    print('hererere');
    try {
      final result = await dio.post(
        ApiConstants.createOpportunity,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print(result.statusCode);
      print(result.data);
      return (true, 'success');
    } catch (error) {
      print(error);

      return (false, 'failed');
    }
  }

  Future<void> fetchRecruiterOpportunities() async {
    try {
      final result = await dio.get(
        ApiConstants.recruiterApplications,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthController.to.user.token}',
          },
        ),
      );

      print(result.statusCode);
      print(result.data);

      if (result.statusCode != 200) {
        return;
      }

      final opportunities = result.data['data'] as List<dynamic>;

      _recruiterOpportunities.clear();

      for (var opportunity in opportunities) {
        _recruiterOpportunities.add(RecruiterOpportunity.fromJson(opportunity));
      }
      update();
    } catch (error) {
      print(error);
    }
  }
}
