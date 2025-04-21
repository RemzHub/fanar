import 'package:fanar/core/common/controller/role_controller.dart';
import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/core/common/widgets/custom_text_form_field.dart';
import 'package:fanar/core/network/custom_http_client.dart';
import 'package:fanar/core/utils/role_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class RolePickerButton extends StatelessWidget {
  final String title;
  final String value;
  final void Function(Map<String, dynamic>) onChoose;

  const RolePickerButton({
    super.key,
    required this.title,
    required this.value,
    required this.onChoose,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoleController>(
      builder: (roleController) {
        switch (roleController.countriesRequestState) {
          case RequestState.loading:
            return CircularProgressIndicator();
          case RequestState.done:
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return RolePickerDialog(
                      title: 'أختر أبرز دور أدائي',
                      searchFieldHint: 'البحث عن دور',
                      list: roleController.roles,
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
            return CustomElevatedButton(
              label: 'تحديث',
              onPressed: () => roleController.fetchRoles(),
            );
        }
      },
    );
  }
}
