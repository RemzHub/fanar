import 'dart:io';

import 'package:fanar/core/common/model/city.dart';
import 'package:fanar/core/common/model/country.dart';
import 'package:fanar/core/common/model/gender.dart';
import 'package:fanar/core/common/model/media.dart';
import 'package:fanar/core/common/model/role.dart';
import 'package:fanar/core/network/api_constants.dart';
import 'package:fanar/core/network/custom_http_client.dart';
import 'package:fanar/features/auth/logic/model/profile.dart';
import 'package:fanar/features/auth/logic/model/user.dart';
import 'package:fanar/features/auth/logic/model/user_status.dart';
import 'package:fanar/features/auth/logic/model/user_type.dart';
import 'package:dio/dio.dart' as d;
import 'package:path/path.dart' as path;
import 'package:get/get.dart';

class AuthController extends GetxController {
  AuthController() {
    user = _demoUser;
  }

  static AuthController to = Get.find();

  final dio = CustomHttpClient().dio;

  final _demoUser = User(
    id: 0,
    username: '',
    phone: '',
    email: '',
    password: '',
    userType: UserType(
      id: 0,
      name: '',
    ),
    userStatus: UserStatus(
      id: 0,
      name: '',
    ),
  );

  late User user;

  RxBool get isPerformer => (user.userType.id == 5).obs;

  String otp = '';

  // ignore: prefer_final_fields
  RxBool _isAuthenticated = false.obs;

  RxBool get isAuthenticated => _isAuthenticated;

  void updateUserType(UserType userType) {
    user = user.copyWith(userType: userType);
  }

  void updateUsernameAndPhone(
    String username,
    String phone,
    UserType userType,
  ) {
    user = User(
      id: 0,
      username: username,
      phone: phone,
      email: '',
      password: '',
      userType: userType,
      userStatus: UserStatus(
        id: 0,
        name: '',
      ),
    );
  }

