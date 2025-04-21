import 'package:fanar/core/common/controller/supported_country_controller.dart';
import 'package:fanar/core/utils/supported_country_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const CustomPhoneField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'رقم الجوال',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        GetBuilder<SupportedCountryController>(
          builder: (countryController) {
            final countries = countryController.countries;
            final country = countryController.country;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    validator: validator,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    maxLength: country.numberLength,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: country.hintText,
                      hintStyle: const TextStyle(color: Colors.white),
                      counterStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 56, 89, 123),
                      prefixIcon: Icon(Icons.phone, color: Colors.white70),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 12.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.clear();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SupportedCountryPickerDialog(
                          countries: countries,
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 120.0,
                    height: 48.0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 56, 89, 123),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        bottomLeft: Radius.circular(12.0),
                      ),
                      border: Border(
                        right: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${country.emoji} ${country.phoneCode}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
