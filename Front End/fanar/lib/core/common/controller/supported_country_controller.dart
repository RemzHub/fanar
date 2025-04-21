import 'package:fanar/core/common/model/supported_country.dart';
import 'package:fanar/core/network/api_constants.dart';
import 'package:fanar/core/network/custom_http_client.dart';
import 'package:get/get.dart';

class SupportedCountryController extends GetxController {
  final dio = CustomHttpClient().dio;
  List<SupportedCountry> countries = [];

  RequestState countriesRequestState = RequestState.loading;

  late SupportedCountry country;

  void updateCountry(int id) {
    country = countries.firstWhere(
      (element) => element.id == id,
    );
    update();
  }

  Future<void> fetchCountries() async {
    if (countriesRequestState != RequestState.loading) {
      countriesRequestState = RequestState.loading;
      update();
    }

    try {
      final result = await dio.get(ApiConstants.allSupportedCountries);
      final data = result.data as List<dynamic>;
      List<SupportedCountry> list = [];

      for (var country in data) {
        list.add(
          SupportedCountry(
            id: country['id'],
            name: country['name'],
            code: country['code'],
            phoneCode: country['phone_code'],
            emoji: country['emoji'],
            numberFormat: country['number_format'],
            numberLength: country['number_length'],
            hintText: country['hint_text'],
          ),
        );
      }

      countries = [...list];
      country = countries.first;
      countriesRequestState = RequestState.done;
    } catch (error) {
      countriesRequestState = RequestState.error;
    }
    update();
  }
}
