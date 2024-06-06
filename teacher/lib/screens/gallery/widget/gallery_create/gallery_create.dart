import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/buttons/rounded_button.dart';
import 'package:teacher/screens/gallery/widget/gallery_create/bloc/gallery_create_bloc.dart';

import 'gallery_select.dart';

class GalleryCreateNew extends StatefulWidget {
  const GalleryCreateNew({super.key});
  static const routeName = '/gallery_create';

  @override
  State<GalleryCreateNew> createState() => _GalleryCreateNewState();
}

class _GalleryCreateNewState extends State<GalleryCreateNew> {
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
    );
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: galleryCreateBloc,
      child: BlocConsumer<GalleryCreateBloc, GalleryCreateState>(
        listener: (context, state) {
          final status = state.status;
          if (status == GalleryCreateStatus.createSuccess) {
            context.loaderOverlay.hide();
            SnackBarUtils.showFloatingSnackBar(
                context, 'Tạo thư viện ảnh thành công');
            context.pop(true);
          } else if (status == GalleryCreateStatus.createFailure) {
            SnackBarUtils.showFloatingSnackBar(context, state.message);
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          final galleryBloc = context.read<GalleryCreateBloc>();
          final selectedImages = state.selectedImages;
          print('selectedImages: ${selectedImages.length}');

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
              SnackBarUtils.showFloatingSnackBar(
                  context, 'Đã thêm ${tempImages.length} ảnh');
            } else {
              SnackBarUtils.showFloatingSnackBar(
                  context, 'Bạn chưa chọn hình ảnh nào!');
            }
            context.loaderOverlay.hide();
          }

          final listYear = state.listYear;
          final listClass = state.listClass.map((e) => e.className).toList();
          listClass.insert(0, 'Chọn lớp');

          return BackGroundContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenAppBar(
                  title: 'Tạo thư viện ảnh mới',
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
                          TitleAndInputText(
                            title: 'Tên thư viện',
                            titleStyle: AppTextStyles.semiBold16(
                              color: AppColors.gray700,
                            ),
                            onChanged: (value) {
                              nameAlbum.text = value;
                            },
                            isValid: true,
                            focusNode: _focusNode,
                            hintText: 'Nhập tên thư viện ảnh mới',
                            onTap: () {},
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: GallerySelect(
                              selectedOption: state.selectedYear,
                              onUpdateOption: (String value) {
                                galleryBloc
                                    .add(GalleryCreateSelectYear(year: value));
                              },
                              label: 'Chọn năm học và lớp',
                              optionList: listYear,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            child: GallerySelect(
                              isLoading: state.status ==
                                  GalleryCreateStatus.loadingClass,
                              selectedOption: state.selectedClass.className,
                              onUpdateOption: (String value) {
                                galleryBloc.add(
                                    GalleryCreateSelectClass(className: value));
                              },
                              label: '',
                              optionList: listClass,
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
                              galleryBloc.add(GalleryCreateNewGallery(
                                name: nameAlbum.text,
                              ));
                            },
                            borderRadius: 70,
                            buttonColor: AppColors.primaryRedColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            child: Text(
                              'Tạo mới',
                              style: AppTextStyles.semiBold16(
                                  color: AppColors.white),
                            ),
                          )
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
