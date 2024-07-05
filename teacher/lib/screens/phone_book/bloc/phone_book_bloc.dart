import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

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
          PhoneBookState(
            phoneBookStudent: PhoneBookStudent.fakeData(),
            phoneBookParent: Parent.fakeData(),
            phoneBookTeacher: const [],
            classTeacher: const [],
            seletedClasss: ClassTeacher.empty(),
          ),
        ) {
    on<GetListClass>(_onGetListClass);
    add(GetListClass());

    on<GetPhoneBookStudent>(_onGetPhoneBookStudent);
    on<GetPhoneBookParent>(_onGetPhoneBookParent);
    on<GetPhoneBookTeacher>(_onGetPhoneBookTeacher);
  }

  void _onGetListClass(
    GetListClass event,
    Emitter<PhoneBookState> emit,
  ) async {
    emit(state.copyWith(phoneBookStatus: PhoneBookStatus.loading));

    try {
      final data = await appFetchApiRepository.getListClassTeacher(
        teacherId: currentUserBloc.state.user.teacher_id,
        schoolId: currentUserBloc.state.user.school_id,
        schoolBrand: currentUserBloc.state.user.school_brand,
      );

      emit(
        state.copyWith(
          classTeacher: data,
          seletedClasss: data.isNotEmpty ? data.first : ClassTeacher.empty(),
        ),
      );
      add(GetPhoneBookStudent());
    } catch (e) {
      emit(
        state.copyWith(
          classTeacher: [],
          seletedClasss: ClassTeacher.empty(),
        ),
      );
    }
  }

  void _onGetPhoneBookStudent(
      GetPhoneBookStudent event, Emitter<PhoneBookState> emit) async {
    final data = await appFetchApiRepo.getPhoneBookStudent(
      classId: state.seletedClasss.classId,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );

    emit(state.copyWith(
      phoneBookStudent: data,
      phoneBookStatus: PhoneBookStatus.success,
    ));
    add(GetPhoneBookParent());
  }

  void _onGetPhoneBookParent(
      GetPhoneBookParent event, Emitter<PhoneBookState> emit) async {
    final listParent = await appFetchApiRepo.getPhoneBookParent(
      classId: state.seletedClasss.classId,
      schoolId: currentUserBloc.state.user.school_id,
    );

    emit(state.copyWith(phoneBookParent: listParent));
    add(GetPhoneBookTeacher());
  }

  void _onGetPhoneBookTeacher(
      GetPhoneBookTeacher event, Emitter<PhoneBookState> emit) async {
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

    emit(
      state.copyWith(phoneBookTeacher: phoneBookTeacher),
    );
  }
}
