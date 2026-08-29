import 'dart:ui';

const _designWidth = 2320.0;
const _designHeight = 1080.0;
const _designAspectRatio = _designWidth / _designHeight;

abstract final class AdaptiveSize {
  static Size _screenSize = const Size(_designWidth, _designHeight);

  static void updateScreenSize(Size size) {
    _screenSize = size;
  }

  static double get scale {
    final aspectRatio = _screenSize.width / _screenSize.height;

    return aspectRatio >= _designAspectRatio
        ? _screenSize.height / _designHeight
        : _screenSize.width / _designWidth;
  }
}

extension AdaptiveSizeExtension on num {
  double get calc {
    return toDouble() * AdaptiveSize.scale;
  }
}
