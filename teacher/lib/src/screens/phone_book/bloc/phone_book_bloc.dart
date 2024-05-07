import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/model/user_info.dart';

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
      : super(PhoneBookState(
            phoneBookTeacher: const [],
            user: userRepository.notSignedIn(),
            phoneBookStudent: const [])) {
    on<GetPhoneBookStudent>(_onGetPhoneBookStudent);
    // on<GetPhoneBookTeacher>(_onGetPhoneBookTeacher);
  }
  // void _onGetPhoneBookTeacher(
  //     GetPhoneBookTeacher event, Emitter<PhoneBookState> emit) async {
  //   emit(state.copyWith(phoneBookStatus: PhoneBookStatus.loading));
  //   final data = await appFetchApiRepo.getPhoneBookTeacher(
  //       pupilId: currentUserBloc.state.user.pupil_id);
  //   emit(state.copyWith(
  //       phoneBookStatus: PhoneBookStatus.success, phoneBookTeacher: data));
  // }

  void _onGetPhoneBookStudent(
      GetPhoneBookStudent event, Emitter<PhoneBookState> emit) async {
    emit(state.copyWith(phoneBookStatus: PhoneBookStatus.loading));
    final data = await appFetchApiRepo.getPhoneBookStudent(
        classId: currentUserBloc.state.user.children.class_id);
    emit(state.copyWith(
        phoneBookStatus: PhoneBookStatus.success, phoneBookStudent: data));
  }
}