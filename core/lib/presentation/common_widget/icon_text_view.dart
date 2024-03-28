import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconTextView extends StatelessWidget {
  const IconTextView({
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
            child: iconRes.contains('.png')
                ? Image.asset(iconRes)
                : SvgPicture.asset(iconRes),
            alignment: PlaceholderAlignment.middle,
          ),
          const WidgetSpan(
            child: SizedBox(width: 8),
            alignment: PlaceholderAlignment.middle,
          ),
          WidgetSpan(
            child: Text(
              content,
              style: textTheme.bodyMedium?.copyWith(fontSize: 14),
            ),
            alignment: PlaceholderAlignment.middle,
          ),
        ],
      ),
    );
  }
}
