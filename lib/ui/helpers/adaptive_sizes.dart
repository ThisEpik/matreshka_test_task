import 'dart:ui';

const _designWidth = 2320.0;
const _designHeight = 1080.0;
const _designAspectRatio = _designWidth / _designHeight;

extension AdaptiveSizes on num {
  double get calc {
    final view = PlatformDispatcher.instance.views.first;

    final width = view.physicalSize.width / view.devicePixelRatio;

    final height = view.physicalSize.height / view.devicePixelRatio;

    final aspectRatio = width / height;

    final scale = aspectRatio >= _designAspectRatio ? height / _designHeight : width / _designWidth;

    return toDouble() * scale;
  }
}
