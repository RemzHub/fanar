import 'package:fanar/core/common/model/city.dart';
import 'package:fanar/core/common/model/country.dart';
import 'package:fanar/core/common/model/gender.dart';
import 'package:fanar/core/common/model/role.dart';

abstract class Profile {
  final String profileImage;

  Profile({
    required this.profileImage,
  });
}

class PerformerProfile extends Profile {
  final String firstName;
  final String middleName;
  final String lastName;
  final String bio;
  final Gender gender;
  final Role generalRole;
  final Country nationality;
  final Country residenceCountry;
  final City residenceCity;

  PerformerProfile({
    required super.profileImage,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.bio,
    required this.gender,
    required this.generalRole,
    required this.nationality,
    required this.residenceCountry,
    required this.residenceCity,
  });

  factory PerformerProfile.fromJson(Map<String, dynamic> json) =>
      PerformerProfile(
        profileImage: json['profile_image'],
        firstName: json['first_name'],
        middleName: json['middle_name'],
        lastName: json['last_name'],
        bio: json['bio'],
        gender: Gender.fromJson(json['gender']),
        generalRole: Role.fromJson(json['role']),
        nationality: Country.fromJson(json['nationality']),
        residenceCountry: Country.fromJson(json['country']),
        residenceCity: City.fromJson(json['city']),
      );
}

class RecruiterProfile extends Profile {
  final int id;
  final String organizationName;
  final String bio;
  final String contactLastName;
  final String contactFirstName;
  final Role contactRole;
  final Country residenceCountry;
  final City residenceCity;
  final String website;

  RecruiterProfile({
    required super.profileImage,
    required this.organizationName,
    required this.id,
    required this.contactFirstName,
    required this.contactLastName,
    required this.bio,
    required this.contactRole,
    required this.residenceCountry,
    required this.residenceCity,
    required this.website,
  });

  factory RecruiterProfile.fromJson(Map<String, dynamic> json) {
    return RecruiterProfile(
      id: json['id'],
      profileImage: json['profile_image'] ?? '',
      organizationName: json['organization_name'] ?? '',
      contactFirstName: json['contact_first_name'] ?? '',
      contactLastName: json['contact_last_name'] ?? '',
      bio: json['bio'] ?? '',
      contactRole: Role.fromJson(json['role']),
      residenceCountry: Country.fromJson(json['country']),
      residenceCity: City.fromJson(json['city']),
      website: json['website'] ?? '',
    );
  }
}
