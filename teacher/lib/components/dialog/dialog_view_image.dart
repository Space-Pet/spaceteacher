import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ViewSingleImage extends StatelessWidget {
  const ViewSingleImage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.h,
      decoration: ShapeDecoration(
        color: AppColors.blueGray25,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp')),
                color: AppColors.white,
                border: Border.all(color: AppColors.gray100, width: 2)),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color?>(AppColors.white),
              side: WidgetStateProperty.all<BorderSide>(
                const BorderSide(color: AppColors.gray300),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  style: AppTextStyles.semiBold16(color: AppColors.gray900),
                  'Đóng',
                  textAlign: TextAlign.center,
                )),
          ),
        ],
      ),
    );
  }
}
