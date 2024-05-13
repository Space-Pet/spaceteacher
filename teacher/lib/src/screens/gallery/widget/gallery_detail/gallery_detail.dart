import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/model/gallery_model.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/gallery/widget/gallery_detail/card_gallery_detail.dart';
import 'package:teacher/src/utils/extension_context.dart';

class GalleryDetail extends StatefulWidget {
  const GalleryDetail({
    super.key,
    required this.galleryItem,
  });
  final GalleryModel galleryItem;
  static const routeName = '/gallery_detail';
  @override
  State<GalleryDetail> createState() => GalleryDetailState();
}

class GalleryDetailState extends State<GalleryDetail> {
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreensAppBar(
            widget.galleryItem.name ?? '',
            onBack: () {
              context.pop();
            },
            canGoBack: true,
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text(
                                  "${widget.galleryItem.name} ",
                                  style: AppTextStyles.semiBold16(
                                      color: AppColors.brand600),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "(${widget.galleryItem.images?.length})",
                                  style: AppTextStyles.normal14(
                                      color:
                                          AppColors.gray600.withOpacity(0.4)),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            widget.galleryItem.galleryNumber.toString(),
                            style: AppTextStyles.normal14(
                                color: AppColors.gray600),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6),
                          itemCount: widget.galleryItem.images?.length,
                          itemBuilder: (context, index) {
                            return CardGalleryDetail(
                                index: index,
                                galleryModel: widget.galleryItem,
                                galleryItem: widget.galleryItem.images![index]
                                        .urlImageModel?.mobile ??
                                    "",
                                lastIndex:
                                    widget.galleryItem.images?.length ?? 0 - 1);
                          },
                          physics: const AlwaysScrollableScrollPhysics(),
                        ),
                      ),
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
