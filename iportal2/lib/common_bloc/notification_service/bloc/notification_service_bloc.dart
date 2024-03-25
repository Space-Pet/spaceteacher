import 'package:bloc/bloc.dart';
import 'package:core/presentation/base/base.dart';
import 'package:meta/meta.dart';
import 'package:core/di/di.dart';

import '../interactor/notification_service_interactor.dart';
import '../repository/notification_service_repository.dart';

part 'notification_service_event.dart';
part 'notification_service_state.dart';

class NotificationServiceBloc
    extends AppBlocBase<NotificationServiceEvent, NotificationServiceState> {
  late final interactor = NotificationServiceInteractorImpl(
    NotificationServiceRepositoryImpl(
      injector.get(),
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