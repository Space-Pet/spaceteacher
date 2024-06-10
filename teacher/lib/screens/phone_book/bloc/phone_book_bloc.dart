import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'phone_book_event.dart';
part 'phone_book_state.dart';

class PhoneBookBloc extends Bloc<PhoneBookEvent, PhoneBookState> {
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;
  PhoneBookBloc(
      {required this.appFetchApiRepo,
      required this.currentUserBloc,
      required this.userRepository})
      : super(const PhoneBookState(
          phoneBookParent: [],
          phoneBookStudent: [],
        )) {
    on<GetPhoneBookStudent>(_onGetPhoneBookStudent);
    on<GetPhoneBookTeacher>(_onGetPhoneBookTeacher);
  }
  void _onGetPhoneBookTeacher(
      // TODO bind API teacher
      GetPhoneBookTeacher event,
      Emitter<PhoneBookState> emit) async {
    emit(state.copyWith(phoneBookStatus: PhoneBookStatus.loading));
    final data = await appFetchApiRepo.getPhoneBookTeacher(
        pupilId: currentUserBloc.state.user.teacher_id);
    emit(state.copyWith(
        phoneBookStatus: PhoneBookStatus.success, phoneBookParent: data));
  }

  void _onGetPhoneBookStudent(
      GetPhoneBookStudent event, Emitter<PhoneBookState> emit) async {
    emit(state.copyWith(phoneBookStatus: PhoneBookStatus.loading));
    final data = await appFetchApiRepo.getPhoneBookStudent(
      classId: currentUserBloc.state.user.teacher_id,
    );
    emit(state.copyWith(
        phoneBookStatus: PhoneBookStatus.success, phoneBookStudent: data));
  }
}
