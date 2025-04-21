import 'package:fanar/core/common/model/role.dart';
import 'package:fanar/core/network/api_constants.dart';
import 'package:fanar/core/network/custom_http_client.dart';
import 'package:fanar/features/auth/logic/model/user_type.dart';
import 'package:get/get.dart';

class RoleController extends GetxController {
  final dio = CustomHttpClient().dio;
  List<Role> roles = [];

  RequestState countriesRequestState = RequestState.loading;

  Future<void> fetchRoles() async {
    if (countriesRequestState != RequestState.loading) {
      countriesRequestState = RequestState.loading;
      update();
    }

    try {
      final result = await dio.get(ApiConstants.allRoles);
      final data = result.data as List<dynamic>;
      List<Role> list = [];

      for (var role in data) {
        list.add(
          Role(
            id: role['id'],
            name: role['name'],
            userType: UserType(
              id: role['user_type_id'],
              name: 'name',
            ),
          ),
        );
      }

      roles = [...list];
      countriesRequestState = RequestState.done;
    } catch (error) {
      countriesRequestState = RequestState.error;
    }
    update();
  }
}
