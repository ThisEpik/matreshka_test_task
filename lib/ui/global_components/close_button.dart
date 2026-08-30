import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/global_components/circle_button.dart';
import 'package:matreshka_test_task/ui/kit/svg_icons.dart';

class CustomCloseButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomCloseButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCircleButton(
      onTap: onTap,
      iconPath: SvgIconsAssets.close,
    );
  }
}
