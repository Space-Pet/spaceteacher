import 'package:flutter/material.dart';

import 'cache_network_image_wrapper.dart';

class ImageTextView extends StatelessWidget {
  const ImageTextView({
    Key? key,
    required this.textTheme,
    required this.content,
    required this.iconRes,
  }) : super(key: key);

  final TextTheme textTheme;
  final String content;
  final String iconRes;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        children: [
          WidgetSpan(
            child: CachedNetworkImageWrapper.item(
              url: iconRes,
              fit: BoxFit.cover,
              width: 20,
              height: 20,
            ),
            alignment: PlaceholderAlignment.middle,
          ),
          const WidgetSpan(
            child: SizedBox(width: 8),
            alignment: PlaceholderAlignment.middle,
          ),
          WidgetSpan(
            child: Text(
              content,
              style: textTheme.bodyText2?.copyWith(fontSize: 14),
            ),
            alignment: PlaceholderAlignment.middle,
          ),
        ],
      ),
    );
  }
}
