import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/buttons/rounded_button.dart';
import 'package:teacher/screens/notifications/create/bloc/noti_create_bloc.dart';
import 'package:teacher/screens/notifications/create/noti_multi_select.dart';

import 'noti_select.dart';

class NotiCreateNew extends StatefulWidget {
  const NotiCreateNew({super.key});
  static const routeName = '/noti_create';

  @override
  State<NotiCreateNew> createState() => _NotiCreateNewState();
}

class _NotiCreateNewState extends State<NotiCreateNew> {
  TextEditingController titleNoti = TextEditingController(text: '');
  TextEditingController contentNoti = TextEditingController(text: '');
  final FocusNode _focusNode = FocusNode();
  final picker = ImagePicker();
  late NotiCreateBloc notiCreateBloc;
  bool isSelectedall = false;

  @override
  initState() {
    super.initState();
    notiCreateBloc = NotiCreateBloc(
      context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    // _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: notiCreateBloc,
      child: BlocConsumer<NotiCreateBloc, NotiCreateState>(
        listener: (context, state) {
          final status = state.status;
          if (status == NotiCreateStatus.createSuccess) {
            context.loaderOverlay.hide();
            SnackBarUtils.showFloatingSnackBar(
                context, 'Đăng thông báo thành công');
            context.pop(true);
          } else if (status == NotiCreateStatus.createFailure) {
            SnackBarUtils.showFloatingSnackBar(context, state.message);
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          final listRecipient =
              NotificationRecipient.values.map((e) => e.name).toList();

          final recipientSelected = state.recipient;

          final listClass = state.listClass.map((e) => e.title).toList();
          listClass.insert(0, 'Chọn lớp');

          final listSelectedPupilId = state.listPupilId;

          ///
          final notiBloc = context.read<NotiCreateBloc>();
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

              notiBloc.add(NotiCreateSelectImages(listImg: tempImages));
              SnackBarUtils.showFloatingSnackBar(
                  context, 'Đã thêm ${tempImages.length} ảnh');
            } else {
              SnackBarUtils.showFloatingSnackBar(
                  context, 'Bạn chưa chọn hình ảnh nào!');
            }
            context.loaderOverlay.hide();
          }

          return Scaffold(
            body: BackGroundContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenAppBar(
                    title: 'Soạn thông báo mới',
                    canGoback: true,
                    onBack: () {
                      context.pop();
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
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
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                child: NotiCreateSelect(
                                  selectedOption: recipientSelected.name,
                                  onUpdateOption: (String value) {
                                    notiBloc.add(NotiCreateSelectRecipient(
                                        recipient: NotificationRecipient.values
                                            .firstWhere((element) =>
                                                element.name == value)));
                                  },
                                  label: 'Gửi thông báo đến',
                                  optionList: listRecipient,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                child: NotiCreateSelect(
                                  isLoading: state.status ==
                                      NotiCreateStatus.loadingClass,
                                  selectedOption: state.selectedClass.title,
                                  onUpdateOption: (String value) {
                                    notiBloc.add(NotiCreateSelectClass(
                                        className: value));
                                  },
                                  label: 'Lớp',
                                  optionList: listClass,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6, bottom: 4),
                                    child: Text(
                                      'Người nhận',
                                      style: AppTextStyles.semiBold16(
                                          color: AppColors.gray700),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () async {
                                  if (state.selectedClass.className ==
                                      'Chọn lớp') {
                                    SnackBarUtils.showFloatingSnackBar(
                                        context, 'Bạn chưa chọn lớp!');
                                    return;
                                  }
                                  final listId = await showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return NotiMultiSelect(
                                          listPupil: state.listPupil,
                                          listSelectedPupilId:
                                              listSelectedPupilId,
                                        );
                                      });
                                  if (listId == null) return;
                                  notiBloc.add(
                                      NotiCreateSelectPupil(listId: listId));
                                },
                                child: Container(
                                  height: 46,
                                  padding: const EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: AppColors.gray300,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (listSelectedPupilId.isNotEmpty)
                                        listSelectedPupilId.contains(0)
                                            ? Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Text(
                                                    'Tất cả',
                                                    style: AppTextStyles
                                                        .semiBold14(
                                                            color: AppColors
                                                                .gray700),
                                                  ),
                                                ),
                                              )
                                            : Expanded(
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: listSelectedPupilId
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final pupil = state
                                                        .listPupil
                                                        .firstWhere(
                                                      (element) =>
                                                          element.pupilId ==
                                                          listSelectedPupilId[
                                                              index],
                                                    );
                                                    return Container(
                                                        margin:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                4, 6, 4, 6),
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                8, 4, 8, 4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .brand600,
                                                          borderRadius:
                                                              AppRadius
                                                                  .rounded24,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            pupil.fullName,
                                                            style: AppTextStyles
                                                                .semiBold12(
                                                              color: AppColors
                                                                  .white,
                                                            ),
                                                          ),
                                                        ));
                                                  },
                                                ),
                                              ),
                                      const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: AppColors.gray600,
                                        size: 28,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TitleAndInputText(
                                title: 'Tiêu đề',
                                paddingTop: 6,
                                titleStyle: AppTextStyles.semiBold16(
                                  color: AppColors.gray700,
                                ),
                                onChanged: (value) {
                                  titleNoti.text = value;
                                },
                                hintText: 'Nhập tên tiêu đề',
                              ),
                              TitleAndInputText(
                                paddingTop: 6,
                                title: 'Nội dung thông báo*',
                                titleStyle: AppTextStyles.semiBold16(
                                  color: AppColors.gray700,
                                ),
                                onChanged: (value) {
                                  contentNoti.text = value;
                                },
                                hintText: 'Nhập nội dung thông báo',
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Đính kèm',
                                      style: AppTextStyles.semiBold16(
                                          color: AppColors.gray700),
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 200,
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
                                                      notiBloc.add(
                                                          NotiRemovetImage(
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
                              RoundedButton(
                                margin: const EdgeInsets.only(top: 8),
                                onTap: () {
                                  if (contentNoti.text.isEmpty) {
                                    SnackBarUtils.showFloatingSnackBar(context,
                                        'Vui lòng nhập vào nội dung thông báo!');
                                    _focusNode.requestFocus();

                                    return;
                                  }

                                  if (state.selectedClass.className ==
                                      'Chọn lớp') {
                                    SnackBarUtils.showFloatingSnackBar(
                                        context, 'Bạn chưa chọn lớp!');
                                    return;
                                  }

                                  context.loaderOverlay.show();
                                  notiCreateBloc.add(NotiCreateNewNoti(
                                    title: titleNoti.text,
                                    content: contentNoti.text,
                                  ));
                                },
                                borderRadius: 70,
                                buttonColor: AppColors.primaryRedColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                child: Text(
                                  'Đăng thông báo',
                                  style: AppTextStyles.semiBold16(
                                      color: AppColors.white),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
