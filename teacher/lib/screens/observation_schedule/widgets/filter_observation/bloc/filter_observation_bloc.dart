import 'dart:developer';

import 'package:core/core.dart';
import 'package:repository/repository.dart';

part 'filter_observation_event.dart';
part 'filter_observation_state.dart';

class FilterObservationBloc
    extends Bloc<FilterObservationEvent, FilterObservationState> {
  FilterObservationBloc({
    required this.appFetchApiRepo,
    required this.userKey,
    required this.schoolId,
    required this.learnYear,
  }) : super(const FilterObservationState()) {
    on<ListTeacherFetched>(_onListTeacherFetch);
    on<DateChanged>(_onDateChange);
    on<TeacherChanged>(_onTeacherChange);
    on<FilterSubmitted>(_onFilterSubmit);

    add(ListTeacherFetched());
  }

  final AppFetchApiRepository appFetchApiRepo;
  final String userKey;
  final int schoolId;
  final String learnYear;

  void _onDateChange(
    DateChanged event,
    Emitter<FilterObservationState> emit,
  ) {
    emit(
      state.copyWith(
        date: event.date,
      ),
    );
  }

  void _onTeacherChange(
    TeacherChanged event,
    Emitter<FilterObservationState> emit,
  ) {
    emit(
      state.copyWith(
        teacher: event.teacher,
      ),
    );
  }

  void _onFilterSubmit(
    FilterSubmitted event,
    Emitter<FilterObservationState> emit,
  ) {}

  Future<void> _onListTeacherFetch(
    ListTeacherFetched event,
    Emitter<FilterObservationState> emit,
  ) async {
    try {
      final listTeacher = await getListTeacher(schoolId: schoolId);

      emit(
        state.copyWith(
          listTeacher: listTeacher,
        ),
      );
    } catch (e) {
      log('FilterObservationBloc - Exception - $e');
      emit(
        state.copyWith(
          listTeacher: [],
        ),
      );
    }
  }

  Future<List<TeacherItem>> getListTeacher({required int schoolId}) async {
    try {
      final response = await appFetchApiRepo.getTeacherListBySchool(
        schoolId: schoolId,
      );
      if (response['trang_thai'] == true) {
        final listTeacher = response['data']
            .map<TeacherItem>(
              (e) => TeacherItem.fromMap(e),
            )
            .toList();

        return listTeacher;
      } else {
        return [];
      }
    } catch (e) {
      log('FilterObservationBloc - Exception - $e');
      return [];
    }
  }
}
