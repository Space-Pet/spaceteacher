import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class CircleAvaImage extends StatelessWidget {
  const CircleAvaImage({
    super.key,
    required this.urlAva,
    this.width = 40,
    this.height = 40,
  });

  final String urlAva;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        border: Border.all(
          color: AppColors.white,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/default-user.png',
          image: urlAva,
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/default-user.png',
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
