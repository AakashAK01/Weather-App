import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app_latest/widgets/blur_effect.dart';
import 'package:weather_app_latest/constants/app_constants.dart';
import 'package:weather_app_latest/routers/router.gr.dart';

import '../business_logic/home_bloc/weather_data_bloc.dart';
import '../constants/ui_constant.dart';
import '../data/database/app_database.dart';
import '../logger.dart';
import '../network connectivity/cubit/connectivity_cubit_cubit.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.recentCity, this.navigated}) : super(key: key);
  String? recentCity;
  bool? navigated = false;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  FlipCardController? _mainTempcontroller;
  FlipCardController? _feelsTempcontroller;
  FlipCardController? _windcontroller;
  FlipCardController? _visiblecontroller;
  FlipCardController? _aircontroller;
  String? currentCity;
  int _secondsRemaining = 300;

  String search = "";
  double _width = 100;
  double _height = 150;
  Color _color = Colors.green;
  int isday = 1;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
  late Timer _timer;
  final _bloc = WeatherDataBloc();
  @override
  void initState() {
    _mainTempcontroller = FlipCardController();
    _feelsTempcontroller = FlipCardController();
    _windcontroller = FlipCardController();
    _visiblecontroller = FlipCardController();
    _aircontroller = FlipCardController();

    getPermission();
    logger.i(widget.navigated);

    super.initState();
  }

  getPermission() async {
    var _locresult = await Permission.location.request();
    logger.i(_locresult);
    if (_locresult.isGranted) {
      getCurrentCity();
    } else if (_locresult.isDenied) {
      requestPermission();
    } else {
      manualPermission();
    }
  }

  getCurrentCity() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark placemark = placemarks[0];
    //logger.i(placemarks);
    if (widget.navigated == true) {
      print(widget.recentCity);
      setState(() {
        currentCity = widget.recentCity;
      });
      _bloc.init(currentCity ?? "Chennai");
    } else {
      currentCity = placemark.locality;
      logger.i(currentCity);
      _bloc.init(currentCity ?? "Chennai");
    }

    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      setState(() {
        _mainTempcontroller?.toggleCard();
        _feelsTempcontroller?.toggleCard();
        _visiblecontroller?.toggleCard();
        _windcontroller?.toggleCard();
        _aircontroller?.toggleCard();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<WeatherDataBloc, WeatherDataState>(
        listener: (context, state) {
          logger.i(_bloc.weatherDataModel?.current?.isDay);
        },
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                Scaffold(
                  body: _bloc.weatherDataModel?.current?.isDay == 1
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Lottie.asset('assets/morning.json',
                              fit: BoxFit.cover),
                        )
                      : _bloc.weatherDataModel?.current?.isDay == null
                          ? Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: Lottie.asset('assets/background.json',
                                  fit: BoxFit.cover),
                            )
                          : Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: Lottie.asset('assets/night.json',
                                  fit: BoxFit.cover),
                            ),
                ),
                Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SingleChildScrollView(
                      child: Builder(builder: (context) {
                        final _internetState =
                            context.watch<ConnectivityCubit>().state;
                        if (_internetState is ConnectivityConnected) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BlocConsumer<WeatherDataBloc, WeatherDataState>(
                                listener: (context, state) {
                                  if (state is DataError) {
                                    logger.i("Error");
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 15.h),
                                                Text(
                                                  (state.msg),
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: PRIMARY_COLOR,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            content: Stack(
                                              alignment: Alignment.center,
                                              children: <Widget>[
                                                Lottie.asset(
                                                  'assets/no_result.json',
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 24.h),
                                                child: InkWell(
                                                  onTap: () {
                                                    appRouter.pop();
                                                    _searchController.clear();
                                                    search = "";
                                                  },
                                                  child: Container(
                                                    height: 40.h,
                                                    width: 296.w,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r),
                                                      border: Border.all(
                                                          color: PRIMARY_COLOR),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Try Again",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18.sp,
                                                            color:
                                                                PRIMARY_COLOR),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        });
                                  }
                                },
                                bloc: _bloc,
                                builder: (context, state) {
                                  logger.i(state);
                                  if (state is DataLoading) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(top: 180.0).r,
                                      child: Center(
                                          child: Lottie.asset(
                                              "assets/cloud loading.json")),
                                    );
                                  } else {
                                    return Container(
                                        width: ScreenUtil().screenWidth,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            _searchAndFilterBar(),
                                            Text("Today's Weather Condition",
                                                style: TextStyle(
                                                    fontSize: 30.sp,
                                                    color: _bloc
                                                                .weatherDataModel
                                                                ?.current
                                                                ?.isDay ==
                                                            1
                                                        ? PRIMARY_COLOR
                                                        : CONTAINER_COLOR)),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              "${_bloc.weatherDataModel?.current?.condition?.text}",
                                              //_formatTime(_secondsRemaining),
                                              style: TextStyle(
                                                  fontSize: 30.sp,
                                                  color: _bloc
                                                              .weatherDataModel
                                                              ?.current
                                                              ?.isDay ==
                                                          1
                                                      ? PRIMARY_COLOR
                                                      : CONTAINER_COLOR),
                                            ),
                                            if (_bloc.weatherDataModel?.current
                                                    ?.isDay ==
                                                1)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(40.0)
                                                        .r,
                                                child: Lottie.asset(
                                                    "assets/cloudy sunny.json",
                                                    height: 180.h,
                                                    fit: BoxFit.fill),
                                              )
                                            else
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(40.0)
                                                        .r,
                                                child: Lottie.asset(
                                                    "assets/night_icon.json",
                                                    height: 180.h,
                                                    fit: BoxFit.fill),
                                              ),
                                            FlipCard(
                                              controller: _mainTempcontroller,
                                              fill: Fill.fillFront,
                                              direction: FlipDirection.VERTICAL,
                                              side: CardSide.FRONT,
                                              front: SizedBox(
                                                width: 150.w,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "${_bloc.weatherDataModel?.current?.tempC}",
                                                        style: TextStyle(
                                                            fontSize: 40.sp,
                                                            color: _bloc
                                                                        .weatherDataModel
                                                                        ?.current
                                                                        ?.isDay ==
                                                                    1
                                                                ? PRIMARY_COLOR
                                                                : CONTAINER_COLOR)),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                                  bottom: 12)
                                                              .r,
                                                      child: Text(
                                                        '\u00B0C',
                                                        style: TextStyle(
                                                            fontSize: 18.sp,
                                                            color: _bloc
                                                                        .weatherDataModel
                                                                        ?.current
                                                                        ?.isDay ==
                                                                    1
                                                                ? PRIMARY_COLOR
                                                                : CONTAINER_COLOR),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              back: Container(
                                                width: 150.w,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "${_bloc.weatherDataModel?.current?.tempF}",
                                                        style: TextStyle(
                                                            fontSize: 40.sp,
                                                            color: _bloc
                                                                        .weatherDataModel
                                                                        ?.current
                                                                        ?.isDay ==
                                                                    1
                                                                ? PRIMARY_COLOR
                                                                : CONTAINER_COLOR)),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                                  bottom: 12.0)
                                                              .r
                                                              .r,
                                                      child: Text(
                                                        '\u00B0F',
                                                        style: TextStyle(
                                                            fontSize: 18.sp,
                                                            color: _bloc
                                                                        .weatherDataModel
                                                                        ?.current
                                                                        ?.isDay ==
                                                                    1
                                                                ? PRIMARY_COLOR
                                                                : CONTAINER_COLOR),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                      right: 15.0)
                                                  .r,
                                              child: Text(
                                                "${_bloc.weatherDataModel?.location?.name}",
                                                style: TextStyle(
                                                    fontSize: 20.sp,
                                                    color: _bloc
                                                                .weatherDataModel
                                                                ?.current
                                                                ?.isDay ==
                                                            1
                                                        ? PRIMARY_COLOR
                                                        : CONTAINER_COLOR),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                              left: 22.0,
                                                              top: 10)
                                                          .r,
                                                  child: Text(
                                                      "Weather Details:",
                                                      style: TextStyle(
                                                          fontSize: 15.sp,
                                                          color: _bloc
                                                                      .weatherDataModel
                                                                      ?.current
                                                                      ?.isDay ==
                                                                  1
                                                              ? PRIMARY_COLOR
                                                              : CONTAINER_COLOR)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            weatherDetails(),
                                          ],
                                        ));
                                  }
                                },
                              ),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(
                                    top: 85.0, left: 40, right: 40)
                                .r,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 70.h,
                                  ),
                                  Lottie.asset('assets/no_internet.json'),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 48.0).r,
                                    child: Text(
                                      "Looks like, You got Connectivity issue",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: _bloc.weatherDataModel?.current
                                                    ?.isDay ==
                                                1
                                            ? PRIMARY_COLOR
                                            : CONTAINER_COLOR,
                                        fontSize: 22.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  _searchAndFilterBar() {
    return BlocBuilder<WeatherDataBloc, WeatherDataState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(25, 30, 0, 70).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 250.w,
                height: 32.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100).r,
                  border: Border.all(
                    color: _bloc.weatherDataModel?.current?.isDay == 1
                        ? PRIMARY_COLOR
                        : CONTAINER_COLOR,
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
                          autofillHints: [AutofillHints.addressCity],
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z ]")),
                          ],
                          style: TextStyle(
                            color: _bloc.weatherDataModel?.current?.isDay == 1
                                ? PRIMARY_COLOR
                                : CONTAINER_COLOR,
                          ),
                          decoration: InputDecoration.collapsed(
                              hintText: "Search City",
                              hintStyle: TextStyle(
                                  color:
                                      _bloc.weatherDataModel?.current?.isDay ==
                                              1
                                          ? PRIMARY_COLOR
                                          : CONTAINER_COLOR)),
                          controller: _searchController,
                          onChanged: (v) {
                            logger.i(v);

                            search = v;
                          },
                          onSubmitted: (v) {
                            if (search.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please Enter City Name",
                                  fontSize: 16.sp);
                            } else {
                              context
                                  .read<WeatherDataBloc>()
                                  .add(OnSearchClicked(City: search));
                            }
                          },
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0).r,
                      child: Row(
                        children: [
                          InkWell(
                            child: Icon(
                              Icons.replay,
                              size: 22.spMax,
                              color: _bloc.weatherDataModel?.current?.isDay == 1
                                  ? PRIMARY_COLOR
                                  : CONTAINER_COLOR,
                            ),
                            onTap: () {
                              _searchController.clear();
                              setState(() {
                                widget.navigated = false;
                                search = "";
                              });
                              getCurrentCity();
                              _bloc.init(currentCity ?? "Chennai");
                            },
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            child: Icon(
                              Icons.search,
                              size: 22.sp,
                              color: _bloc.weatherDataModel?.current?.isDay == 1
                                  ? PRIMARY_COLOR
                                  : CONTAINER_COLOR,
                            ),
                            onTap: () async {
                              if (search.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please Enter City Name",
                                    fontSize: 16.sp);
                              } else {
                                context
                                    .read<WeatherDataBloc>()
                                    .add(OnSearchClicked(City: search));
                                logger.i(search);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              InkWell(
                onTap: () {
                  appRouter.push(PreferredCityRoute());
                },
                child: Icon(
                  Icons.timelapse,
                  color: _bloc.weatherDataModel?.current?.isDay == 1
                      ? PRIMARY_COLOR
                      : CONTAINER_COLOR,
                ),
              ),
              PopupMenuButton<int>(
                icon: Icon(
                  Icons.more_vert,
                  color: _bloc.weatherDataModel?.current?.isDay == 1
                      ? PRIMARY_COLOR
                      : CONTAINER_COLOR,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r)),
                itemBuilder: (context) => [
                  // PopupMenuItem(
                  //   value: 1,
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.settings),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text("Settings")
                  //     ],
                  //   ),
                  // ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(Icons.chrome_reader_mode),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Change Units")
                      ],
                    ),
                  ),
                ],
                offset: Offset(0, 50),
                color: Colors.white,
                elevation: 2,
                // on selected we show the dialog box
                onSelected: (value) {
                  if (value == 1) {
                    appRouter.push(SettingPageRoute());
                  }
                  if (value == 2) {
                    _mainTempcontroller?.toggleCard();
                    _feelsTempcontroller?.toggleCard();
                    _visiblecontroller?.toggleCard();
                    _windcontroller?.toggleCard();
                    _aircontroller?.toggleCard();

                    // Fluttertoast.showToast(
                    //   msg: "Tap where you need to change the units",
                    //   fontSize: 16.sp,
                    // );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  weatherDetails() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlipCard(
              controller: _feelsTempcontroller,

              fill: Fill
                  .fillFront, // Fill the back side of the card to make in the same size as the front.
              direction: FlipDirection.VERTICAL, // default
              side: CardSide.FRONT,
              front: Container(
                  width: 150.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                      color: CONTAINER_COLOR.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10).r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.thermostat,
                        color: _bloc.weatherDataModel?.current?.isDay == 1
                            ? PRIMARY_COLOR
                            : CONTAINER_COLOR,
                        size: 30.sp,
                      ),
                      Text(
                        "Feels like",
                        style: TextStyle(
                            fontSize: 19.sp,
                            color: _bloc.weatherDataModel?.current?.isDay == 1
                                ? PRIMARY_COLOR
                                : CONTAINER_COLOR),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "  ${(_bloc.weatherDataModel?.current?.tempC)}",
                              style: TextStyle(
                                  fontSize: 19.sp,
                                  color:
                                      _bloc.weatherDataModel?.current?.isDay ==
                                              1
                                          ? PRIMARY_COLOR
                                          : CONTAINER_COLOR),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4).r,
                              child: Text(
                                "\u00B0C",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: _bloc.weatherDataModel?.current
                                                ?.isDay ==
                                            1
                                        ? PRIMARY_COLOR
                                        : CONTAINER_COLOR),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              back: Container(
                  width: 150.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                      color: CONTAINER_COLOR.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10).r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.thermostat,
                        color: _bloc.weatherDataModel?.current?.isDay == 1
                            ? PRIMARY_COLOR
                            : CONTAINER_COLOR,
                        size: 30.sp,
                      ),
                      Text(
                        "Feels like",
                        style: TextStyle(
                            fontSize: 19.sp,
                            color: _bloc.weatherDataModel?.current?.isDay == 1
                                ? PRIMARY_COLOR
                                : CONTAINER_COLOR),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "  ${(_bloc.weatherDataModel?.current?.tempF)}",
                              style: TextStyle(
                                  fontSize: 19.sp,
                                  color:
                                      _bloc.weatherDataModel?.current?.isDay ==
                                              1
                                          ? PRIMARY_COLOR
                                          : CONTAINER_COLOR),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4).r,
                              child: Text(
                                "\u00B0F",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: _bloc.weatherDataModel?.current
                                                ?.isDay ==
                                            1
                                        ? PRIMARY_COLOR
                                        : CONTAINER_COLOR),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            FlipCard(
              controller: _windcontroller,

              fill: Fill
                  .fillFront, // Fill the back side of the card to make in the same size as the front.
              direction: FlipDirection.VERTICAL,
              front: Container(
                width: 150.w,
                height: 100.h,
                decoration: BoxDecoration(
                    color: CONTAINER_COLOR.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10).r),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.air,
                        color: _bloc.weatherDataModel?.current?.isDay == 1
                            ? PRIMARY_COLOR
                            : CONTAINER_COLOR,
                        size: 30.sp,
                      ),
                      Text("Wind",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: _bloc.weatherDataModel?.current?.isDay == 1
                                  ? PRIMARY_COLOR
                                  : CONTAINER_COLOR)),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "  ${(_bloc.weatherDataModel?.current?.windKph)}",
                              style: TextStyle(
                                  fontSize: 19.sp,
                                  color:
                                      _bloc.weatherDataModel?.current?.isDay ==
                                              1
                                          ? PRIMARY_COLOR
                                          : CONTAINER_COLOR),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2).r,
                              child: Text(
                                "km/h",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: _bloc.weatherDataModel?.current
                                                ?.isDay ==
                                            1
                                        ? PRIMARY_COLOR
                                        : CONTAINER_COLOR),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              back: Container(
                width: 150.w,
                height: 100.h,
                decoration: BoxDecoration(
                    color: CONTAINER_COLOR.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10).r),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.air,
                        color: _bloc.weatherDataModel?.current?.isDay == 1
                            ? PRIMARY_COLOR
                            : CONTAINER_COLOR,
                        size: 30.sp,
                      ),
                      Text("Wind",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: _bloc.weatherDataModel?.current?.isDay == 1
                                  ? PRIMARY_COLOR
                                  : CONTAINER_COLOR)),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "  ${(_bloc.weatherDataModel?.current?.windMph)}",
                              style: TextStyle(
                                  fontSize: 19.sp,
                                  color:
                                      _bloc.weatherDataModel?.current?.isDay ==
                                              1
                                          ? PRIMARY_COLOR
                                          : CONTAINER_COLOR),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2).r,
                              child: Text(
                                "m/h",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: _bloc.weatherDataModel?.current
                                                ?.isDay ==
                                            1
                                        ? PRIMARY_COLOR
                                        : CONTAINER_COLOR),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlipCard(
              front: Container(
                  width: 150.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                      color: CONTAINER_COLOR.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10).r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.water_drop_outlined,
                        color: _bloc.weatherDataModel?.current?.isDay == 1
                            ? PRIMARY_COLOR
                            : CONTAINER_COLOR,
                        size: 30,
                      ),
                      Text("Humidity",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: _bloc.weatherDataModel?.current?.isDay == 1
                                  ? PRIMARY_COLOR
                                  : CONTAINER_COLOR)),
                      Container(
                        width: 70,
                        child: Row(
                          children: [
                            Text(
                              "  ${_bloc.weatherDataModel?.current?.humidity}",
                              style: TextStyle(
                                  fontSize: 19.sp,
                                  color:
                                      _bloc.weatherDataModel?.current?.isDay ==
                                              1
                                          ? PRIMARY_COLOR
                                          : CONTAINER_COLOR),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4).r,
                              child: Text(
                                "%",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: _bloc.weatherDataModel?.current
                                                ?.isDay ==
                                            1
                                        ? PRIMARY_COLOR
                                        : CONTAINER_COLOR),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              back: Container(
                  width: 150.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                      color: CONTAINER_COLOR.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10).r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.water_drop_outlined,
                        color: _bloc.weatherDataModel?.current?.isDay == 1
                            ? PRIMARY_COLOR
                            : CONTAINER_COLOR,
                        size: 30,
                      ),
                      Text("Humidity",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: _bloc.weatherDataModel?.current?.isDay == 1
                                  ? PRIMARY_COLOR
                                  : CONTAINER_COLOR)),
                      Container(
                        width: 70,
                        child: Row(
                          children: [
                            Text(
                              "  ${_bloc.weatherDataModel?.current?.humidity}",
                              style: TextStyle(
                                  fontSize: 19.sp,
                                  color:
                                      _bloc.weatherDataModel?.current?.isDay ==
                                              1
                                          ? PRIMARY_COLOR
                                          : CONTAINER_COLOR),
                            ),
                            Text(
                              "%",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color:
                                      _bloc.weatherDataModel?.current?.isDay ==
                                              1
                                          ? PRIMARY_COLOR
                                          : CONTAINER_COLOR),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            FlipCard(
              front: Container(
                width: 150.w,
                height: 100.h,
                decoration: BoxDecoration(
                    color: CONTAINER_COLOR.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10).r),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.sunny,
                        color: _bloc.weatherDataModel?.current?.isDay == 1
                            ? PRIMARY_COLOR
                            : CONTAINER_COLOR,
                        size: 30.sp,
                      ),
                      Text("UV",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: _bloc.weatherDataModel?.current?.isDay == 1
                                  ? PRIMARY_COLOR
                                  : CONTAINER_COLOR)),
                      Text(
                        "${_bloc.weatherDataModel?.current?.uv}",
                        style: TextStyle(
                            fontSize: 19.sp,
                            color: _bloc.weatherDataModel?.current?.isDay == 1
                                ? PRIMARY_COLOR
                                : CONTAINER_COLOR),
                      ),
                    ]),
              ),
              back: Container(
                width: 150.w,
                height: 100.h,
                decoration: BoxDecoration(
                    color: CONTAINER_COLOR.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10).r),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.sunny,
                        color: _bloc.weatherDataModel?.current?.isDay == 1
                            ? PRIMARY_COLOR
                            : CONTAINER_COLOR,
                        size: 30.sp,
                      ),
                      Text("UV",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: _bloc.weatherDataModel?.current?.isDay == 1
                                  ? PRIMARY_COLOR
                                  : CONTAINER_COLOR)),
                      Text(
                        "${_bloc.weatherDataModel?.current?.uv}",
                        style: TextStyle(
                            fontSize: 19.sp,
                            color: _bloc.weatherDataModel?.current?.isDay == 1
                                ? PRIMARY_COLOR
                                : CONTAINER_COLOR),
                      ),
                    ]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlipCard(
              controller: _visiblecontroller,
              fill: Fill
                  .fillFront, // Fill the back side of the card to make in the same size as the front.
              direction: FlipDirection.VERTICAL,
              front: Container(
                width: 150.w,
                height: 100.h,
                decoration: BoxDecoration(
                    color: CONTAINER_COLOR.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10).r),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.remove_red_eye_rounded,
                        color: _bloc.weatherDataModel?.current?.isDay == 1
                            ? PRIMARY_COLOR
                            : CONTAINER_COLOR,
                        size: 30.sp,
                      ),
                      Text("Visibility",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: _bloc.weatherDataModel?.current?.isDay == 1
                                  ? PRIMARY_COLOR
                                  : CONTAINER_COLOR)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "  ${(_bloc.weatherDataModel?.current?.visKm)}",
                            style: TextStyle(
                                fontSize: 19.sp,
                                color:
                                    _bloc.weatherDataModel?.current?.isDay == 1
                                        ? PRIMARY_COLOR
                                        : CONTAINER_COLOR),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1).r,
                            child: Text(
                              "Km",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      _bloc.weatherDataModel?.current?.isDay ==
                                              1
                                          ? PRIMARY_COLOR
                                          : CONTAINER_COLOR),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
              back: Container(
                width: 150.w,
                height: 100.h,
                decoration: BoxDecoration(
                    color: CONTAINER_COLOR.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10).r),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.remove_red_eye_rounded,
                        color: _bloc.weatherDataModel?.current?.isDay == 1
                            ? PRIMARY_COLOR
                            : CONTAINER_COLOR,
                        size: 30.sp,
                      ),
                      Text("Visibility",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: _bloc.weatherDataModel?.current?.isDay == 1
                                  ? PRIMARY_COLOR
                                  : CONTAINER_COLOR)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "  ${(_bloc.weatherDataModel?.current?.visMiles)}",
                            style: TextStyle(
                                fontSize: 19.sp,
                                color:
                                    _bloc.weatherDataModel?.current?.isDay == 1
                                        ? PRIMARY_COLOR
                                        : CONTAINER_COLOR),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1).r,
                            child: Text(
                              "miles",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      _bloc.weatherDataModel?.current?.isDay ==
                                              1
                                          ? PRIMARY_COLOR
                                          : CONTAINER_COLOR),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
            FlipCard(
              controller: _aircontroller,
              fill: Fill
                  .fillFront, // Fill the back side of the card to make in the same size as the front.
              direction: FlipDirection.VERTICAL,
              front: Container(
                width: 150.w,
                height: 100.h,
                decoration: BoxDecoration(
                    color: CONTAINER_COLOR.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10).r),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.wind_power_sharp,
                        color: _bloc.weatherDataModel?.current?.isDay == 1
                            ? PRIMARY_COLOR
                            : CONTAINER_COLOR,
                        size: 30.sp,
                      ),
                      Text("Air Pressure",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: _bloc.weatherDataModel?.current?.isDay == 1
                                  ? PRIMARY_COLOR
                                  : CONTAINER_COLOR)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "  ${(_bloc.weatherDataModel?.current?.pressureIn)}",
                            style: TextStyle(
                                fontSize: 19.sp,
                                color:
                                    _bloc.weatherDataModel?.current?.isDay == 1
                                        ? PRIMARY_COLOR
                                        : CONTAINER_COLOR),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1).r,
                            child: Text(
                              "hPa",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      _bloc.weatherDataModel?.current?.isDay ==
                                              1
                                          ? PRIMARY_COLOR
                                          : CONTAINER_COLOR),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
              back: Container(
                width: 150.w,
                height: 100.h,
                decoration: BoxDecoration(
                    color: CONTAINER_COLOR.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10).r),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.wind_power_sharp,
                        color: _bloc.weatherDataModel?.current?.isDay == 1
                            ? PRIMARY_COLOR
                            : CONTAINER_COLOR,
                        size: 30.sp,
                      ),
                      Text("Air Pressure",
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: _bloc.weatherDataModel?.current?.isDay == 1
                                  ? PRIMARY_COLOR
                                  : CONTAINER_COLOR)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "  ${(_bloc.weatherDataModel?.current?.pressureMb)}",
                            style: TextStyle(
                                fontSize: 19.sp,
                                color:
                                    _bloc.weatherDataModel?.current?.isDay == 1
                                        ? PRIMARY_COLOR
                                        : CONTAINER_COLOR),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1).r,
                            child: Text(
                              "mb",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      _bloc.weatherDataModel?.current?.isDay ==
                                              1
                                          ? PRIMARY_COLOR
                                          : CONTAINER_COLOR),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  requestPermission() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Permission Required"),
            content: Text(
                "Please Allow Permission so that we can get your Location"),
            actions: [
              TextButton(
                  onPressed: () {
                    getPermission();
                    Navigator.of(context).pop();
                  },
                  child: Text("Okay"))
            ],
          );
        });
  }

  manualPermission() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Permission Required"),
            content: Text(
                "Please Allow Permission so that we can get your Location"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        openAppSettings();
                      },
                      child: Text("Open App Settings")),
                  TextButton(
                      onPressed: () {
                        getPermission();
                        // AppRouter().pop(context);
                        Navigator.of(context).pop(true);
                      },
                      child: Text("Retry")),
                ],
              )
            ],
          );
        });
  }
}
