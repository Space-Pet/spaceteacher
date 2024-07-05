import 'dart:io';

import 'package:core/core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/buttons/rounded_button.dart';
import 'package:teacher/components/dialog/dialog_confirm_delete.dart';
import 'package:teacher/screens/notifications/create/bloc/noti_create_bloc.dart';
import 'package:teacher/screens/notifications/create/noti_multi_select.dart';

class NotiEdit extends StatefulWidget {
  const NotiEdit({
    super.key,
    required this.id,
  });

  static const routeName = '/noti_edit';
  final int id;

  @override
  State<NotiEdit> createState() => _NotiEditState();
}

class _NotiEditState extends State<NotiEdit> {
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
    notiCreateBloc.add(NotiFetchDetail(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: notiCreateBloc,
      child: Material(
        child: BackGroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<NotiCreateBloc, NotiCreateState>(
                listener: (context, state) {
                  if (state.status == NotiCreateStatus.deleteSuccess) {
                    context.pop(true);
                    context.loaderOverlay.hide();
                    SnackBarUtils.showFloatingSnackBar(
                        context, 'Xóa thông báo thành công');
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ScreenAppBar(
                      title: 'Chỉnh sửa thông báo nháp',
                      canGoback: true,
                      onBack: () {
                        context.pop();
                      },
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DialogConfirmDelete(
                              title: 'Xác nhận xóa thông báo này',
                              content: 'Thao tác này không thể hoàn tác',
                              yesText: "Xác nhận",
                              noText: "Đóng",
                              onNo: () {
                                context.pop();
                              },
                              onYes: () {
                                notiCreateBloc.add(
                                  NotiDraftDelete(id: widget.id),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 20, top: 40),
                        child: const Icon(
                          Icons.delete_rounded,
                          color: AppColors.white,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: BlocConsumer<NotiCreateBloc, NotiCreateState>(
                  listener: (context, state) {
                    final status = state.status;
                    switch (status) {
                      case NotiCreateStatus.createSuccess:
                        context.loaderOverlay.hide();
                        SnackBarUtils.showFloatingSnackBar(
                            context, 'Đăng thông báo thành công');
                        context.pop(true);
                        break;

                      case NotiCreateStatus.saveDraftSuccess:
                        context.loaderOverlay.hide();
                        SnackBarUtils.showFloatingSnackBar(
                            context, 'Lưu nháp thông báo thành công');
                        context.pop(true);
                        break;

                      case NotiCreateStatus.saveDraftFailure:
                      case NotiCreateStatus.createFailure:
                        SnackBarUtils.showFloatingSnackBar(
                          context,
                          state.message,
                        );
                        context.loaderOverlay.hide();
                        break;

                      default:
                    }
                  },
                  builder: (context, state) {
                    final notiDetail = state.notiDetail;
                    final isLoading =
                        state.status == NotiCreateStatus.loading ||
                            state.status == NotiCreateStatus.loadingClass ||
                            state.status == NotiCreateStatus.loadingPupil;

                    if (notiDetail.notification.id != 0) {
                      titleNoti.text = notiDetail.notification.title;
                      contentNoti.text = notiDetail.notification.content;
                    }

                    final listRecipient = NotificationRecipient.values
                        .map((e) => e.name)
                        .toList();

                    final recipientSelected = state.recipient;

                    final listClass =
                        state.listClass.map((e) => e.title).toList();

                    final listSelectedPupilId = state.listPupilId;

                    final notiBloc = context.read<NotiCreateBloc>();
                    final selectedImages = state.selectedImages;
                    final selectedFiles = state.selectedFiles;
                    final w = SizeUtils.width;

                    final selectedFileW =
                        List.generate(selectedFiles.length, (index) {
                      final uploadFile = selectedFiles[index];

                      return Container(
                          width: w / 2 - 20,
                          padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.gray100,
                            border: Border.all(
                              color: AppColors.gray100,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.file_present_rounded,
                                color: AppColors.brand600,
                                size: 28,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  uploadFile.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.normal14(
                                    color: AppColors.brand600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  notiBloc.add(NotiRemoveFile(index: index));
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                      backgroundColor: AppColors.red900,
                                      maxRadius: 10,
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: AppColors.white,
                                        size: 14,
                                      )),
                                ),
                              ),
                            ],
                          ));
                    });
                    final totalAttachments =
                        selectedImages.length + selectedFiles.length;

                    void pickAttachment() async {
                      List<UploadFile> tempFiles = [];

                      if (totalAttachments >= 5) {
                        SnackBarUtils.showFloatingSnackBar(
                          context,
                          'Bạn đã đạt đến giới hạn tệp đính kèm!',
                        );
                        return;
                      }

                      final result = await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.custom,
                        allowedExtensions: [
                          'pdf',
                          'doc',
                          'docx',
                          'xls',
                          'xlsx',
                          'ppt',
                          'pptx'
                        ],
                      );
                      if (result != null) {
                        if (result.files.length > 5) {
                          SnackBarUtils.showFloatingSnackBar(
                            context,
                            'Bạn chỉ được chọn tối đa 5 tệp!',
                          );
                        } else {
                          for (var i = 0; i < result.files.length; i++) {
                            final file = File(result.files[i].path!);
                            final fileSize = await file.length();
                            final fileSizeInMb = fileSize / (1024 * 1024);
                            if (fileSizeInMb <= 3) {
                              tempFiles.add(
                                UploadFile(
                                  name: result.files[i].name,
                                  file: file,
                                ),
                              );
                            } else {
                              SnackBarUtils.showFloatingSnackBar(
                                context,
                                'Tệp ${result.files[i].name} quá lớn, vui lòng chọn tệp dưới 3Mb!',
                              );
                            }
                          }
                          if (tempFiles.isNotEmpty) {
                            context.read<NotiCreateBloc>().add(
                                NotiCreateSelectFiles(listFile: tempFiles));
                          }
                        }
                      }
                    }

                    void pickImages() async {
                      if (totalAttachments >= 5) {
                        SnackBarUtils.showFloatingSnackBar(
                          context,
                          'Bạn đã đạt đến giới hạn tệp đính kèm!',
                        );
                        return;
                      }

                      List<File> tempImages = [];

                      context.loaderOverlay.show();
                      final pickedFile = await picker.pickMultiImage(
                        imageQuality: 100,
                        maxHeight: 1000,
                        maxWidth: 1000,
                        limit: 5 - totalAttachments + 1,
                      );
                      List<XFile> xfilePick = pickedFile;

                      if (xfilePick.isNotEmpty) {
                        for (var i = 0; i < xfilePick.length; i++) {
                          tempImages.add(File(xfilePick[i].path));
                        }

                        notiBloc
                            .add(NotiCreateSelectImages(listImg: tempImages));
                        SnackBarUtils.showFloatingSnackBar(
                            context, 'Đã thêm ${tempImages.length} ảnh');
                      } else {
                        SnackBarUtils.showFloatingSnackBar(
                            context, 'Bạn chưa chọn hình ảnh nào!');
                      }
                      context.loaderOverlay.hide();
                    }

                    return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: AppRadius.roundedTop20,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gửi đến',
                                style: AppTextStyles.semiBold14(
                                    color: AppColors.gray700),
                              ),
                              const SizedBox(height: 4),
                              FilterItem(
                                selectedOption: recipientSelected.name,
                                onUpdateOption: (String value) {
                                  notiBloc.add(NotiCreateSelectRecipient(
                                      recipient: NotificationRecipient.values
                                          .firstWhere((element) =>
                                              element.name == value)));
                                },
                                title: 'Gửi thông báo đến',
                                options: listRecipient,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Lớp',
                                style: AppTextStyles.semiBold14(
                                    color: AppColors.gray700),
                              ),
                              const SizedBox(height: 4),
                              FilterItem(
                                isLoading: state.status ==
                                    NotiCreateStatus.loadingClass,
                                selectedOption: state.selectedClass.title,
                                onUpdateOption: (String value) {
                                  notiBloc.add(
                                      NotiCreateSelectClass(className: value));
                                },
                                title: 'Chọn lớp',
                                hintText: 'Chọn lớp',
                                options: listClass,
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
                                      style: AppTextStyles.semiBold14(
                                          color: AppColors.gray700),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () async {
                                  if (state.selectedClass.className == '') {
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
                                controller: titleNoti,
                                paddingTop: 6,
                                titleStyle: AppTextStyles.semiBold14(
                                  color: AppColors.gray700,
                                ),
                                onChanged: (value) {
                                  titleNoti.text = value;
                                },
                                hintText: 'Nhập tên tiêu đề',
                              ),
                              TitleAndInputText(
                                paddingTop: 6,
                                controller: contentNoti,
                                title: 'Nội dung thông báo',
                                titleStyle: AppTextStyles.semiBold14(
                                  color: AppColors.gray700,
                                ),
                                onChanged: (value) {
                                  contentNoti.text = value;
                                },
                                hintText: 'Nhập nội dung thông báo',
                                minLines: 3,
                                isMultipleLines: true,
                              ),
                              AppSkeleton(
                                isLoading: isLoading,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Đính kèm (tối đa 5)',
                                        style: AppTextStyles.semiBold14(
                                            color: AppColors.gray700),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Tệp (Word, Excel, PDF):',
                                            style: AppTextStyles.normal14(
                                              color: AppColors.gray600,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              pickAttachment();
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 4, 10, 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: AppColors.gray100,
                                                border: Border.all(
                                                  color: AppColors.gray200,
                                                ),
                                              ),
                                              child: Text(
                                                'Chọn tệp',
                                                style: AppTextStyles.semiBold14(
                                                  color: AppColors.gray600,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: selectedFileW,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Hình ảnh:',
                                        style: AppTextStyles.normal14(
                                          color: AppColors.gray600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              selectedImages.isEmpty
                                  ? const SizedBox()
                                  : SizedBox(
                                      height:
                                          selectedImages.length > 3 ? 230 : 110,
                                      child: GridView.builder(
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
                              const SizedBox(height: 12),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RoundedButton(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    onTap: () {
                                      if (contentNoti.text.isEmpty) {
                                        SnackBarUtils.showFloatingSnackBar(
                                            context,
                                            'Vui lòng nhập vào nội dung thông báo!');
                                        _focusNode.requestFocus();

                                        return;
                                      }

                                      if (state
                                          .selectedClass.className.isEmpty) {
                                        SnackBarUtils.showFloatingSnackBar(
                                            context, 'Vui lòng chọn lớp!');
                                        return;
                                      }

                                      context.loaderOverlay.show();
                                      notiCreateBloc.add(NotiUpdate(
                                        id: widget.id,
                                        title: titleNoti.text,
                                        content: contentNoti.text,
                                        status: 'draft',
                                      ));
                                    },
                                    borderRadius: 70,
                                    buttonColor: AppColors.gray400,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      'Lưu nháp',
                                      style: AppTextStyles.semiBold16(
                                          color: AppColors.white),
                                    ),
                                  ),
                                  RoundedButton(
                                    onTap: () {
                                      if (contentNoti.text.isEmpty) {
                                        SnackBarUtils.showFloatingSnackBar(
                                            context,
                                            'Vui lòng nhập vào nội dung thông báo!');
                                        _focusNode.requestFocus();

                                        return;
                                      }

                                      if (state.selectedClass.className ==
                                          'Chọn lớp') {
                                        SnackBarUtils.showFloatingSnackBar(
                                            context,
                                            'Vui lòng chọn lớp trước!');
                                        return;
                                      }

                                      context.loaderOverlay.show();
                                      notiCreateBloc.add(NotiUpdate(
                                        id: widget.id,
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
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
