import 'package:fanar/core/common/model/gender.dart';
import 'package:fanar/core/network/api_constants.dart';
import 'package:fanar/core/network/custom_http_client.dart';
import 'package:get/get.dart';

class GenderController extends GetxController {
  final dio = CustomHttpClient().dio;
  List<Gender> genders = [];

  RequestState gendersRequestState = RequestState.loading;

  Future<void> fetchGenders() async {
    if (gendersRequestState != RequestState.loading) {
      gendersRequestState = RequestState.loading;
      update();
    }

    try {
      final result = await dio.get(ApiConstants.allGenders);
      final data = result.data as List<dynamic>;
      List<Gender> list = [];

      for (var role in data) {
        list.add(
          Gender(
            id: role['id'],
            name: role['name'],
          ),
        );
      }

      genders = [...list];
      gendersRequestState = RequestState.done;
    } catch (error) {
      gendersRequestState = RequestState.error;
    }
    update();
  }
}
