part of 'phone_book_bloc.dart';

enum PhoneBookStatus { init, success, error, loading }

class PhoneBookState extends Equatable {
  final List<PhoneBookStudent> phoneBookStudent;
  final PhoneBookStatus phoneBookStatus;
  final List<PhoneBookTeacher> phoneBookTeacher;
  const PhoneBookState({
    required this.phoneBookStudent,
    required this.phoneBookTeacher,
    this.phoneBookStatus = PhoneBookStatus.init,
  });
  @override
  List<Object?> get props =>
      [phoneBookTeacher, phoneBookStatus, phoneBookStudent];

  PhoneBookState copyWith({
    List<PhoneBookStudent>? phoneBookStudent,
    PhoneBookStatus? phoneBookStatus,
    List<PhoneBookTeacher>? phoneBookTeacher,
  }) {
    return PhoneBookState(
        phoneBookTeacher: phoneBookTeacher ?? this.phoneBookTeacher,
        phoneBookStudent: phoneBookStudent ?? this.phoneBookStudent,
        phoneBookStatus: phoneBookStatus ?? this.phoneBookStatus);
  }
}
