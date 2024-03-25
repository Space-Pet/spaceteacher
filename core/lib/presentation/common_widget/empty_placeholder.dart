import 'package:flutter/material.dart';

class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({
    Key? key,
    required this.textTheme,
    required this.title,
    required this.image,
  }) : super(key: key);

  final TextTheme textTheme;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          image,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (89 / 414) * device.width,
          ),
          child: Text(
            title,
            style: textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
