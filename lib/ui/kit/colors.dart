import 'package:flutter/material.dart';

abstract final class CustomColors {
  /// --------- Colors

  static const transparent = Colors.transparent;
  static const purple = Color.fromRGBO(21, 23, 39, 0.7);
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const white5 = Color.fromRGBO(233, 233, 243, 0.05);
  static const white10 = Color.fromRGBO(233, 233, 243, 0.1);
  static const white40 = Color.fromRGBO(233, 233, 243, 0.4);
  static const white60 = Color.fromRGBO(233, 233, 243, 0.6);
  static const white70 = Color.fromRGBO(233, 233, 243, 0.7);
  static const white100 = Color.fromRGBO(233, 233, 243, 1);
  static const brown = Color.fromRGBO(60, 11, 11, 1);
  static const gray1 = Color.fromRGBO(233, 233, 243, 0.4);
  static const gray2 = Color.fromRGBO(53, 56, 71, 1);
  static const gray3 = Color.fromRGBO(33, 35, 49, 1);
  static const gray4 = Color.fromRGBO(114, 115, 122, 1);
  static const dominant = Color.fromRGBO(35, 36, 41, 1);
  static const red1 = Color.fromRGBO(215, 39, 0, 1);
  static const red2 = Color.fromRGBO(239, 64, 41, 1);
  static const backgroundColor = Color(0xFF2d2e34);
  static const green = Color.fromRGBO(86, 184, 119, 1);
  static const yellow = Color.fromRGBO(255, 209, 73, 1);
  static const dark60 = Color.fromRGBO(24, 25, 31, 0.6);

  /// --------- Gradients

  static const orangeGradient = [
    Color.fromRGBO(214, 58, 38, 1),
    Color.fromRGBO(239, 100, 41, 1),
  ];
  static const yellowGradient1 = [
    Color.fromRGBO(239, 203, 76, 1),
    Color.fromRGBO(222, 128, 41, 1),
  ];
  static const yellowGradient2 = [
    Color.fromRGBO(239, 203, 76, 1),
    Color.fromRGBO(246, 116, 60, 1),
  ];
  static const grayGradient = [
    Color.fromRGBO(41, 41, 44, 1),
    Color.fromRGBO(46, 46, 49, 1),
    Color.fromRGBO(66, 67, 69, 1),
  ];
  static const blueGradient = [
    Color.fromRGBO(34, 36, 49, 1),
    Color.fromRGBO(31, 51, 81, 1),
    Color.fromRGBO(38, 83, 116, 1),
  ];
  static const purpleGradient = [
    Color.fromRGBO(44, 35, 42, 1),
    Color.fromRGBO(74, 36, 66, 1),
    Color.fromRGBO(97, 17, 99, 1),
  ];
  static const darkOrangeGradient = [
    Color.fromRGBO(44, 35, 35, 1),
    Color.fromRGBO(67, 39, 35, 1),
    Color.fromRGBO(122, 44, 0, 1),
  ];
  static const greenGradient = [
    Color.fromRGBO(86, 184, 119, 1),
    Color.fromRGBO(68, 150, 96, 1),
  ];

  /// --------- Shadows

  static const yellowShadow = Color.fromRGBO(255, 138, 0, 0.7);
}
