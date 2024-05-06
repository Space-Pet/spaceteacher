part of 'phone_book_bloc.dart';

enum PhoneBookStatus { init, success, error, loading }

class PhoneBookState extends Equatable {
  final List<PhoneBookStudent> phoneBookStudent;
  final PhoneBookStatus phoneBookStatus;
  final UserInfo user;
  final List<PhoneBookTeacher> phoneBookTeacher;
  const PhoneBookState(
      {required this.phoneBookStudent,
      required this.phoneBookTeacher,
      this.phoneBookStatus = PhoneBookStatus.init,
      required this.user});
  @override
  List<Object?> get props =>
      [user, phoneBookTeacher, phoneBookStatus, phoneBookStudent];

  PhoneBookState copyWith({
    List<PhoneBookStudent>? phoneBookStudent,
    PhoneBookStatus? phoneBookStatus,
    List<PhoneBookTeacher>? phoneBookTeacher,
    UserInfo? user,
  }) {
    return PhoneBookState(
        phoneBookTeacher: phoneBookTeacher ?? this.phoneBookTeacher,
        phoneBookStudent: phoneBookStudent ?? this.phoneBookStudent,
        user: user ?? this.user,
        phoneBookStatus: phoneBookStatus ?? this.phoneBookStatus);
  }
}
