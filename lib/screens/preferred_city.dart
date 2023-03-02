import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
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

class _PreferredCityState extends State<PreferredCity>
    with SingleTickerProviderStateMixin {
  String? city;
  TextEditingController _cityTextController = TextEditingController();
  late AnimationController controller;
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
    controller =
        AnimationController(vsync: this, duration: (Duration(seconds: 3)));
    logger.i("...TOTAL${_cityList.length}");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            body: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Lottie.asset(
                'assets/recent_search.json',
                fit: BoxFit.cover,
                repeat: false,
                //     controller: controller, onLoaded: (composition) {
                //   controller.forward();
                // }
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0).r,
                    child: const Text(
                      'Recent Search',
                      style: TextStyle(fontSize: 24.0, color: PRIMARY_COLOR),
                    ),
                  ),
                  if (_cityList.length == 0)
                    Padding(
                      padding: const EdgeInsets.all(40.0).r,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 70.h,
                            ),
                            Lottie.asset('assets/search.json', repeat: false),
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              "Oops!! Looks like you have no recents.",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: PRIMARY_COLOR,
                                fontSize: 22.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
                                              _deleteCity(
                                                  _cityList[index]['id']);
                                            },
                                            child: Icon(Icons.delete))
                                      ]),
                                ),
                              ),
                            ),
                          )),
                    ),
                ],
              ),
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
