import 'package:fanar/core/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final String title;
  final String value;
  final void Function(String) onChoose;

  const CustomDatePicker({
    super.key,
    required this.title,
    required this.value,
    required this.onChoose,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showDatePicker(
          context: context,
          firstDate: DateTime.now().add(Duration(days: 1)),
          lastDate: DateTime.now().add(Duration(days: 90)),
        );

        print(result);
        final date = '${result?.year}-${result?.month}-${result?.day}';
        onChoose(date);
      },
      child: CustomTextFormField(
        title: title,
        initialValue: value,
        readOnly: true,
        enabled: false,
      ),
    );
  }
}
