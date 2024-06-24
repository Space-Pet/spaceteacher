import 'package:core/core.dart';
import 'package:core/data/models/observation_model.dart';
import 'package:repository/repository.dart';

part 'observation_event.dart';
part 'observation_state.dart';

class ObservationBloc extends Bloc<ObservationEvent, ObservationState> {
  ObservationBloc({
    required this.appFetchApiRepo,
    required this.userKey,
    required this.schoolId,
  }) : super(ObservationState(
          datePicked: DateTime.now(),
          observationList: const [],
          datePickedRegistered: DateTime.now(),
          registeredLessonList: const [],
        )) {
    on<TeacherFetched>(_onTeachersFetch);
    add(TeacherFetched());
    on<TeacherSelected>(_onTeacherSelected);

    on<DateChanged>(_onDateChange);
    on<ObservationScheduleFetched>(_onObservationScheduleFetch);
    //
    on<SubjectChanged>(_onSubjectChange);
    on<ClassChanged>(_onClassChange);
    on<InfoChanged>(_onInfoChange);

    on<LessonRegisterPosted>(_onLessonRegisterPosted);

    on<RegisteredDateChanged>(_onRegisteredDateChange);

    on<RegisteredLessonFetch>(_onRegisteredLessonFetch);
    add(RegisteredLessonFetch());

    on<DeleteLessonRegistered>(_deleteRegisteredLesson);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final String userKey;
  final int schoolId;

  Future<void> _onObservationScheduleFetch(
    ObservationScheduleFetched event,
    Emitter<ObservationState> emit,
  ) async {
    final teacherId = state.teacherSelected?.teacherId;

    if (teacherId == null) {
      emit(state.copyWith(status: ObservationStatus.failure));
      return;
    }

    emit(state.copyWith(
      status: ObservationStatus.loading,
      observationList: ObservationData.fakeData(),
    ));

    final observationList = await appFetchApiRepo.getLessonRegister(
      userKey: userKey,
      txtDate: state.datePicked.ddMMyyyyDash,
      schoolId: schoolId,
      teacherId: teacherId,
    );

    await Future.delayed(const Duration(milliseconds: 300));

    emit(
      state.copyWith(
        status: ObservationStatus.success,
        observationList: observationList,
      ),
    );
  }

  Future<void> _onTeachersFetch(
    TeacherFetched event,
    Emitter<ObservationState> emit,
  ) async {
    emit(state.copyWith(status: ObservationStatus.loadingTeachers));
    try {
      final listTeacher =
          await appFetchApiRepo.getTeacherListBySchool(schoolId: schoolId);

      emit(state.copyWith(
        teacherList: listTeacher,
        status: ObservationStatus.successTeachers,
      ));
    } catch (e) {
      emit(state.copyWith(status: ObservationStatus.failureTeachers));
    }
  }

  void _onTeacherSelected(
    TeacherSelected event,
    Emitter<ObservationState> emit,
  ) {
    emit(state.copyWith(
      teacherSelected: event.teacher,
    ));

    add(ObservationScheduleFetched());
  }

  void _onDateChange(
    DateChanged event,
    Emitter<ObservationState> emit,
  ) {
    emit(state.copyWith(datePicked: event.datePicked));
  }

  void _onRegisteredDateChange(
    RegisteredDateChanged event,
    Emitter<ObservationState> emit,
  ) {
    emit(state.copyWith(datePickedRegistered: event.datePicked));

    add(RegisteredLessonFetch());
  }

  void _onSubjectChange(
    SubjectChanged event,
    Emitter<ObservationState> emit,
  ) {
    emit(state.copyWith(selectedSubject: event.subject));
  }

  void _onClassChange(
    ClassChanged event,
    Emitter<ObservationState> emit,
  ) {
    emit(state.copyWith(selectedClass: event.className));
  }

  void _onInfoChange(
    InfoChanged event,
    Emitter<ObservationState> emit,
  ) {
    emit(state.copyWith(selectedInfo: event.info));
  }

  Future<void> _onLessonRegisterPosted(
    LessonRegisterPosted event,
    Emitter<ObservationState> emit,
  ) async {
    emit(state.copyWith(status: ObservationStatus.loadingRegister));

    try {
      final response = await appFetchApiRepo.postLessonRegister(
        userKey: userKey,
        txtDate: state.datePicked.ddMMyyyyDash,
        schoolId: schoolId,
        teacherId: int.parse(event.data.teacherId),
        tietNum: int.parse(event.data.lessonNum),
        classId: int.parse(event.data.classId),
        subjectId: int.parse(event.data.subjectId),
      );

      if (response['status'] == 'Success' &&
          response['lesson_register_id'] != null) {
        emit(state.copyWith(status: ObservationStatus.successRegister));
      } else {
        emit(state.copyWith(status: ObservationStatus.failureRegister));
      }
    } catch (e) {
      emit(state.copyWith(status: ObservationStatus.failureRegister));
    }
  }

  Future<void> _onRegisteredLessonFetch(
    RegisteredLessonFetch event,
    Emitter<ObservationState> emit,
  ) async {
    emit(state.copyWith(
      registeredstatus: ObservationStatus.loadingRegisteredLesson,
      registeredLessonList: RegisteredLesson.fakeData(),
    ));

    final registeredLessonList = await appFetchApiRepo.getLessonRegistered(
      userKey: userKey,
      txtDate: state.datePickedRegistered.ddMMyyyyDash,
    );

    await Future.delayed(const Duration(milliseconds: 300));

    emit(
      state.copyWith(
        registeredstatus: ObservationStatus.successRegisteredLesson,
        registeredLessonList: registeredLessonList,
      ),
    );
  }

  Future<void> _deleteRegisteredLesson(
    DeleteLessonRegistered event,
    Emitter<ObservationState> emit,
  ) async {
    emit(state.copyWith(
      registeredstatus: ObservationStatus.loadingRegisteredLesson,
    ));

    final response = await appFetchApiRepo.deleteLessonRegistered(
      userKey: userKey,
      lessonRegisterId: event.lessonRegisterId,
    );

    if (response['status'] == 'Success' &&
        response['lesson_register_id'] != null) {
      emit(state.copyWith(
        registeredstatus: ObservationStatus.successDelete,
      ));
      add(RegisteredLessonFetch());
    } else {
      emit(state.copyWith(
        registeredstatus: ObservationStatus.failureDelete,
      ));
    }
  }
}
