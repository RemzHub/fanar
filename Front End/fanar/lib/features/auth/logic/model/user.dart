import 'package:fanar/core/common/model/media.dart';
import 'package:fanar/features/auth/logic/model/profile.dart';
import 'package:fanar/features/auth/logic/model/user_status.dart';
import 'package:fanar/features/auth/logic/model/user_type.dart';

class User {
  final int id;
  final String username;
  final String phone;
  final String email;
  final String password;
  final UserType userType;
  final UserStatus userStatus;
  final Profile? profile;
  final List<Media> gallery;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    required this.userType,
    required this.userStatus,
    this.profile,
    this.gallery = const [],
    this.token = '',
  });

  User copyWith({
    int? id,
    String? username,
    String? phone,
    String? email,
    String? password,
    UserType? userType,
    UserStatus? userStatus,
    Profile? profile,
    List<Media>? gallery,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      userType: userType ?? this.userType,
      userStatus: userStatus ?? this.userStatus,
      profile: profile ?? this.profile,
      gallery: gallery ?? this.gallery,
      token: token ?? this.token,
    );
  }

  User demo() => User(
        id: 0,
        username: '',
        phone: '',
        password: '',
        email: '',
        userType: UserType(
          id: 0,
          name: '',
        ),
        userStatus: UserStatus(
          id: 0,
          name: '',
        ),
      );
}
