import 'package:bloc/bloc.dart';
import 'package:core/presentation/base/base.dart';
import 'package:meta/meta.dart';

import '../interactor/activities_badge_interactor.dart';
import '../repository/activities_badge_repository.dart';

part 'activities_badge_event.dart';
part 'activities_badge_state.dart';

class ActivitiesBadgeBloc
    extends AppBlocBase<ActivitiesBadgeEvent, ActivitiesBadgeState> {
  late final interactor = ActivitiesBadgeInteractorImpl(
    ActivitiesBadgeRepositoryImpl(),
  );

  ActivitiesBadgeBloc() : super(ActivitiesBadgeInitial()) {
    on<GetActivitiesBadgeCountEvent>(_mapGetBadgeCountEvent);
  }

  Future<void> _mapGetBadgeCountEvent(
    GetActivitiesBadgeCountEvent event,
    Emitter<ActivitiesBadgeState> emit,
  ) async {
    final count = await interactor.getBadgeCount();
    if (count != null) {
      emit(
        ActivitiesBadgeInitial(
          unreadBadgeCount: count,
        ),
      );
    }
  }
}
