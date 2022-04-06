/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Invisible.svg
  SvgGenImage get invisible => const SvgGenImage('assets/images/Invisible.svg');

  /// File path: assets/images/Logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/images/Logo.svg');

  /// File path: assets/images/Top-left.svg
  SvgGenImage get topLeft => const SvgGenImage('assets/images/Top-left.svg');

  /// File path: assets/images/Top-right.svg
  SvgGenImage get topRight => const SvgGenImage('assets/images/Top-right.svg');

  /// File path: assets/images/Visible.svg
  SvgGenImage get visible => const SvgGenImage('assets/images/Visible.svg');

  /// File path: assets/images/Welcome-icon.svg
  SvgGenImage get welcomeIcon =>
      const SvgGenImage('assets/images/Welcome-icon.svg');

  /// File path: assets/images/app-icon.png
  AssetGenImage get appIcon =>
      const AssetGenImage('assets/images/app-icon.png');

  /// File path: assets/images/empty_state.png
  AssetGenImage get emptyState =>
      const AssetGenImage('assets/images/empty_state.png');

  /// File path: assets/images/krv_nije_voda.png
  AssetGenImage get krvNijeVoda =>
      const AssetGenImage('assets/images/krv_nije_voda.png');

  /// File path: assets/images/profile_placeholder.png
  AssetGenImage get profilePlaceholder =>
      const AssetGenImage('assets/images/profile_placeholder.png');

  /// File path: assets/images/splash-bottom-left.svg
  SvgGenImage get splashBottomLeft =>
      const SvgGenImage('assets/images/splash-bottom-left.svg');

  /// File path: assets/images/splash-bottom-right.svg
  SvgGenImage get splashBottomRight =>
      const SvgGenImage('assets/images/splash-bottom-right.svg');

  /// File path: assets/images/splash-icon.svg
  SvgGenImage get splashIcon =>
      const SvgGenImage('assets/images/splash-icon.svg');

  /// File path: assets/images/splash-top-left.svg
  SvgGenImage get splashTopLeft =>
      const SvgGenImage('assets/images/splash-top-left.svg');

  /// File path: assets/images/splash-top-right.svg
  SvgGenImage get splashTopRight =>
      const SvgGenImage('assets/images/splash-top-right.svg');

  /// File path: assets/images/splash_image_enlarge.png
  AssetGenImage get splashImageEnlarge =>
      const AssetGenImage('assets/images/splash_image_enlarge.png');

  /// File path: assets/images/splash_image_enlarge2.png
  AssetGenImage get splashImageEnlarge2 =>
      const AssetGenImage('assets/images/splash_image_enlarge2.png');

  /// File path: assets/images/stranger_things.png
  AssetGenImage get strangerThings =>
      const AssetGenImage('assets/images/stranger_things.png');

  /// File path: assets/images/the_office.png
  AssetGenImage get theOffice =>
      const AssetGenImage('assets/images/the_office.png');

  /// File path: assets/images/the_office_2x.png
  AssetGenImage get theOffice2x =>
      const AssetGenImage('assets/images/the_office_2x.png');

  /// File path: assets/images/the_office_3x.png
  AssetGenImage get theOffice3x =>
      const AssetGenImage('assets/images/the_office_3x.png');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}
