import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/buttons/rounded_button.dart';
import 'package:teacher/screens/gallery/screens/create_edit/bloc/gallery_create_bloc.dart';

import '../../widgets/gallery_select.dart';

class GalleryEdit extends StatefulWidget {
  const GalleryEdit({super.key, required this.albumDetail});
  static const routeName = '/gallery_edit';

  final Gallery albumDetail;

  @override
  State<GalleryEdit> createState() => _GalleryEditState();
}

class _GalleryEditState extends State<GalleryEdit> {
  TextEditingController nameAlbum = TextEditingController(text: '');
  final FocusNode _focusNode = FocusNode();
  final picker = ImagePicker();
  late GalleryCreateBloc galleryCreateBloc;

  @override
  initState() {
    super.initState();
    galleryCreateBloc = GalleryCreateBloc(
      context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    )..add(GalleryEditSetValues(albumDetail: widget.albumDetail));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: galleryCreateBloc,
      child: BlocConsumer<GalleryCreateBloc, GalleryCreateState>(
        listener: (context, state) {
          final status = state.status;

          switch (status) {
            case GalleryCreateStatus.deleteImagesFailure:
              SnackBarUtils.showFloatingSnackBar(context, state.message);
              context.loaderOverlay.hide();
              break;

            case GalleryCreateStatus.updateSuccess:
              context.loaderOverlay.hide();
              SnackBarUtils.showFloatingSnackBar(
                  context, 'Cập nhật thành công');
              context.pop(true);
              break;
            case GalleryCreateStatus.updateFailure:
              SnackBarUtils.showFloatingSnackBar(context, state.message);
              context.loaderOverlay.hide();
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          final galleryBloc = context.read<GalleryCreateBloc>();
          final albumDetail = state.albumDetail;
          final isLoading = state.status == GalleryCreateStatus.updateLoading;

          nameAlbum.text = albumDetail.galleryName;

          final selectedImages = state.selectedImages;

          List<File> tempImages = [];

          Future pickImages() async {
            context.loaderOverlay.show();
            final pickedFile = await picker.pickMultiImage(
                imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
            List<XFile> xfilePick = pickedFile;

            if (xfilePick.isNotEmpty) {
              for (var i = 0; i < xfilePick.length; i++) {
                tempImages.add(File(xfilePick[i].path));
              }

              galleryBloc.add(GalleryCreateSelectImages(listImg: tempImages));
            } else {
              SnackBarUtils.showFloatingSnackBar(
                  context, 'Bạn chưa chọn hình ảnh nào!');
            }
            context.loaderOverlay.hide();
          }

          final listYear = state.listYear;
          final listClass = state.listClass.map((e) => e.className).toList();

          return BackGroundContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenAppBar(
                  title: 'Chỉnh sửa ${widget.albumDetail.galleryName}',
                  canGoback: true,
                  onBack: () {
                    context.pop();
                  },
                ),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: AppRadius.roundedTop20,
                      ),
                      child: Column(
                        children: [
                          AppSkeleton(
                            isLoading: isLoading,
                            child: TitleAndInputText(
                              controller: nameAlbum,
                              title: 'Tên thư viện',
                              titleStyle: AppTextStyles.semiBold16(
                                color: AppColors.gray700,
                              ),
                              onChanged: (value) {
                                nameAlbum.text = value;
                              },
                              isValid: true,
                              focusNode: _focusNode,
                              hintText: 'Nhập tên thư viện ảnh',
                              onTap: () {},
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: GallerySelect(
                              isLoading: isLoading,
                              selectedOption: state.selectedYear,
                              onUpdateOption: (String value) {
                                galleryBloc
                                    .add(GalleryCreateSelectYear(year: value));
                              },
                              label: 'Chọn năm học và lớp',
                              title: 'Chọn năm học',
                              optionList: listYear,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            child: GallerySelect(
                              isLoading: isLoading,
                              selectedOption: state.selectedClass.className,
                              onUpdateOption: (String value) {
                                galleryBloc.add(
                                    GalleryCreateSelectClass(className: value));
                              },
                              label: '',
                              optionList: listClass,
                              title: 'Chọn lớp',
                              isFlexibleHeight: true,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ảnh (${selectedImages.length - 1})',
                                  style: AppTextStyles.semiBold16(
                                      color: AppColors.gray700),
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          ),
                          Expanded(
                            child: AppSkeleton(
                              isLoading: isLoading,
                              child: SizedBox(
                                child: selectedImages.isEmpty
                                    ? const SizedBox()
                                    : GridView.builder(
                                        padding: const EdgeInsets.all(0),
                                        itemCount: selectedImages.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 6,
                                          mainAxisSpacing: 6,
                                        ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (index == 0) {
                                            return InkWell(
                                              onTap: () {
                                                pickImages();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: AppColors.gray100,
                                                  border: Border.all(
                                                    color: AppColors.gray200,
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: AppColors.gray600,
                                                    size: 28,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Stack(
                                              children: [
                                                Positioned(
                                                  right: 0,
                                                  left: 0,
                                                  child: Image.file(
                                                    selectedImages[index],
                                                    fit: BoxFit.cover,
                                                    height: 110,
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: InkWell(
                                                    onTap: () {
                                                      galleryBloc.add(
                                                          GalleryRemovetImage(
                                                              index: index));
                                                    },
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: CircleAvatar(
                                                          backgroundColor:
                                                              AppColors.red900,
                                                          maxRadius: 10,
                                                          child: Icon(
                                                            Icons.close_rounded,
                                                            color:
                                                                AppColors.white,
                                                            size: 16,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                              ),
                            ),
                          ),
                          RoundedButton(
                            margin: const EdgeInsets.only(top: 8),
                            onTap: () {
                              if (nameAlbum.text.isEmpty) {
                                SnackBarUtils.showFloatingSnackBar(context,
                                    'Tên thư viện không được để trống!');
                                _focusNode.requestFocus();

                                return;
                              }

                              if (state.selectedClass.className == 'Chọn lớp') {
                                SnackBarUtils.showFloatingSnackBar(
                                    context, 'Bạn chưa chọn lớp!');
                                return;
                              }

                              final listFiles = selectedImages
                                  .where((element) =>
                                      element.path != '' &&
                                      element.path != 'null')
                                  .toList();

                              if (listFiles.isEmpty) {
                                SnackBarUtils.showFloatingSnackBar(
                                    context, 'Bạn chưa chọn ảnh!');
                                return;
                              }
                              context.loaderOverlay.show();

                              galleryBloc.add(GalleryUpdate(
                                name: nameAlbum.text,
                                galleryId: albumDetail.galleryId,
                              ));
                            },
                            borderRadius: 70,
                            buttonColor: AppColors.primaryRedColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            child: Text(
                              'Lưu ',
                              style: AppTextStyles.semiBold16(
                                  color: AppColors.white),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
