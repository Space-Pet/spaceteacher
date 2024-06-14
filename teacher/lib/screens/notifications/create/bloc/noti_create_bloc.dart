import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'noti_create_event.dart';
part 'noti_create_state.dart';

class NotiCreateBloc extends Bloc<NotiCreateEvent, NotiCreateState> {
  NotiCreateBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
  }) : super(NotiCreateState(
          selectedClass: NotiClass.empty(),
          selectedImages: [File('')],
          listPupilId: const [],
        )) {
    on<NotiCreateSelectRecipient>(_onSelectRecipient);

    on<NotiCreateFetchListClass>(_onFetchListClass);
    add(NotiCreateFetchListClass());

    on<NotiCreateSelectClass>(_onSelectClass);

    on<NotiCreateFetchListPupil>(_onFetchListPupil);
    on<NotiCreateSelectPupil>(_onSelectPupil);

    on<NotiCreateSelectImages>(_onSelectImg);
    on<NotiRemovetImage>(_onRemoveImage);

    on<NotiCreateNewNoti>(_onCreateNewNoti);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onSelectRecipient(
      NotiCreateSelectRecipient event, Emitter<NotiCreateState> emit) {
    emit(state.copyWith(recipient: event.recipient));
  }

  _onFetchListClass(
      NotiCreateFetchListClass event, Emitter<NotiCreateState> emit) async {
    emit(state.copyWith(status: NotiCreateStatus.loadingClass));
    final user = currentUserBloc.state.user;

    final listClass = await appFetchApiRepo.getListClassNoti(
      // learnYear: user.learnYear,
      learnYear: '2023-2024',
      teacherId: user.teacher_id,
    );
    emit(state.copyWith(
      listClass: listClass,
      selectedClass: NotiClass.empty(),
      status: NotiCreateStatus.loadingClassSuccess,
    ));
  }

  _onSelectClass(NotiCreateSelectClass event, Emitter<NotiCreateState> emit) {
    final notiClass = state.listClass.firstWhere(
      (element) => element.title == event.className,
    );

    emit(state.copyWith(selectedClass: notiClass));
    add(NotiCreateFetchListPupil());
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

  _onRemoveImage(NotiRemovetImage event, Emitter<NotiCreateState> emit) {
    final newList = state.selectedImages
        .where(
            (element) => element.path != state.selectedImages[event.index].path)
        .toList();
    emit(state.copyWith(selectedImages: newList));
  }

  _onCreateNewNoti(
      NotiCreateNewNoti event, Emitter<NotiCreateState> emit) async {
    final listFiles = state.selectedImages
        .where((element) => element.path != '' && element.path != 'null')
        .toList();

    final listPupilId = state.listPupilId.where((e) => e != 0).toList();

    final res = await appFetchApiRepo.createNewNoti(
        listPupilId: listPupilId,
        classId: state.selectedClass.classId,
        type: state.recipient.value,
        title: event.title,
        content: event.content,
        status: 'active',
        listFiles: listFiles,
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
        selectedClass: NotiClass.empty(),
        status: NotiCreateStatus.createSuccess,
      ));
    } else {
      final errMsg = res['message'] ?? 'Có lỗi xảy ra, vui lòng thử lại sau';

      emit(state.copyWith(
        status: NotiCreateStatus.createFailure,
        message: errMsg,
      ));
    }
  }
}
