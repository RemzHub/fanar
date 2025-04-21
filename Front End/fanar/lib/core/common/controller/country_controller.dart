import 'package:fanar/core/common/model/country.dart';
import 'package:fanar/core/network/api_constants.dart';
import 'package:fanar/core/network/custom_http_client.dart';
import 'package:get/get.dart';

class CountryController extends GetxController {
  final dio = CustomHttpClient().dio;
  List<Country> countries = [];

  RequestState countriesRequestState = RequestState.loading;

  Future<void> fetchCountries() async {
    if (countriesRequestState != RequestState.loading) {
      countriesRequestState = RequestState.loading;
      update();
    }

    try {
      final result = await dio.get(ApiConstants.allCountries);
      final data = result.data as List<dynamic>;
      List<Country> list = [];

      for (var country in data) {
        list.add(
          Country(
            id: country['id'],
            name: country['name'],
          ),
        );
      }

      countries = [...list];
      countriesRequestState = RequestState.done;
    } catch (error) {
      countriesRequestState = RequestState.error;
    }
    update();
  }
}
