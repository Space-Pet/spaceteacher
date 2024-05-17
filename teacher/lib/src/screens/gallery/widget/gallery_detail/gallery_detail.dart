import 'package:flutter/material.dart';

import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';

import 'package:teacher/model/gallery_model.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/src/screens/gallery/widget/gallery_detail/card_gallery_detail.dart';

import 'package:teacher/src/screens/gallery/widget/w_button_action_detail_gallery.dart';
import 'package:core/presentation/extentions/extension_context.dart';

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
  bool _isEnable = false;
  bool _isEdit = false;
  late List<bool> _isChooseList;
  late List<int> selectedIndices;

  @override
  void initState() {
    _isChooseList = List.filled(widget.galleryItem.images?.length ?? 0, false);
    selectedIndices = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreensAppBar(
              widget.galleryItem.name ?? '',
              onBack: () {
                context.pop();
              },
              canGoBack: true,
              actionWidget: _isEnable == true
                  ? ElevatedButton(
                      onPressed: () {
                        _isEnable = !_isEnable;
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1B3A6D),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.rounded20,
                        ),
                      ),
                      child: Text(
                        'Hủy',
                        style: AppTextStyles.semiBold16(
                          color: AppColors.white,
                        ),
                      ))
                  : Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _isEnable = !_isEnable;
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff1B3A6D),
                            shape: RoundedRectangleBorder(
                              borderRadius: AppRadius.rounded20,
                            ),
                          ),
                          child: Text(
                            'Chọn',
                            style: AppTextStyles.semiBold16(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _isEdit = !_isEdit;
                            setState(() {});
                          },
                          icon: CircleAvatar(
                            maxRadius: 20,
                            backgroundColor: AppColors.observationStatusMyObsBG,
                            child: Assets.icons.edit.svg(),
                          ),
                        ),
                      ],
                    ),
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
                        flex: 8,
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
                              return GestureDetector(
                                onTap: () {
                                  if (_isEnable == true) {
                                    setState(() {
                                      _isChooseList[index] =
                                          !_isChooseList[index];
                                    });
                                  }
                                },
                                child: CardGalleryDetail(
                                    index: index,
                                    onChoose: (value) =>
                                        _onChoose(index, value),
                                    isEnable: _isEnable,
                                    isChoose: _isChooseList[index],
                                    galleryModel: widget.galleryItem,
                                    galleryItem: widget
                                            .galleryItem
                                            .images![index]
                                            .urlImageModel
                                            ?.mobile ??
                                        "",
                                    lastIndex:
                                        widget.galleryItem.images?.length ??
                                            0 - 1),
                              );
                            },
                            physics: const AlwaysScrollableScrollPhysics(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonActionDetailGallery(
                                onPressed: () {
                                  _downloadSelectedImages();
                                },
                                title: 'Lưu ảnh',
                                icon: Assets.icons.download
                                    .svg(color: AppColors.white),
                                isEnable: _isEnable,
                              ),
                              ButtonActionDetailGallery(
                                onPressed: () {},
                                title: 'Chia sẻ',
                                icon: Assets.icons.share
                                    .svg(color: AppColors.white),
                                isEnable: _isEnable,
                              ),
                              ButtonActionDetailGallery(
                                onPressed: () {},
                                title: 'Xóa',
                                icon: Assets.icons.trashBin
                                    .svg(color: AppColors.white),
                                isEnable: _isEnable,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onChoose(int index, bool isSelected) {
    setState(() {
      _isChooseList[index] = isSelected;
      if (isSelected) {
        selectedIndices.add(index);
      } else {
        selectedIndices.remove(index);
      }
    });
  }

  void _downloadSelectedImages() {
    final selectedImages = selectedIndices
        .map((index) => widget.galleryItem.images![index])
        .toList();
    // Logic to download the selectedImages
    print('Downloading images: $selectedImages');
  }
}
