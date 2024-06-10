part of 'phone_book_bloc.dart';

enum PhoneBookStatus { init, success, error, loading }

class PhoneBookState extends Equatable {
  final List<PhoneBookStudent> phoneBookStudent;
  final PhoneBookStatus phoneBookStatus;
  final List<PhoneBookTeacher> phoneBookParent;
  const PhoneBookState({
    required this.phoneBookStudent,
    required this.phoneBookParent,
    this.phoneBookStatus = PhoneBookStatus.init,
  });
  @override
  List<Object?> get props =>
      [phoneBookParent, phoneBookStatus, phoneBookStudent];

  PhoneBookState copyWith({
    List<PhoneBookStudent>? phoneBookStudent,
    PhoneBookStatus? phoneBookStatus,
    List<PhoneBookTeacher>? phoneBookParent,
  }) {
    return PhoneBookState(
        phoneBookParent: phoneBookParent ?? this.phoneBookParent,
        phoneBookStudent: phoneBookStudent ?? this.phoneBookStudent,
        phoneBookStatus: phoneBookStatus ?? this.phoneBookStatus);
  }
}
