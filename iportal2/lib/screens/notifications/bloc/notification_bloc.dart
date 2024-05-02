import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
  }) : super(NotificationState(notificationData: NotificationData.empty())) {
    on<NotificationFetchData>(_onFetchNotifications);
    add(NotificationFetchData());

    on<NotificationChageViewMode>(_onChangeViewMode);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onFetchNotifications(
      NotificationFetchData event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading));

    final user = currentUserBloc.state.user;
    final headers = {
      'School-Id': user.school_id,
      'School-Brand': user.school_brand,
    };

    final notificationData = await appFetchApiRepo.getNotifications(
      headers: headers,
      viewed: event.viewed,
      orderBy: event.orderBy.value,
    );

    emit(state.copyWith(
      notificationData: notificationData,
      status: NotificationStatus.success,
    ));
  }

  _onChangeViewMode(
      NotificationChageViewMode event, Emitter<NotificationState> emit) {
    emit(state.copyWith(viewMode: event.viewed));
    add(NotificationFetchData(viewed: event.viewed.value));
  }
}
