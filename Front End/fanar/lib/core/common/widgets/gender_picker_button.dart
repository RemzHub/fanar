import 'package:fanar/core/common/controller/gender_controller.dart';
import 'package:fanar/core/common/widgets/custom_text_form_field.dart';
import 'package:fanar/core/network/custom_http_client.dart';
import 'package:fanar/core/utils/gender_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class GenderPickerButton extends StatelessWidget {
  final String title;
  final String value;
  final void Function(Map<String, dynamic>) onChoose;

  const GenderPickerButton({
    super.key,
    required this.title,
    required this.value,
    required this.onChoose,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GenderController>(
      builder: (genderController) {
        switch (genderController.gendersRequestState) {
          case RequestState.loading:
            return CircularProgressIndicator();
          case RequestState.done:
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return GenderPickerDialog(
                      title: 'نوع الجنس',
                      searchFieldHint: '',
                      list: genderController.genders,
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
