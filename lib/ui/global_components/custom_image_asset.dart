import 'package:flutter/material.dart';

class CustomImageAsset extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;

  const CustomImageAsset({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
    );
  }
}
