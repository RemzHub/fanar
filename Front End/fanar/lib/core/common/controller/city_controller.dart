import 'package:fanar/core/common/model/city.dart';
import 'package:fanar/core/network/api_constants.dart';
import 'package:fanar/core/network/custom_http_client.dart';
import 'package:get/get.dart';

class CityController extends GetxController {
  final dio = CustomHttpClient().dio;
  List<City> cities = [];

  RequestState countriesRequestState = RequestState.loading;

  Future<void> fetchCities() async {
    if (countriesRequestState != RequestState.loading) {
      countriesRequestState = RequestState.loading;
      update();
    }

    try {
      final result = await dio.get(ApiConstants.allCities);
      final data = result.data as List<dynamic>;
      List<City> list = [];

      for (var city in data) {
        list.add(
          City(
            id: city['id'],
            name: city['name'],
          ),
        );
      }

      cities = [...list];
      countriesRequestState = RequestState.done;
    } catch (error) {
      countriesRequestState = RequestState.error;
    }
    update();
  }
}
