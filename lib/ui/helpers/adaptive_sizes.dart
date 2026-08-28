import 'dart:math' as math;
import 'dart:ui';

const _templateWidth = 2320;
const _templateHeight = 1080;

extension AdaptiveSizesInt on int {
  // double get calculateWidth {
  //   final view = PlatformDispatcher.instance.views.first;

  //   final width = view.physicalSize.width / view.devicePixelRatio;

  //   return this / (_templateWidth / width);
  // }

  // double get calculateHeight {
  //   final view = PlatformDispatcher.instance.views.first;

  //   final height = view.physicalSize.height / view.devicePixelRatio;

  //   return this / (_templateHeight / height);
  // }

  // double get calculateFontSize {
  //   final view = PlatformDispatcher.instance.views.first;

  //   final width = view.physicalSize.width / view.devicePixelRatio;
  //   final height = view.physicalSize.height / view.devicePixelRatio;

  //   final widthScale = width / _templateWidth;
  //   final heightScale = height / _templateHeight;

  //   return this * math.min(widthScale, heightScale);
  // }

  double get calculate {
    final view = PlatformDispatcher.instance.views.first;

    final width = view.physicalSize.width / view.devicePixelRatio;
    final height = view.physicalSize.height / view.devicePixelRatio;

    final widthScale = width / _templateWidth;
    final heightScale = height / _templateHeight;

    return this * math.min(widthScale, heightScale);
  }
}

// extension AdaptiveSizesDouble on double {
//   double get calculateWidth {
//     final view = PlatformDispatcher.instance.views.first;

//     final width = view.physicalSize.width / view.devicePixelRatio;

//     return this / (_templateWidth / width);
//   }

//   double get calculateHeight {
//     final view = PlatformDispatcher.instance.views.first;

//     final height = view.physicalSize.height / view.devicePixelRatio;

//     return this / (_templateHeight / height);
//   }
// }
