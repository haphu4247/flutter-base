import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../shared/utils/utils.dart';

class ImageLoaderPlugin extends StatelessWidget {
  const ImageLoaderPlugin(this.name,
      {super.key,
      this.fit,
      this.folder = AssetsFolder.icons,
      this.color,
      this.height,
      this.width});
  final String name;
  final AssetsFolder folder;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (name.startsWith(IconsType.http.name)) {
      return CachedNetworkImage(
        fit: fit,
        imageUrl: name,
        color: color,
        width: width,
        height: height,
        placeholder: (BuildContext context, String url) => SizedBox(
          height: Utils.height(context, height ?? 24),
          child: Center(
              child:
                  CircularProgressIndicator(color: context.appColors.primary)),
        ),
        errorWidget: (BuildContext context, String url, dynamic error) =>
            _ErrorLoader(fit: fit, size: width),
      );
    } else if (name.endsWith(IconsType.svg.name)) {
      return SvgPicture.asset(
        'assets/${folder.path}/$name',
        fit: fit ?? BoxFit.contain,
        // color: color,
        height: height,
        width: width,
      );
    } else if (name.endsWith(IconsType.png.name) ||
        name.endsWith(IconsType.jpg.name)) {
      return Image.asset(
        'assets/${folder.path}/$name',
        fit: fit,
        color: color,
        height: height,
        width: width,
      );
    } else {
      return _ErrorLoader(fit: fit, size: width);
    }
  }
}

class _ErrorLoader extends StatelessWidget {
  const _ErrorLoader({
    required this.fit,
    required this.size,
  });

  final BoxFit? fit;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.error,
      size: size,
      color: context.appColors.primary,
    );
  }
}

enum IconsType { svg, png, jpg, http }

enum AssetsFolder {
  icons,
  images,
  home,
  settings;

  String get path {
    switch (this) {
      case AssetsFolder.icons:
        return 'icons';
      case AssetsFolder.home:
        return 'icons/home';
      case AssetsFolder.settings:
        return 'icons/settings';
      case AssetsFolder.images:
        return 'images';
    }
  }
}
