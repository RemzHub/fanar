import 'package:fanar/core/common/controller/country_controller.dart';
import 'package:fanar/core/common/widgets/custom_text_form_field.dart';
import 'package:fanar/core/network/custom_http_client.dart';
import 'package:fanar/core/utils/country_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CountryPickerButton extends StatelessWidget {
  final String title;
  final String value;
  final void Function(Map<String, dynamic>) onChoose;

  const CountryPickerButton({
    super.key,
    required this.title,
    required this.value,
    required this.onChoose,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CountryController>(
      builder: (countryController) {
        switch (countryController.countriesRequestState) {
          case RequestState.loading:
            return CircularProgressIndicator();
          case RequestState.done:
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CountryPickerDialog(
                      title: 'أختر الدولة',
                      searchFieldHint: 'البحث عن دولة',
                      list: countryController.countries,
                      onChoose: onChoose,
                    );
                  },
                );
              },
              child: CustomTextFormField(
                title: title,
                initialValue: value,
                readOnly: true,
                enabled: false,
              ),
            );
          case RequestState.error:
            return Text('حدث خطأ');
        }
      },
    );
  }
}
