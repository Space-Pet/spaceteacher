import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/screens/phone_book/model/list_phone_book.dart';

part 'phone_book_event.dart';
part 'phone_book_state.dart';

class PhoneBookBloc extends Bloc<PhoneBookEvent, PhoneBookState> {
  final AppFetchApiRepository appFetchApiRepo;
  final AppFetchApiRepository appFetchApiRepository;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;
  PhoneBookBloc({
    required this.appFetchApiRepo,
    required this.currentUserBloc,
    required this.userRepository,
    required this.appFetchApiRepository,
  }) : super(
          const PhoneBookState(
            phoneBookParent: [],
            phoneBookStudent: [],
            phoneBookTeacher: [],
          ),
        ) {
    on<GetPhoneBookStudent>(_onGetPhoneBookStudent);
    on<GetPhoneBookTeacher>(_onGetPhoneBookTeacher);
    on<GetListClass>(_onGetListClass);

    add(GetPhoneBookStudent());
  }

  Future<void> _onGetPhoneBookTeacher(
      // TODO bind API teacher
      GetPhoneBookTeacher event,
      Emitter<PhoneBookState> emit) async {
    emit(
      state.copyWith(phoneBookStatus: PhoneBookStatus.loading),
    );
    final data = await appFetchApiRepo.getTeacherListByTeacherId(
      teacherId: currentUserBloc.state.user.teacher_id,
    );

    if (data['status'] != 'success') {
      emit(
        state.copyWith(
          phoneBookStatus: PhoneBookStatus.error,
        ),
      );
    }

    final phoneBookTeacher = data['data']['items']
        .map<PhoneBookTeacher>(
          (e) => PhoneBookTeacher.fromMap(e),
        )
        .toList();

    log(
      'PhoneBookBloc - _onGetPhoneBookTeacher - phoneBookTeacher: ${phoneBookTeacher.toString()}',
    );

    emit(
      state.copyWith(
        phoneBookStatus: PhoneBookStatus.success,
        phoneBookTeacher: phoneBookTeacher,
      ),
    );
  }

  void _onGetPhoneBookStudent(
      GetPhoneBookStudent event, Emitter<PhoneBookState> emit) async {
    emit(state.copyWith(phoneBookStatus: PhoneBookStatus.loading));
    final data = await appFetchApiRepo.getPhoneBookStudent(
      classId: currentUserBloc.state.user.teacher_id,
    );
    log(
      'PhoneBookBloc - _onGetPhoneBookStudent - data: ${data.toString()}',
    );

    emit(
      state.copyWith(
        phoneBookStatus: PhoneBookStatus.success,
        phoneBookStudent: data,
      ),
    );
  }

  Future<void> _onGetListClass(
    GetListClass event,
    Emitter<PhoneBookState> emit,
  ) async {
    emit(state.copyWith(classTeacherStatus: ApiCallStatus.loading));
    try {
      final data = await appFetchApiRepository.getListClassTeacher(
        teacherId: currentUserBloc.state.user.teacher_id,
        schoolId: currentUserBloc.state.user.school_id,
        schoolBrand: currentUserBloc.state.user.school_brand,
      );
      emit(
        state.copyWith(
          classTeacherStatus: ApiCallStatus.success,
          classTeacher: data,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          classTeacherStatus: ApiCallStatus.error,
          classTeacher: [],
        ),
      );
    }
  }
}
