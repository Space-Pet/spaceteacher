part of 'noti_create_bloc.dart';

class NotiCreateState extends Equatable {
  const NotiCreateState({
    this.status = NotiCreateStatus.init,
    this.recipient = NotificationRecipient.all,
    this.listClass = const [],
    required this.selectedClass,
    this.listPupil = const [],
    required this.listPupilId,
    this.initFiles = const [],
    required this.selectedImages,
    required this.selectedFiles,
    this.message = '',
    required this.notiDetail,
  });

  final NotiCreateStatus status;

  final NotificationRecipient recipient;

  final List<ClassTeacher> listClass;
  final ClassTeacher selectedClass;

  final List<PupilInClass> listPupil;
  final List<int> listPupilId;

  final List<File> initFiles;
  final List<File> selectedImages;
  final List<UploadFile> selectedFiles;
  final String message;
  final SentNotiDetail notiDetail;

  @override
  List<Object?> get props => [
        status,
        recipient,
        listClass,
        selectedClass,
        listPupil,
        listPupilId,
        initFiles,
        selectedImages,
        selectedFiles,
        message,
      ];

  NotiCreateState copyWith({
    NotiCreateStatus? status,
    NotificationRecipient? recipient,
    List<ClassTeacher>? listClass,
    List<PupilInClass>? listPupil,
    List<int>? listPupilId,
    ClassTeacher? selectedClass,
    List<File>? initFiles,
    List<File>? selectedImages,
    List<UploadFile>? selectedFiles,
    String? message,
    SentNotiDetail? notiDetail,
  }) {
    return NotiCreateState(
      status: status ?? this.status,
      recipient: recipient ?? this.recipient,
      listClass: listClass ?? this.listClass,
      selectedClass: selectedClass ?? this.selectedClass,
      listPupil: listPupil ?? this.listPupil,
      listPupilId: listPupilId ?? this.listPupilId,
      initFiles: initFiles ?? this.initFiles,
      selectedImages: selectedImages ?? this.selectedImages,
      selectedFiles: selectedFiles ?? this.selectedFiles,
      message: message ?? this.message,
      notiDetail: notiDetail ?? this.notiDetail,
    );
  }
}

enum NotiCreateStatus {
  init,
  loading,
  success,
  failure,
  loadingClass,
  loadingClassSuccess,
  loadingPupil,
  loadingPupilSuccess,
  createSuccess,
  createFailure,
  saveDraftSuccess,
  saveDraftFailure,
  deleteLoading,
  deleteSuccess,
  deleteFailure,
}

enum NotificationRecipient {
  all,
  parent,
  pupil,
}

extension NotificationRecipientExtension on NotificationRecipient {
  String get name {
    switch (this) {
      case NotificationRecipient.all:
        return 'Tất cả';
      case NotificationRecipient.parent:
        return 'Cha mẹ học sinh';
      case NotificationRecipient.pupil:
        return 'Học sinh';
    }
  }

  String get value {
    switch (this) {
      case NotificationRecipient.all:
        return 'pupil_parent';
      case NotificationRecipient.parent:
        return 'parent';
      case NotificationRecipient.pupil:
        return 'pupil';
    }
  }
}
