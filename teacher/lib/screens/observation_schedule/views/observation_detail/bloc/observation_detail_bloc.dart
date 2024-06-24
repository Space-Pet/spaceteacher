import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:core/data/models/observation_model.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';

part 'observation_detail_event.dart';
part 'observation_detail_state.dart';

class ObservationDetailBloc
    extends Bloc<ObservationDetailEvent, ObservationDetailState> {
  ObservationDetailBloc({
    required this.appFetchApiRepo,
    required this.userKey,
    required this.schoolId,
  }) : super(const ObservationDetailState()) {
    on<ObservationDetailInit>(_onInit);
    on<LessonRegisterPosted>(_onLessonRegisterPosted);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final String userKey;
  final int schoolId;

  void _onInit(
    ObservationDetailInit event,
    Emitter<ObservationDetailState> emit,
  ) {}

  Future<void> _onLessonRegisterPosted(
    LessonRegisterPosted event,
    Emitter<ObservationDetailState> emit,
  ) async {
    emit(state.copyWith(status: ObservationDetailStatus.loading));

    try {
      final response = await appFetchApiRepo.postLessonRegister(
        userKey: userKey,
        txtDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        schoolId: schoolId,
        teacherId: int.parse(event.data.teacherId),
        tietNum: int.parse(event.data.lessonNum),
        classId: int.parse(event.data.classId),
        subjectId: int.parse(event.data.subjectId),
      );

      if (response['status'] == 'Success') {
        emit(state.copyWith(status: ObservationDetailStatus.success));
      } else {
        emit(state.copyWith(status: ObservationDetailStatus.failure));
      }
    } catch (e) {
      Log.e('ObservationDetailBloc - _onLessonRegisterPosted - $e');
      emit(state.copyWith(status: ObservationDetailStatus.failure));
    }
  }
}
