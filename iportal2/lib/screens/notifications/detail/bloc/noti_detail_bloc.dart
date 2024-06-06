import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/notifications/bloc/notification_bloc.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

part 'noti_detail_event.dart';
part 'noti_detail_state.dart';

class NotiDetailBloc extends Bloc<NotiDetailEvent, NotiDetailState> {
  NotiDetailBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
  }) : super(NotiDetailState(notiDetail: NotificationItem.empty())) {
    on<NotificationFetchDetail>(_onFetchNotiDetail);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onFetchNotiDetail(
      NotificationFetchDetail event, Emitter<NotiDetailState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading));

    final user = currentUserBloc.state.activeChild;
    final headers = {
      'School-Id': user.school_id,
      'School-Brand': user.school_brand,
    };

    final notiDetailData = await appFetchApiRepo.getNotiDetail(
      headers: headers,
      id: event.id,
    );

    emit(state.copyWith(
      notiDetail: notiDetailData,
      status: NotificationStatus.success,
    ));
  }
}
