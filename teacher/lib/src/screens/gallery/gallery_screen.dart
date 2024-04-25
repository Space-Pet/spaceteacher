import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/gallery/widget/gallery_card/card_gallery.dart';
import 'package:teacher/src/utils/extension_context.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});
  static const routeName = '/gallery';
  @override
  State<GalleryScreen> createState() => GalleryScreenState();
}

class GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'Thư viện ảnh',
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.roundedTop28,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text(
                            "Thư viện ảnh ",
                            style: AppTextStyles.semiBold16(
                                color: AppColors.brand600),
                          ),
                          Text(
                            "(${galleryList.length})",
                            style: AppTextStyles.normal14(
                                color: AppColors.gray600.withOpacity(0.4)),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 222),
                          itemCount: galleryList.length,
                          itemBuilder: (context, index) {
                            return CardGallery(
                              index: index,
                              galleryItem: galleryList[index],
                              lastIndex: galleryList.length - 1,
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
