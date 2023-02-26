import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app_latest/widgets/app_bar.dart';

import '../constants/ui_constant.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NoTitleAppBar(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0).r,
            child: Container(
              width: 320.w,
              height: 300.h,
              decoration: BoxDecoration(
                  color: CONTAINER_COLOR.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10).r),
            ),
          ),
        ],
      ),
    );
  }
}
