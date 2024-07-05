part of 'noti_detail_bloc.dart';

class NotiDetailState extends Equatable {
  const NotiDetailState({
    required this.notiDetail,
    this.status = NotificationStatus.loading,
    this.imageFiles = const [],
    this.otherFiles = const [],
  });

  final SentNotiDetail notiDetail;
  final NotificationStatus status;
  final List<Attachment> imageFiles;
  final List<Attachment> otherFiles;

  @override
  List<Object?> get props => [notiDetail, status, imageFiles, otherFiles];

  NotiDetailState copyWith({
    SentNotiDetail? notiDetail,
    NotificationStatus? status,
    List<Attachment>? imageFiles,
    List<Attachment>? otherFiles,
  }) {
    return NotiDetailState(
      notiDetail: notiDetail ?? this.notiDetail,
      status: status ?? this.status,
      imageFiles: imageFiles ?? this.imageFiles,
      otherFiles: otherFiles ?? this.otherFiles,
    );
  }
}
