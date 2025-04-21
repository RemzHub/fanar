import 'package:fanar/core/common/widgets/city_picker_button.dart';
import 'package:fanar/core/common/widgets/country_picker_button.dart';
import 'package:fanar/core/common/widgets/custom_date_picker.dart';
import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/core/common/widgets/custom_text_form_field.dart';
import 'package:fanar/core/common/widgets/role_picker_button.dart';
import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/opportunity/controller/opportunity_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddOpportunityScreen extends StatefulWidget {
  static String routeName = '/add-opportunity-screen';
  const AddOpportunityScreen({super.key});

  @override
  State<AddOpportunityScreen> createState() => _AddOpportunityScreenState();
}

class _AddOpportunityScreenState extends State<AddOpportunityScreen> {
  final String titleKey = 'title';
  final String roleKey = 'role_id';
  final String descriptionKey = 'description';
  final String numberCrewKey = 'number_crew';
  final String countryKey = 'country_id';
  final String cityKey = 'city_id';
  final String endDateKey = 'end_date';
  final Map<String, dynamic> opportunityInfo = {'opportunity_status_id': '1'};

  void addOpportunity() async {
    if (!opportunityInfo.containsKey(numberCrewKey)) {
      opportunityInfo.addAll({numberCrewKey: 1});
    }
    if (opportunityInfo.containsKey(roleKey)) {
      opportunityInfo[roleKey] = opportunityInfo[roleKey]['id'];
    }
    if (opportunityInfo.containsKey(countryKey)) {
      opportunityInfo[countryKey] = opportunityInfo[countryKey]['id'];
    }
    if (opportunityInfo.containsKey(cityKey)) {
      opportunityInfo[cityKey] = opportunityInfo[cityKey]['id'];
    }

    print(opportunityInfo);

    final result = await OpportunityController.to.createOpportunity(
      opportunityInfo,
      AuthController.to.user.token,
    );

    if (result.$1) {
      OpportunityController.to.fetchOpportunities();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // AppBar height
    final double appBarHeight = kToolbarHeight; // Default AppBar height is 56.0
    final double statusBarHeight = MediaQuery.of(context).padding.top;

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
                'معلومات الدور المطلوب',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 32.0),
              CustomTextFormField(
                title: 'العنوان',
                onChanged: (value) => value.isEmpty
                    ? opportunityInfo.remove(titleKey)
                    : opportunityInfo.addAll({
                        titleKey: value,
                      }),
              ),
              const SizedBox(height: 16.0),
              RolePickerButton(
                key: UniqueKey(),
                value: opportunityInfo[roleKey]?['name'] ?? 'اختر الدور',
                title: 'الدور المطلوب',
                onChoose: (value) => setState(() {
                  opportunityInfo.addAll({roleKey: value});
                }),
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                title: 'وصف الدور',
                onChanged: (value) => value.isEmpty
                    ? opportunityInfo.remove(descriptionKey)
                    : opportunityInfo.addAll({
                        descriptionKey: value,
                      }),
                minLines: 3,
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              CustomTextFormField(
                hintText: '1',
                title: 'عدد الفرص المتاحة',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 16.0),
              CountryPickerButton(
                key: UniqueKey(),
                value:
                    opportunityInfo[countryKey]?['name'] ?? 'اختر دولة الفرصة',
                title: 'الدولة',
                onChoose: (value) => setState(() {
                  opportunityInfo.addAll({countryKey: value});
                }),
              ),
              const SizedBox(height: 16.0),
              CityPickerButton(
                key: UniqueKey(),
                value: opportunityInfo[cityKey]?['name'] ?? 'اختر مدينة الفرصة',
                title: 'المدينة',
                onChoose: (value) => setState(() {
                  opportunityInfo.addAll({cityKey: value});
                }),
              ),
              const SizedBox(height: 16.0),
              CustomDatePicker(
                key: UniqueKey(),
                title: 'آخر موعد للتقديم',
                value: opportunityInfo[endDateKey] ?? 'اختر التاريخ',
                onChoose: (date) => setState(() {
                  opportunityInfo.addAll({
                    endDateKey: date,
                  });
                }),
              ),
              const SizedBox(height: 32.0),
              CustomElevatedButton(
                label: 'إضافة الفرصة',
                onPressed: addOpportunity,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
