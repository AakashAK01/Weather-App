import 'package:flutter/material.dart';

class Accessdata extends StatelessWidget {
  late final data;
  late final selectedCityIds;
  late final afterSaved;
  Accessdata(this.data, this.selectedCityIds);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          dynamic item = data[index];
          return DisplayData(
            item,
            selectedCityIds,
            (selectedCityIds.contains(item['id']) == false ? false : true),
            afterSaved,
          );
        });
  }
}

class DisplayData extends StatelessWidget {
  late final cityData;
  late final selectedCityIds;
  late final selectedCity;
  late final callAfterSaved;
  DisplayData(
    this.cityData,
    this.selectedCityIds,
    this.selectedCity,
    this.callAfterSaved,
  );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
