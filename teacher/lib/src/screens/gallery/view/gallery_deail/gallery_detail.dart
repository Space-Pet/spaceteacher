import 'package:flutter/material.dart';

import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';

import 'package:teacher/model/gallery_model.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/src/screens/gallery/widget/gallery_detail/card_gallery_detail.dart';

import 'package:teacher/src/screens/gallery/widget/w_button_action_detail_gallery.dart';
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
  bool _isEnable = false;
  bool _isEdit = false;
  late List<bool> _isChooseList;
  late List<int> selectedIndices;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _isChooseList = List.filled(widget.galleryItem.images?.length ?? 0, false);
    _titleController = TextEditingController(
      text: widget.galleryItem.name ?? "",
    );
    _descriptionController = TextEditingController(
      text:
          "Tham gia Group Facebook Cùng Học Vẽ Online ở đây: https://www.facebook.com/groups/hoctoanonline",
    );
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
                  : _isEdit == false
                      ? Row(
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
                                backgroundColor:
                                    AppColors.observationStatusMyObsBG,
                                child: Assets.icons.edit.svg(),
                              ),
                            ),
                          ],
                        )
                      : null,
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
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: TextField(
                                    controller: _titleController,
                                    enabled: _isEdit,
                                    maxLines: _isEdit == false ? 1 : null,
                                    style: AppTextStyles.semiBold16(
                                        color: AppColors.brand600),
                                    decoration: InputDecoration(
                                      contentPadding: _isEdit == false
                                          ? const EdgeInsets.all(0.0)
                                          : const EdgeInsets.all(5.0),
                                      hintText: 'Nhập tiêu đề',
                                      hintStyle: AppTextStyles.normal14(
                                          color: AppColors.gray600),
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        gapPadding: 0,
                                        borderRadius: AppRadius.rounded10,
                                        borderSide: const BorderSide(
                                          color: AppColors.gray200,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        gapPadding: 0,
                                        borderRadius: AppRadius.rounded10,
                                        borderSide: const BorderSide(
                                          color: AppColors.gray200,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (_isEdit == false)
                                  Flexible(
                                    child: Text(
                                      "(${widget.galleryItem.images?.length})",
                                      style: AppTextStyles.normal14(
                                          color: AppColors.gray600
                                              .withOpacity(0.4)),
                                    ),
                                  )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            // Text(
                            //   "Tham gia Group Facebook Cùng Học Vẽ Online ở đây: https://www.facebook.com/groups/hoctoanonline",
                            //   style: AppTextStyles.normal14(
                            //       color: AppColors.gray600),
                            // ),
                            TextField(
                              controller: _descriptionController,
                              enabled: _isEdit,
                              maxLines: null,
                              style: AppTextStyles.normal14(
                                  color: AppColors.gray600),
                              decoration: InputDecoration(
                                contentPadding: _isEdit == false
                                    ? const EdgeInsets.all(0.0)
                                    : const EdgeInsets.all(5.0),
                                hintText: 'Nhập tiêu đề',
                                hintStyle: AppTextStyles.normal14(
                                    color: AppColors.gray600),
                                disabledBorder: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 0,
                                  borderRadius: AppRadius.rounded10,
                                  borderSide: const BorderSide(
                                    color: AppColors.gray200,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  gapPadding: 0,
                                  borderRadius: AppRadius.rounded10,
                                  borderSide: const BorderSide(
                                    color: AppColors.gray200,
                                  ),
                                ),
                              ),
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
                                      _onChoose(index, _isChooseList[index]);
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
                          child: AnimatedCrossFade(
                            crossFadeState: _isEdit == true
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            firstCurve: Curves.linear,
                            secondCurve: Curves.linear,
                            duration: Durations.short1,
                            secondChild: ElevatedButton(
                              onPressed: () {
                                _isEdit = !_isEdit;
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(2),
                                backgroundColor:
                                    AppColors.observationStatusMyObsBG,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width - 25, 10),
                              ),
                              child: Text(
                                'Lưu',
                                style: AppTextStyles.bold14(
                                    color: AppColors.white),
                              ),
                            ),
                            firstChild: Row(
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
