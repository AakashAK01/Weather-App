import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_latest/routers/router.gr.dart';

import 'constants/app_constants.dart';
import 'network connectivity/cubit/connectivity_cubit_cubit.dart';

//WELCOME TO DEV BRANCH
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ScreenUtilInit(
      designSize: Size(360, 720),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (v, w) {
        return BlocProvider(
          create: (context) => ConnectivityCubit(connectivity: Connectivity()),
          child: MaterialApp.router(
            theme: ThemeData(
              fontFamily: 'Roboto',
            ),
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
          ),
        );
      },
    ),
  );
}
