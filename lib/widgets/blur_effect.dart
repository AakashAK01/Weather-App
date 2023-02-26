import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredScreenContainer extends StatelessWidget {
  final Widget child;

  BlurredScreenContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Add your background image or color here
        // In this example, we are using a simple white background
        Container(color: Colors.black),

        // Add the blur effect on top of the background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 55, sigmaY: 55),
          child: Container(color: Colors.transparent),
        ),

        // Add your screen content on top of the blur effect
        child,
      ],
    );
  }
}
