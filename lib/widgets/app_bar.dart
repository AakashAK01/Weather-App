import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_constants.dart';
import '../constants/ui_constant.dart';

class NoTitleAppBar extends StatelessWidget {
  const NoTitleAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              appRouter.pop();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5, top: 24).r,
              child: Icon(
                Icons.chevron_left,
                color: PRIMARY_COLOR,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
