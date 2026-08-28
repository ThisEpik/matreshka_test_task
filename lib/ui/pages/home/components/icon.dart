import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';

class HomePageIcon extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool isActive;
  final bool isUnread;
  final void Function() onTap;

  const HomePageIcon({
    super.key,
    required this.iconPath,
    required this.title,
    required this.isActive,
    required this.isUnread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = 72.calculate;
    final buttonSize = 120.calculate;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: Column(
          children: [
            Stack(
              alignment: .center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(
                    isActive ? CustomColors.white.withValues(alpha: 1) : CustomColors.gray,
                    .srcIn,
                  ),
                  width: iconSize,
                  height: iconSize,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Visibility(
                    visible: isUnread,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: CustomColors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              title,
              textAlign: .center,
              style: TextStyle(
                height: 1,
                fontSize: 22.calculate,
                fontWeight: .w400,
                color: isActive ? CustomColors.white : CustomColors.gray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
