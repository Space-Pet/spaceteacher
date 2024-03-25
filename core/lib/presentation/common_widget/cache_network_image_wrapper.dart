import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/constants.dart';
import '../theme/theme_color.dart';
import 'loading.dart';

class CachedNetworkImageWrapper extends CachedNetworkImage {
  CachedNetworkImageWrapper({
    Key? key,
    required String url,
    double? width,
    double? height,
    BoxFit? fit,
  }) : super(
          key: key,
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => const Loading(
            brightness: Brightness.light,
            radius: 10,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );

  CachedNetworkImageWrapper.avatar({
    Key? key,
    required String url,
    double? width,
    double? height,
    BoxFit? fit,
  }) : super(
          key: key,
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => const Loading(
            brightness: Brightness.light,
            radius: 10,
          ),
          errorWidget: (context, url, error) => SvgPicture.asset(
            coreImageConstant.icUserAvatar,
            width: 40,
            height: 40,
          ),
        );

  CachedNetworkImageWrapper.item({
    Key? key,
    required String url,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) : super(
          key: key,
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          color: color,
          maxHeightDiskCache: 200,
          maxWidthDiskCache: 200,
          placeholder: (context, url) => const Loading(
            brightness: Brightness.light,
            radius: 10,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );

  CachedNetworkImageWrapper.banner({
    Key? key,
    required String url,
    double? width,
    double? height,
    BoxFit? fit,
    int? maxWidthDiskCache,
    int? maxHeightDiskCache,
  }) : super(
          key: key,
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          maxHeightDiskCache: maxHeightDiskCache,
          maxWidthDiskCache: maxWidthDiskCache,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 219, 218, 218),
            highlightColor: const Color.fromARGB(255, 245, 245, 245),
            child: Container(
              color: themeColor.white,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );

  CachedNetworkImageWrapper.background({
    Key? key,
    required String url,
    double? width,
    double? height,
    BoxFit? fit,
  }) : super(
          key: key,
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => const Loading(
            brightness: Brightness.light,
            radius: 10,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
}
