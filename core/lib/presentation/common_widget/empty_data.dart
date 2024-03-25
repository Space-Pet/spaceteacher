import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'cache_network_image_wrapper.dart';

class EmptyData extends StatelessWidget {
  final String message;
  final String? icon;
  final double? iconWidth;
  final double? iconHeight;

  const EmptyData({
    Key? key,
    required this.message,
    this.icon,
    this.iconWidth = 200,
    this.iconHeight = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon,
          const SizedBox(height: 24),
          Text(
            message,
            style: _themeData.textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget get _buildIcon {
    if (icon?.isNotEmpty != true) {
      return const SizedBox();
    }

    if (icon!.contains('http')) {
      return CachedNetworkImageWrapper.item(
        url: icon!,
        width: iconWidth,
        height: iconHeight,
      );
    }
    if (icon!.contains('svg')) {
      return SvgPicture.asset(
        icon!,
        width: iconWidth,
        height: iconHeight,
      );
    }

    return Image.asset(
      icon!,
      width: iconWidth,
      height: iconHeight,
    );
  }
}
