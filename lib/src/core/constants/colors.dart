library app_colors;

import 'dart:math';

import 'package:flutter/material.dart';

class AppColor {
  // Basic Colors
  static Color black = const Color(0xFF202020);
  static Color white = const Color(0xFFFFFFFF);
  static Color blue = const Color(0xff3483FA);
  static Color lightBlue = const Color(0xffF3F6FC);
  static Color lightBlue2 = const Color.fromRGBO(71, 154, 209, 0.2);
  static Color darkGrey = const Color(0xff737373);
  static Color grey = const Color(0xffD9D9D9);
  static Color lightGrey = const Color(0xffF5F5F5);

  // Other Colors
  static Color purple = const Color(0xffab86ff);
  static Color lightPurple = const Color(0xfff0ecff);
  static Color green = const Color(0xff00A650);
  static Color lightGreen = const Color(0xffd9f2e0);
  static Color orange = const Color(0xffFF7733);
  static Color lightOrange = const Color(0xfffff1eb);
  static Color red = const Color(0xfff23d4f);
  static Color lightRed = const Color.fromARGB(255, 254, 160, 169);

  // Task Stage Colors
  static Color slabDown = const Color(0xFFB3E5FC); // Light Blue
  static Color plateHeigh = const Color(0xFFFFF9C4); // Light Yellow
  static Color roofCover = const Color(0xFFD1C4E9); // Light Purple
  static Color lockUp = const Color(0xFFC8E6C9); // Light Green
  static Color cabinets = const Color(0xFFFFCCBC); // Light Orange
  static Color pci = const Color(0xFFFFCDD2); // Light Red

  // To do list Colors
  static List<Color> todoColors = [
    const Color(0xfFF0ECFF),
    const Color(0xfffbdcf2),
    const Color(0xffdde3fb),
    const Color(0xffFBEADE),
    const Color(0xffC0EDE3),
  ];

  static Color getRandomColor() {
    return todoColors.elementAt(Random().nextInt(todoColors.length));
  }
}
