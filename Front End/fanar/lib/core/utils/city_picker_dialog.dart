import 'package:fanar/core/common/model/city.dart';
import 'package:flutter/material.dart';

class CityPickerDialog extends StatefulWidget {
  final String title;
  final String searchFieldHint;
  final List<City> list;
  final void Function(Map<String, dynamic>) onChoose;

  const CityPickerDialog({
    super.key,
    required this.title,
    required this.searchFieldHint,
    required this.list,
    required this.onChoose,
  });

  @override
  CountryPickerDialogState createState() => CountryPickerDialogState();
}

class CountryPickerDialogState extends State<CityPickerDialog> {
  late List<City> filteredList;
  final TextEditingController _searchController = TextEditingController();
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    filteredList = [...widget.list];
    _searchController.addListener(_filterList);
  }

  void _filterList() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredList = widget.list.where(
        (country) {
          return country.name.toLowerCase().contains(query);
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
                  widget.title,
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
                    hintText: widget.searchFieldHint,
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
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final country = filteredList[index];
                      return ListTile(
                        textColor: Theme.of(context).colorScheme.secondary,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
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
                          country.id.toString(),
                          style: TextStyle(
                            color: Color(0xFF66BB6A),
                            fontSize: 18.0,
                          ),
                        ),
                        onTap: () {
                          widget.onChoose({
                            'id': country.id,
                            'name': country.name,
                          });
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
