import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../interactor/notification_service_interactor.dart';
import '../repository/notification_service_repository.dart';

part 'notification_service_event.dart';
part 'notification_service_state.dart';

class NotificationServiceBloc
    extends Bloc<NotificationServiceEvent, NotificationServiceState> {
  late final interactor = NotificationServiceInteractorImpl(
    NotificationServiceRepositoryImpl(

    ),
  );

  NotificationServiceBloc() : super(NotificationServiceInitial()) {
    on<GetBadgeCountEvent>(_mapGetBadgeCountEvent);
  }

  Future<void> _mapGetBadgeCountEvent(
    GetBadgeCountEvent event,
    Emitter<NotificationServiceState> emit,
  ) async {
    final count = await interactor.getBadgeCount();
    if (count != null) {
      emit(
        NotificationServiceInitial(
          unreadBadgeCount: count,
        ),
      );
    }
  }
}