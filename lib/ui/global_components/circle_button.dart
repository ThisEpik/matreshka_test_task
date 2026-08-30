import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/global_components/custom_svg_picture.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';

class CustomCircleButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String iconPath;

  const CustomCircleButton({
    super.key,
    required this.onTap,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.calc,
        height: 100.calc,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.white5,
        ),
        child: Center(
          child: CustomSvgPicture(
            iconPath: iconPath,
            width: 36.calc,
            height: 36.calc,
            color: CustomColors.white100,
          ),
        ),
      ),
    );
  }
}
