import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';

class CustomSvgPicture extends StatelessWidget {
  final String iconPath;
  final Color? color;
  final double? width;
  final double? height;

  const CustomSvgPicture({
    super.key,
    required this.iconPath,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(
        color ?? CustomColors.white,
        .srcIn,
      ),
    );
  }
}
