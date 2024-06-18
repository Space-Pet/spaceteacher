import 'package:core/core.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:repository/repository.dart';

part 'week_schedule_event.dart';
part 'week_schedule_state.dart';

class WeekScheduleBloc extends Bloc<WeekScheduleEvent, WeekScheduleState> {
  WeekScheduleBloc(
      {required this.appFetchApiRepo,
      required this.currentUserBloc,
      required this.userRepository})
      : super(WeekScheduleState(
          weekSchedule: WeekSchedule.fakeData(),
        )) {
    on<GetWeekSchedule>(_onGetWeekSchedule);
  }
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  void _onGetWeekSchedule(
      GetWeekSchedule event, Emitter<WeekScheduleState> emitter) async {
    emitter(state.copyWith(
      weekScheduleStatus: WeekScheduleStatus.init,
      date: DateTime.now(),
      weekSchedule: WeekSchedule.fakeData(),
    ));

    final data = await appFetchApiRepo.getWeekSchedule(
      userKey: currentUserBloc.state.user.user_key,
      // userKey: '0282810220108',
      txtDate: event.txtDate,
    );

    emitter(state.copyWith(
      weekScheduleStatus: WeekScheduleStatus.success,
      weekSchedule: data,
      date: event.date,
    ));
  }
}