  Future<bool> checkUsername(String username) async {
    try {
      final result = await dio.post(
        ApiConstants.checkUsername,
        data: {
          'username': username,
        },
      );

      if (result.statusCode != 200) {
        return false;
      }

      final data = result.data;

      print(data);

      return data['data']['username'] as bool;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> checkPhone(String phone) async {
    try {
      final result = await dio.post(
        ApiConstants.checkPhone,
        data: {
          'phone': phone,
        },
      );

      if (result.statusCode != 200) {
        return false;
      }

      final data = result.data;

      return data['data']['phone'] as bool;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> sendOTP() async {
    try {
      final result = await dio.post(ApiConstants.sendOTP, data: {
        'phone': user.phone,
      });

      // TODO: fix this
      if (result.statusCode != 200) {
        print('fix this');
      }

      final data = result.data['data'];
      print(data);

      otp = data['code'];
      update();

      return true;
    } catch (error) {
      // TODO: accept 404 from the server
      print(error);
      return false;
    }
  }

  Future<bool> checkOTP(String code) async {
    try {
      final result = await dio.post(ApiConstants.checkOTP, data: {
        'phone': user.phone,
        'code': code,
      });
      print(result.data);
      if (result.data['data']['verified']) return true;
      return false;
    } catch (error) {
      // TODO: accept 404 from the server
      print(error);
      return false;
    }
  }

  void updatePassword(String password) async {
    user = user.copyWith(password: password);
    update();
  }

  Future<(bool, String)> register() async {
    isAuthenticated.value = true;
    try {
      final result = await dio.post(ApiConstants.register, data: {
        'username': user.username,
        'password': user.password,
        'phone': user.phone,
        'user_type_id': user.userType.id,
        'otp': otp,
      });

      final String message = '${result.data['message']}';

      if (result.statusCode != 201) {
        return (false, message);
      }

      final data = result.data['data'];

      user = user.copyWith(
        id: data['id'],
        username: data['username'],
        phone: data['phone'],
        userType: UserType(
          id: data['user_type']['id'],
          name: data['user_type']['name'],
        ),
      );

      _isAuthenticated.value = true;
      print(isAuthenticated.value);
      return (true, message);
    } catch (error) {
      print(error);
      return (true, error.toString());
    }
  }

  Future<(bool, String)> login(String username, String password) async {
    print('function triggered');
    try {
      final result = await dio.post(ApiConstants.login, data: {
        'username': username,
        'password': password,
      });

      print('result comes');

      final String message = '${result.data['message']}';

      if (result.statusCode != 200) {
        return (false, message);
      } else if (result.statusCode == 401) {
        return (false, message);
      }

      final data = result.data['data'] as Map<String, dynamic>;
      print(data);

      final gallery = data['gallery'] as List<dynamic>;

      final List<Media> galleryList = [];

      for (var g in gallery) {
        galleryList.add(Media(
          id: g['id'],
          userId: g['user_id'],
          mediaType: g['media_type_id'],
          path: g['media_path'],
        ));
      }

      user = user.copyWith(
        id: data['user']['id'],
        username: data['user']['username'],
        phone: data['user']['phone'],
        email: data['user']['email'],
        userType: UserType(
          id: data['user']['user_type']['id'],
          name: data['user']['user_type']['name'],
        ),
        userStatus: UserStatus(
          id: data['user']['status']['id'],
          name: data['user']['status']['name'],
        ),
        gallery: galleryList,
        token: data['token'],
      );

      if (data['user']['user_type']['id'] == 5) {
        print('performer');
        print(data);
        print(data['profile']['first_name']);
        user = user.copyWith(
            profile: PerformerProfile(
          profileImage: data['profile']['profile_image'] ?? '',
          firstName: data['profile']['first_name'] ?? '',
          middleName: data['profile']['middle_name'] ?? '',
          lastName: data['profile']['last_name'] ?? '',
          bio: data['profile']['bio'] ?? '',
          gender: Gender(
            id: data['profile']['gender']['id'] ?? 0,
            name: data['profile']['gender']['name'] ?? '',
          ),
          generalRole: Role(
            id: data['profile']['general_role']['id'] ?? 0,
            name: data['profile']['general_role']['name'] ?? '',
            userType: UserType(
              id: data['user']['user_type']['id'],
              name: data['user']['user_type']['name'],
            ),
          ),
          nationality: Country(
            id: data['profile']['nationality']['id'] ?? 0,
            name: data['profile']['nationality']['name'] ?? '',
          ),
          residenceCountry: Country(
            id: data['profile']['residence_country']['id'] ?? 0,
            name: data['profile']['residence_country']['name'] ?? '',
          ),
          residenceCity: City(
            id: data['profile']['residence_city']['id'] ?? 0,
            name: data['profile']['residence_city']['name'] ?? '',
          ),
        ));
      } else if (data['user']['user_type']['id'] == 4) {
        user = user.copyWith(
          profile: RecruiterProfile.fromJson(data['profile']),
        );
      }

      _isAuthenticated.value = true;
      print(isAuthenticated.value);
      return (true, message);
    } catch (error) {
      print(error);
      return (false, error.toString());
    }
  }

  Future<(bool, String)> updatePerformerProfile(Map body) async {
    try {
      final result = await dio.post(
        ApiConstants.performerProfile,
        data: body,
        options: d.Options(
          headers: {
            'Authorization': 'Bearer ${user.token}',
          },
        ),
      );
      print(result.data);

      if (result.statusCode != 200) {
        print('error');
      }

      final data = result.data['data'];

      print(data);

      user = user.copyWith(
        profile: PerformerProfile(
          profileImage: data['profile_image'] ?? '',
          firstName: data['first_name'] ?? '',
          middleName: data['middle_name'] ?? '',
          lastName: data['last_name'] ?? '',
          bio: data['bio'] ?? '',
          gender: Gender(
            id: data['gender']['id'] ?? 0,
            name: data['gender']['name'] ?? '',
          ),
          generalRole: Role(
            id: data['general_role']['id'] ?? 0,
            name: data['general_role']['name'] ?? '',
            userType: UserType(
              id: 0,
              name: "data['user']['user_type']['name']",
            ),
          ),
          nationality: Country(
            id: data['nationality']['id'] ?? 0,
            name: data['nationality']['name'] ?? '',
          ),
          residenceCountry: Country(
            id: data['residence_country']['id'] ?? 0,
            name: data['residence_country']['name'] ?? '',
          ),
          residenceCity: City(
            id: data['residence_city']['id'] ?? 0,
            name: data['residence_city']['name'] ?? '',
          ),
        ),
      );

      print('success');
      update();
      return (true, 'success');
    } catch (error) {
      print(error);
      return (false, 'failed');
    }
  }

  Future<(bool, String)> updateRecruiterProfile(Map body) async {
    try {
      final result = await dio.post(
        ApiConstants.recruiterProfile,
        data: body,
        options: d.Options(
          headers: {
            'Authorization': 'Bearer ${user.token}',
          },
        ),
      );
      print(result.data);

      if (result.statusCode != 200) {
        print('error');
      }

      final data = result.data['data'];

      print(data);

      user = user.copyWith(
        profile: RecruiterProfile.fromJson(data),
      );

      print('success');
      update();
      return (true, 'success');
    } catch (error) {
      print(error);
      return (false, 'failed');
    }
  }

  Future<(bool, String)> uploadMedia(File file, int type) async {
    try {
      final fileName = path.basename(file.path);
      var data = d.FormData.fromMap({
        'media': [
          await d.MultipartFile.fromFile(
            file.path,
            filename: fileName,
          )
        ],
        'media_type_id': type
      });
      final result = await dio.post(
        ApiConstants.uploadMedia,
        data: data,
        options: d.Options(
          headers: {
            'Authorization': 'Bearer ${user.token}',
          },
        ),
      );

      print(result.data);

      if (result.statusCode != 201) {
        return (false, 'something happen');
      }

      if (user.userType.id == 5) updatePerformerProfile({});
      print('update');
      if (user.userType.id == 4) updateRecruiterProfile({});
      userGallery();

      return (true, 'image updated');
    } catch (error) {
      print(error);
      return (false, error.toString());
    }
  }

  Future<(bool, String)> deleteMedia(String id) async {
    print(id);
    try {
      final result = await dio.delete(
        ApiConstants.deleteMedia,
        queryParameters: {
          'id': id,
        },
        options: d.Options(
          headers: {
            'Authorization': 'Bearer ${user.token}',
          },
        ),
      );

      print(result.data);

      if (result.statusCode != 200) {
        return (false, 'unknown error');
      }

      userGallery();

      return (true, 'success');
    } catch (error) {
      print(error);
      return (false, error.toString());
    }
  }

  Future<(bool, String)> userGallery() async {
    try {
      final result = await dio.get(
        ApiConstants.userGallery,
        options: d.Options(
          headers: {
            'Authorization': 'Bearer ${user.token}',
          },
        ),
      );

      print(result.data);

      if (result.statusCode != 200) {
        return (false, 'unknown error');
      }

      final data = result.data;

      final gallery = data as List;

      final List<Media> galleryList = [];

      for (var image in gallery) {
        galleryList.add(
          Media(
            id: image['id'],
            userId: image['user_id'],
            mediaType: image['media_type_id'],
            path: image['media_path'],
          ),
        );
      }

      print(gallery.length);

      user = user.copyWith(
        gallery: galleryList,
      );
      update();
      return (true, 'gallery brought');
    } catch (error) {
      print(error);
      return (false, error.toString());
    }
  }

  Future<(bool, String)> uploadImage() async {
    return (false, 'something happen');
  }

  void logout() {
    user = user.demo();
    _isAuthenticated.value = false;
  }

  // Future<User> getUserById(int id) async {
  //   try {
  //     final result = await dio.get(ApiConstants.userById(id));
  //     print(result.data);

  //     return User(
  //       id: id,
  //       username: username,
  //       phone: phone,
  //       email: email,
  //       password: password,
  //       userType: userType,
  //       userStatus: userStatus,
  //     );
  //   } catch (error) {
  //     print(error);
  //     throw Exception();
  //   }
  // }
}
