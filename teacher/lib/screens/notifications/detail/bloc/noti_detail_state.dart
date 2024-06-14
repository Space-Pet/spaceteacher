part of 'noti_detail_bloc.dart';

class NotiDetailState extends Equatable {
  const NotiDetailState({
    required this.notiDetail,
    this.status = NotificationStatus.loading,
  });

  final SentNotiDetail notiDetail;
  final NotificationStatus status;

  @override
  List<Object?> get props => [notiDetail, status];

  NotiDetailState copyWith({
    SentNotiDetail? notiDetail,
    NotificationStatus? status,
  }) {
    return NotiDetailState(
      notiDetail: notiDetail ?? this.notiDetail,
      status: status ?? this.status,
    );
  }
}
