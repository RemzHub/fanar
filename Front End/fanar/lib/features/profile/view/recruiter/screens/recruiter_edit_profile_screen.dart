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

class RecruiterEditProfileScreen extends StatefulWidget {
  static const String routeName = '/recruiter-edit-profile';
  const RecruiterEditProfileScreen({super.key});

  @override
  State<RecruiterEditProfileScreen> createState() =>
      _RecruiterEditProfileScreenState();
}

class _RecruiterEditProfileScreenState
    extends State<RecruiterEditProfileScreen> {
  final organizationNameKey = 'organization_name';
  final contactFirstNameKey = 'contact_first_name';
  final contactLastNameKey = 'contact_last_name';
  final bioKey = 'bio';
  final contactRoleIdKey = 'contact_role_id';
  final countryIdKey = 'country_id';
  final cityIdKey = 'city_id';
  final websiteKey = 'website';
  final profileInfo = {};

  void updateProfile() async {
    if (profileInfo.containsKey(contactRoleIdKey)) {
      profileInfo[contactRoleIdKey] = profileInfo[contactRoleIdKey]['id'];
    }
    if (profileInfo.containsKey(countryIdKey)) {
      profileInfo[countryIdKey] = profileInfo[countryIdKey]['id'];
    }
    if (profileInfo.containsKey(cityIdKey)) {
      profileInfo[cityIdKey] = profileInfo[cityIdKey]['id'];
    }
    if (profileInfo.containsKey(websiteKey)) {
      profileInfo[websiteKey] = profileInfo[websiteKey]['id'];
    }

    print(profileInfo);

    final result = await AuthController.to.updateRecruiterProfile(profileInfo);
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
    final profile = user.profile as RecruiterProfile;

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
                title: 'أسم الجهة',
                initialValue: profile.organizationName,
                onChanged: (value) => value.isEmpty
                    ? profileInfo.remove(organizationNameKey)
                    : profileInfo.addAll(
                        {organizationNameKey: value},
                      ),
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                title: 'الاسم الاول لمندوب الجهة',
                initialValue: profile.contactFirstName,
                onChanged: (value) => value.isEmpty
                    ? profileInfo.remove(contactFirstNameKey)
                    : profileInfo.addAll(
                        {contactFirstNameKey: value},
                      ),
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                title: 'اسم العائلة لمندوب التوصل',
                initialValue: profile.contactLastName,
                onChanged: (value) => value.isEmpty
                    ? profileInfo.remove(contactLastNameKey)
                    : profileInfo.addAll(
                        {contactLastNameKey: value},
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
              RolePickerButton(
                key: UniqueKey(),
                title: 'منصب مندوب التواصل',
                value: profileInfo[contactRoleIdKey]?['name'] ??
                    profile.contactRole.name,
                onChoose: (value) {
                  setState(() {
                    profileInfo.addAll(
                      {contactRoleIdKey: value},
                    );
                  });
                },
              ),
              const SizedBox(height: 16.0),
              CountryPickerButton(
                key: UniqueKey(),
                title: 'موقع دولة الجهة',
                value: profileInfo[countryIdKey]?['name'] ??
                    profile.residenceCountry.name,
                onChoose: (value) {
                  setState(() {
                    profileInfo.addAll(
                      {countryIdKey: value},
                    );
                  });
                },
              ),
              const SizedBox(height: 16.0),
              CityPickerButton(
                key: UniqueKey(),
                title: 'موقع مدينة الجهة',
                value: profileInfo[cityIdKey]?['name'] ??
                    profile.residenceCity.name,
                onChoose: (value) {
                  setState(() {
                    profileInfo.addAll(
                      {cityIdKey: value},
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
