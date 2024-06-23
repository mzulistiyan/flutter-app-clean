/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/il-finnance.png
  AssetGenImage get ilFinnance =>
      const AssetGenImage('assets/images/il-finnance.png');

  /// File path: assets/images/il-wallet.png
  AssetGenImage get ilWallet =>
      const AssetGenImage('assets/images/il-wallet.png');

  /// File path: assets/images/logo-axis.png
  AssetGenImage get logoAxis =>
      const AssetGenImage('assets/images/logo-axis.png');

  /// File path: assets/images/logo-indoesat.png
  AssetGenImage get logoIndoesat =>
      const AssetGenImage('assets/images/logo-indoesat.png');

  /// File path: assets/images/logo-telkom.png
  AssetGenImage get logoTelkom =>
      const AssetGenImage('assets/images/logo-telkom.png');

  /// File path: assets/images/logo-three.png
  AssetGenImage get logoThree =>
      const AssetGenImage('assets/images/logo-three.png');

  /// File path: assets/images/logo-viapulsa.png
  AssetGenImage get logoViapulsa =>
      const AssetGenImage('assets/images/logo-viapulsa.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        ilFinnance,
        ilWallet,
        logoAxis,
        logoIndoesat,
        logoTelkom,
        logoThree,
        logoViapulsa
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
