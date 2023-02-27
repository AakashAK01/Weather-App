import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app_latest/constants/app_constants.dart';
import 'package:weather_app_latest/data/database/app_database.dart';
import 'package:weather_app_latest/routers/router.gr.dart';

import '../constants/ui_constant.dart';
import '../logger.dart';
import '../widgets/app_bar.dart';

class PreferredCity extends StatefulWidget {
  PreferredCity({Key? key}) : super(key: key);

  @override
  State<PreferredCity> createState() => _PreferredCityState();
}

class _PreferredCityState extends State<PreferredCity> {
  String? city;
  TextEditingController _cityTextController = TextEditingController();
  List<Map<String, dynamic>> _cityList = [];
  bool _isLoading = true;

  void _refreshCity() async {
    final data = await CityDatabaseHelper.getCities();
    setState(() {
      _cityList = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshCity();
    logger.i("...TOTAL${_cityList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/iphone.jpg"), fit: BoxFit.cover),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0).r,
                  child: const Text(
                    'Recent Search',
                    style: TextStyle(fontSize: 24.0, color: PRIMARY_COLOR),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _cityList.length,
                    itemBuilder: ((context, index) => InkWell(
                          onTap: (() {
                            appRouter.push(HomePageRoute(
                                recentCity: _cityList[index]['city'],
                                navigated: true));
                            print(_cityList[index]['city']);
                          }),
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            child: ListTile(
                              title: Text(_cityList[index]['city']),
                              trailing: SizedBox(
                                width: 100.w,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            _deleteCity(_cityList[index]['id']);
                                          },
                                          child: Icon(Icons.delete))
                                    ]),
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding EnterCity(int? id) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0).r,
      child: Column(
        children: [
          Container(
            width: 300.w,
            height: 32.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100).r,
              border: Border.all(
                color: PRIMARY_COLOR,
                width: 3.w,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                        hintText: "Enter City",
                      ),
                      controller: _cityTextController,
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200.0, top: 20).r,
            child: ElevatedButton(
                onPressed: () async {
                  if (_cityTextController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Enter City");
                  } else {
                    await _addCity();
                    appRouter.pop(context);
                  }
                },
                child: Text('Add City')),
          )
        ],
      ),
    );
  }

  Future<void> _addCity() async {
    if (_cityList.length < 5) {
      await CityDatabaseHelper.createCity(_cityTextController.text);
      logger.i("...TOTAL${_cityList.length}");
    }
    _refreshCity();
  }

  void _deleteCity(int id) async {
    await CityDatabaseHelper.deleteCity(id);
    Fluttertoast.showToast(msg: "City has been deleted Successfully");
    _refreshCity();
  }
}
