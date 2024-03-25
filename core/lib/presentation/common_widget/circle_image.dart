import 'dart:math';

import 'package:flutter/material.dart';

import '../../common/utils.dart';
import 'cache_network_image_wrapper.dart';

class CircleImageOutline extends StatelessWidget {
  final double? diameter;
  final String image;
  final Color borderColor;
  final double borderWidth;
  final double padding;
  final Color backgroundColor;
  final bool isVerified;

  const CircleImageOutline({
    Key? key,
    this.diameter,
    required this.image,
    this.borderColor = Colors.white,
    this.borderWidth = 4,
    this.padding = 0,
    this.backgroundColor = Colors.white,
    this.isVerified = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(image),
      height: diameter,
      width: diameter,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(diameter!),
        ),
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        color: backgroundColor,
      ),
      child: Stack(
        children: [
          CircleImage(
            child: image.isEmpty || !image.isLocalUrl
                ? CachedNetworkImageWrapper.avatar(
                    url: image,
                    width: diameter,
                    height: diameter,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    image,
                    width: diameter,
                    height: diameter,
                    fit: BoxFit.cover,
                  ),
          ),
          Visibility(
            visible: isVerified,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFF0767FB),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Icon(Icons.check, color: Colors.white, size: 16)
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CircleImage extends StatelessWidget {
  final Widget child;

  const CircleImage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(clipper: CircleClip(), child: child);
  }
}

class CircleImageVerified extends StatelessWidget {
  final Widget child;
  final bool isVerified;

  const CircleImageVerified({
      Key? key, 
      required this.child,
      this.isVerified = false,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(clipper: CircleClip(), child: child),
          Visibility(
            visible: isVerified,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFF0767FB),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Icon(Icons.check, color: Colors.white, size: 16)
              ),
            ),
          )
      ],
    );
  }
}

class CircleClip extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: min(size.width, size.height) / 2,
    );
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
