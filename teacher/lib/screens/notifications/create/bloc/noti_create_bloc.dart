import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:http/http.dart' as http;

part 'noti_create_event.dart';
part 'noti_create_state.dart';

class NotiCreateBloc extends Bloc<NotiCreateEvent, NotiCreateState> {
  NotiCreateBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
  }) : super(NotiCreateState(
          selectedClass: ClassTeacher.empty(),
          selectedFiles: const [],
          selectedImages: [File('')],
          listPupilId: const [],
          notiDetail: SentNotiDetail.empty(),
        )) {
    on<NotiCreateSelectRecipient>(_onSelectRecipient);

    on<NotiCreateFetchListClass>(_onFetchListClass);
    add(NotiCreateFetchListClass());

    on<NotiCreateSelectClass>(_onSelectClass);

    on<NotiCreateFetchListPupil>(_onFetchListPupil);
    on<NotiCreateSelectPupil>(_onSelectPupil);

    on<NotiCreateSelectImages>(_onSelectImg);
    on<NotiCreateSelectFiles>(_onSelectFiles);
    on<NotiRemovetImage>(_onRemoveImage);
    on<NotiRemoveFile>(_onRemoveFile);

    on<NotiCreateNewNoti>(_onCreateNewNoti);
    on<NotiUpdate>(_onUpdateDraftNoti);

    on<NotiFetchDetail>(_onFetchNotiDetail);
    on<NotiDeleteFile>(_onDeleteFile);

    on<NotiDraftDelete>(_onDeleteNoti);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onSelectRecipient(
      NotiCreateSelectRecipient event, Emitter<NotiCreateState> emit) {
    emit(state.copyWith(
      recipient: event.recipient,
    ));
  }

  _onFetchListClass(
      NotiCreateFetchListClass event, Emitter<NotiCreateState> emit) async {
    emit(state.copyWith(status: NotiCreateStatus.loadingClass));
    final user = currentUserBloc.state.user;

    final listClass = await appFetchApiRepo.getListClassTeacher(
      teacherId: user.teacher_id,
      schoolBrand: user.school_brand,
      schoolId: user.school_id,
    );
    emit(state.copyWith(
      listClass: listClass,
      selectedClass: ClassTeacher.empty(),
      // status: NotiCreateStatus.loadingClassSuccess,
    ));
  }

  _onSelectClass(NotiCreateSelectClass event, Emitter<NotiCreateState> emit) {
    final notiClass = state.listClass.firstWhere(
      (element) => element.title == event.className,
    );

    emit(state.copyWith(selectedClass: notiClass));
    if (!event.isFetchClassOnly) {
      add(NotiCreateFetchListPupil());
    }
  }

  _onFetchListPupil(
      NotiCreateFetchListPupil event, Emitter<NotiCreateState> emit) async {
    emit(state.copyWith(status: NotiCreateStatus.loadingPupil));
    final user = currentUserBloc.state.user;

    final headers = {
      'School-Id': user.school_id,
      'School-Brand': user.school_brand,
    };
    final listPupil = await appFetchApiRepo.getPupilInClass(
      classId: state.selectedClass.classId,
      headers: headers,
    );

    emit(state.copyWith(
      listPupil: listPupil,
      listPupilId: [],
      status: NotiCreateStatus.loadingPupilSuccess,
    ));
  }

  _onSelectPupil(NotiCreateSelectPupil event, Emitter<NotiCreateState> emit) {
    emit(state.copyWith(listPupilId: event.listId));
  }

  _onSelectImg(NotiCreateSelectImages event, Emitter<NotiCreateState> emit) {
    emit(state.copyWith(
      selectedImages: [...state.selectedImages, ...event.listImg],
    ));
  }

  _onSelectFiles(NotiCreateSelectFiles event, Emitter<NotiCreateState> emit) {
    emit(state.copyWith(
      selectedFiles: [...state.selectedFiles, ...event.listFile],
    ));
  }

  _onRemoveImage(NotiRemovetImage event, Emitter<NotiCreateState> emit) {
    final newList = state.selectedImages
        .where(
            (element) => element.path != state.selectedImages[event.index].path)
        .toList();
    emit(state.copyWith(selectedImages: newList));
  }

  _onRemoveFile(NotiRemoveFile event, Emitter<NotiCreateState> emit) {
    final newList = state.selectedFiles
        .where((element) =>
            element.file.path != state.selectedFiles[event.index].file.path)
        .toList();
    emit(state.copyWith(selectedFiles: newList));
  }

  _onCreateNewNoti(
      NotiCreateNewNoti event, Emitter<NotiCreateState> emit) async {
    final listImage = state.selectedImages
        .where((element) => element.path != '' && element.path != 'null')
        .toList();

    final listFile = state.selectedFiles.map((e) => e.file).toList();

    final listPupilId = state.listPupilId.where((e) => e != 0).toList();

    final res = await appFetchApiRepo.createNewNoti(
        listPupilId: listPupilId,
        classId: state.selectedClass.classId,
        type: state.recipient.value,
        title: event.title,
        content: event.content,
        status: event.status,
        listFiles: [
          ...listImage,
          ...listFile
        ],
        headers: {
          'School-Id': currentUserBloc.state.user.school_id,
          'School-Brand': currentUserBloc.state.user.school_brand,
        });

    if (res['status'] == 'success') {
      emit(state.copyWith(
        selectedImages: [File('')],
        listClass: [],
        listPupil: [],
        listPupilId: [],
        message: '',
        selectedClass: ClassTeacher.empty(),
        status: event.status == 'draft'
            ? NotiCreateStatus.saveDraftSuccess
            : NotiCreateStatus.createSuccess,
      ));
    } else {
      final errMsg = res['message'] ?? 'Có lỗi xảy ra, vui lòng thử lại sau';

      emit(state.copyWith(
        status: event.status == 'draft'
            ? NotiCreateStatus.saveDraftFailure
            : NotiCreateStatus.createFailure,
        message: errMsg,
      ));
    }
  }

  _onUpdateDraftNoti(NotiUpdate event, Emitter<NotiCreateState> emit) async {
    List<File> listFilesUpdated = [];

    final listImage = state.selectedImages
        .where((element) => element.path != '' && element.path != 'null')
        .toList();
    final attachments = state.initFiles;

    for (final image in listImage) {
      final isExisting =
          attachments.any((attachment) => attachment.path == image.path);
      if (!isExisting) {
        listFilesUpdated.add(image);
      }
    }

    for (final attachment in attachments) {
      final isRemoved = listImage.every((file) => file.path != attachment.path);
      if (isRemoved) {
        final attachmentId = attachment.path.split('/').last.split('.').first;
        add(NotiDeleteFile(
          notificationId: state.notiDetail.notification.id,
          attachmentId: int.parse(attachmentId),
        ));
      }
    }

    final listFiles = state.selectedFiles.map((e) => e.file).toList();
    final otherFiles = state.notiDetail.notification.attachments
        .where((file) => !file.fileType.contains('image'))
        .toList();

    for (final file in listFiles) {
      final isExisting =
          otherFiles.any((attachment) => attachment.url == file.path);
      if (!isExisting) {
        listFilesUpdated.add(file);
      }
    }

    for (final attachment in otherFiles) {
      final isRemoved = listFiles.every((file) => file.path != attachment.url);
      if (isRemoved) {
        add(NotiDeleteFile(
          notificationId: state.notiDetail.notification.id,
          attachmentId: attachment.id,
        ));
      }
    }

    final listPupilId = state.listPupilId.where((e) => e != 0).toList();

    final res = await appFetchApiRepo.updateDraftNoti(
        id: event.id,
        listPupilId: listPupilId,
        classId: state.selectedClass.classId,
        type: state.recipient.value,
        title: event.title,
        content: event.content,
        status: event.status,
        listFiles: listFilesUpdated,
        headers: {
          'School-Id': currentUserBloc.state.user.school_id,
          'School-Brand': currentUserBloc.state.user.school_brand,
        });

    if (res['status'] == 'success') {
      emit(state.copyWith(
        selectedImages: [File('')],
        listClass: [],
        listPupil: [],
        listPupilId: [],
        message: '',
        selectedClass: ClassTeacher.empty(),
        status: event.status == 'draft'
            ? NotiCreateStatus.saveDraftSuccess
            : NotiCreateStatus.createSuccess,
      ));
    } else {
      final errMsg = res['message'] ?? 'Có lỗi xảy ra, vui lòng thử lại sau';

      emit(state.copyWith(
        status: event.status == 'draft'
            ? NotiCreateStatus.saveDraftFailure
            : NotiCreateStatus.createFailure,
        message: errMsg,
      ));
    }
  }

  _onFetchNotiDetail(
      NotiFetchDetail event, Emitter<NotiCreateState> emit) async {
    emit(state.copyWith(status: NotiCreateStatus.loading));

    final user = currentUserBloc.state.user;
    final headers = {
      'School-Id': user.school_id,
      'School-Brand': user.school_brand,
    };

    final notiDetailData = await appFetchApiRepo.getNotiDetailTeacher(
      headers: headers,
      id: event.id,
    );

    add(NotiCreateSelectClass(
      className: notiDetailData.classes.first.title,
      isFetchClassOnly: true,
    ));

    final listPupil = notiDetailData.pupils;

    final imageFiles = await Future.wait(notiDetailData.notification.attachments
        .where((file) => file.fileType.contains('image'))
        .map((attachment) async {
      final response = await http.get(Uri.parse(attachment.url));
      final bytes = response.bodyBytes;
      final tempDir = await getTemporaryDirectory();
      final file = File(
          '${tempDir.path}/${attachment.id}.${attachment.fileType.split('/').last})');
      await file.writeAsBytes(bytes);
      return file;
    }).toList());

    final otherFiles = notiDetailData.notification.attachments
        .where((file) => !file.fileType.contains('image'))
        .map((attachment) => UploadFile(
              name: '${attachment.id}.${attachment.url.split('.').last}',
              file: File(attachment.url),
            ))
        .toList();

    emit(state.copyWith(
      notiDetail: notiDetailData,
      recipient: NotificationRecipient.values.firstWhere(
        (element) => element.value == notiDetailData.notification.entityType,
        orElse: () => NotificationRecipient.all,
      ),
      listPupil: listPupil,
      listPupilId: listPupil
          .where((e) => e.selected == 'selected')
          .toList()
          .map((e) => e.pupilId)
          .toList(),
      selectedImages: [...state.selectedImages, ...imageFiles],
      initFiles: imageFiles,
      selectedFiles: otherFiles,
      status: NotiCreateStatus.success,
    ));
  }

  _onDeleteFile(NotiDeleteFile event, Emitter<NotiCreateState> emit) async {
    final res = await appFetchApiRepo.deleteNotiFile(
      notificationId: event.notificationId,
      attachmentId: event.attachmentId,
    );

    if (res['status'] != 'success') {
      emit(state.copyWith(
        message: 'Có lỗi xảy ra, vui lòng thử lại sau',
        status: NotiCreateStatus.saveDraftFailure,
      ));
    }
  }

  _onDeleteNoti(NotiDraftDelete event, Emitter<NotiCreateState> emit) async {
    emit(state.copyWith(status: NotiCreateStatus.deleteLoading));

    final response = await appFetchApiRepo.deleteNoti(id: event.id);

    if (response['status'] == 'success' && response['code'] == 200) {
      emit(state.copyWith(status: NotiCreateStatus.deleteSuccess));
    } else if (response is Error) {
      emit(state.copyWith(status: NotiCreateStatus.deleteFailure));
    }
  }
}
