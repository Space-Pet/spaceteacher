import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

part 'week_schedule_event.dart';
part 'week_schedule_state.dart';

class WeekScheduleBloc extends Bloc<WeekScheduleEvent, WeekScheduleState> {
  WeekScheduleBloc(
      {required this.appFetchApiRepo,
      required this.currentUserBloc,
      required this.userRepository})
      : super(WeekScheduleState(user: userRepository.notSignedIn())) {
    on<GetWeekSchedule>(_onGetWeekSchedule);
  }
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  void _onGetWeekSchedule(
      GetWeekSchedule event, Emitter<WeekScheduleState> emitter) async {
    emitter(state.copyWith(
        weekScheduleStatus: WeekScheduleStatus.init, date: DateTime.now()));
    final data = await appFetchApiRepo.getWeekSchedule(
      // userKey: currentUserBloc.state.activeChild.user_key,R
      userKey: '0282810220108',
      txtDate: event.txtDate,
    );
    emitter(state.copyWith(
        weekScheduleStatus: WeekScheduleStatus.success,
        weekSchedule: data,
        date: event.date));
  }
}
