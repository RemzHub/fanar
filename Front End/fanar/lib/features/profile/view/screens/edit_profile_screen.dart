import 'package:fanar/core/common/widgets/city_picker_button.dart';
import 'package:fanar/core/common/widgets/country_picker_button.dart';
import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/core/common/widgets/custom_text_form_field.dart';
import 'package:fanar/core/common/widgets/gender_picker_button.dart';
import 'package:fanar/core/common/widgets/role_picker_button.dart';
import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/auth/logic/model/profile.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/edit-profile';
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final firstNameKey = 'first_name';
  final middleNameKey = 'middle_name';
  final lastNameKey = 'last_name';
  final bioKey = 'bio';
  final genderKey = 'gender_id';
  final generalRoleIdKey = 'general_role_id';
  final nationalityKey = 'nationality_id';
  final residenceCountryKey = 'residence_country_id';
  final residenceCityKey = 'residence_city_id';
  final profileInfo = {};

  void updateProfile() async {
    if (profileInfo.containsKey(genderKey)) {
      profileInfo[genderKey] = profileInfo[genderKey]['id'];
    }
    if (profileInfo.containsKey(generalRoleIdKey)) {
      profileInfo[generalRoleIdKey] = profileInfo[generalRoleIdKey]['id'];
    }
    if (profileInfo.containsKey(nationalityKey)) {
      profileInfo[nationalityKey] = profileInfo[nationalityKey]['id'];
    }
    if (profileInfo.containsKey(residenceCountryKey)) {
      profileInfo[residenceCountryKey] = profileInfo[residenceCountryKey]['id'];
    }
    if (profileInfo.containsKey(residenceCityKey)) {
      profileInfo[residenceCityKey] = profileInfo[residenceCityKey]['id'];
    }
    final result = await AuthController.to.updatePerformerProfile(profileInfo);
    if (result.$1) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // AppBar height
    final double appBarHeight = kToolbarHeight; // Default AppBar height is 56.0
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final user = AuthController.to.user;
    final profile = user.profile as PerformerProfile;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeController().themeGradient,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: appBarHeight + statusBarHeight,
            left: 32.0,
            right: 32.0,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Text(
                'تعديل الملف الشخصي',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 32.0),
              CustomTextFormField(
                title: 'الاسم الاول',
                initialValue: profile.firstName,
                onChanged: (value) => value.isEmpty
                    ? profileInfo.remove(firstNameKey)
                    : profileInfo.addAll(
                        {firstNameKey: value},
                      ),
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                title: 'الاسم الاوسط',
                initialValue: profile.middleName,
                onChanged: (value) => value.isEmpty
                    ? profileInfo.remove(middleNameKey)
                    : profileInfo.addAll(
                        {middleNameKey: value},
                      ),
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                title: 'اسم العائلة',
                initialValue: profile.lastName,
                onChanged: (value) => value.isEmpty
                    ? profileInfo.remove(lastNameKey)
                    : profileInfo.addAll(
                        {lastNameKey: value},
                      ),
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                title: 'وصف',
                initialValue: profile.bio,
                hintText: 'تحدث عن نفسك',
                minLines: 3,
                maxLines: 4,
                onChanged: (value) => value.isEmpty
                    ? profileInfo.remove(bioKey)
                    : profileInfo.addAll(
                        {bioKey: value},
                      ),
              ),
              const SizedBox(height: 16.0),
              GenderPickerButton(
                key: UniqueKey(),
                title: 'الجنس',
                value: profileInfo[genderKey]?['name'] ?? profile.gender.name,
                onChoose: (value) {
                  setState(() {
                    profileInfo.addAll(
                      {genderKey: value},
                    );
                  });
                },
              ),
              const SizedBox(height: 16.0),
              RolePickerButton(
                key: UniqueKey(),
                title: 'أختر دورك الأدائي',
                value: profileInfo[generalRoleIdKey]?['name'] ??
                    profile.generalRole.name,
                onChoose: (value) {
                  setState(() {
                    profileInfo.addAll(
                      {generalRoleIdKey: value},
                    );
                  });
                },
              ),
              const SizedBox(height: 16.0),
              CountryPickerButton(
                key: UniqueKey(),
                title: 'الجنسية',
                value: profileInfo[nationalityKey]?['name'] ??
                    profile.nationality.name,
                onChoose: (value) {
                  setState(() {
                    profileInfo.addAll(
                      {nationalityKey: value},
                    );
                  });
                },
              ),
              const SizedBox(height: 16.0),
              CountryPickerButton(
                key: UniqueKey(),
                title: 'دولة الإقامة',
                value: profileInfo[residenceCountryKey]?['name'] ??
                    profile.residenceCountry.name,
                onChoose: (value) {
                  setState(() {
                    profileInfo.addAll(
                      {residenceCountryKey: value},
                    );
                  });
                },
              ),
              const SizedBox(height: 16.0),
              CityPickerButton(
                key: UniqueKey(),
                title: 'مدينة الإقامة',
                value: profileInfo[residenceCityKey]?['name'] ??
                    profile.residenceCity.name,
                onChoose: (value) {
                  setState(() {
                    profileInfo.addAll(
                      {residenceCityKey: value},
                    );
                  });
                },
              ),
              const SizedBox(height: 32.0),
              CustomElevatedButton(
                label: 'تحديث الملف الشخصي',
                onPressed: updateProfile,
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
