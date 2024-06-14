part of 'noti_create_bloc.dart';

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

class NotiCreateState extends Equatable {
  const NotiCreateState({
    this.status = NotiCreateStatus.init,
    this.recipient = NotificationRecipient.all,
    this.listClass = const [],
    required this.selectedClass,
    this.listPupil = const [],
    required this.listPupilId,
    required this.selectedImages,
    this.message = '',
  });

  final NotiCreateStatus status;

  final NotificationRecipient recipient;

  final List<NotiClass> listClass;
  final NotiClass selectedClass;

  final List<PupilInClass> listPupil;
  final List<int> listPupilId;

  final List<File> selectedImages;
  final String message;

  @override
  List<Object?> get props => [
        status,
        recipient,
        listClass,
        selectedClass,
        listPupil,
        listPupilId,
        selectedImages,
        message,
      ];

  NotiCreateState copyWith({
    NotiCreateStatus? status,
    NotificationRecipient? recipient,
    List<NotiClass>? listClass,
    List<PupilInClass>? listPupil,
    List<int>? listPupilId,
    NotiClass? selectedClass,
    List<File>? selectedImages,
    String? message,
  }) {
    return NotiCreateState(
      status: status ?? this.status,
      recipient: recipient ?? this.recipient,
      listClass: listClass ?? this.listClass,
      selectedClass: selectedClass ?? this.selectedClass,
      listPupil: listPupil ?? this.listPupil,
      listPupilId: listPupilId ?? this.listPupilId,
      selectedImages: selectedImages ?? this.selectedImages,
      message: message ?? this.message,
    );
  }
}
