import 'package:fanar/core/common/controller/supported_country_controller.dart';
import 'package:fanar/core/common/model/supported_country.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportedCountryPickerDialog extends StatefulWidget {
  final List<SupportedCountry> countries;

  const SupportedCountryPickerDialog({
    super.key,
    required this.countries,
  });

  @override
  SupportedCountryPickerDialogState createState() =>
      SupportedCountryPickerDialogState();
}

class SupportedCountryPickerDialogState
    extends State<SupportedCountryPickerDialog> {
  late List<SupportedCountry> filteredCountries;
  final supportedCountryController = Get.find<SupportedCountryController>();
  final TextEditingController _searchController = TextEditingController();
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    filteredCountries = [...widget.countries];
    _searchController.addListener(_filterCountries);
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCountries = widget.countries.where(
        (country) {
          return country.name.toLowerCase().contains(query) ||
              country.phoneCode.toLowerCase().contains(query);
        },
      ).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Color(0xFF222C34),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        child: SizedBox(
          height: 500,
          child: Column(
            children: [
              // Search Bar
              if (!isSearch)
                Text(
                  'أختر الدولة',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (isSearch)
                TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'البحث عن دولة',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              // Country List
              const SizedBox(height: 16.0),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: filteredCountries.length,
                    itemBuilder: (context, index) {
                      final country = filteredCountries[index];
                      return ListTile(
                        textColor: Theme.of(context).colorScheme.secondary,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              country.emoji,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              country.name,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        trailing: Text(
                          country.phoneCode,
                          style: TextStyle(
                            color: Color(0xFF66BB6A),
                            fontSize: 18.0,
                          ),
                        ),
                        onTap: () {
                          supportedCountryController.updateCountry(country.id);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ),
              if (!isSearch)
                IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = !isSearch;
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    color: Color(0xFF66BB6A),
                    size: 36.0,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
