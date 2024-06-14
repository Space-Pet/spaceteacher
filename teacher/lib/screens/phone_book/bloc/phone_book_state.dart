part of 'phone_book_bloc.dart';

enum PhoneBookStatus { init, success, error, loading }

enum ApiCallStatus { init, loading, success, error }

class PhoneBookState extends Equatable {
  final List<PhoneBookStudent> phoneBookStudent;
  final PhoneBookStatus phoneBookStatus;
  final List<PhoneBook> phoneBookParent;
  final List<PhoneBookTeacher> phoneBookTeacher;
  final List<ClassTeacher> classTeacher;
  final ApiCallStatus classTeacherStatus;

  const PhoneBookState({
    this.phoneBookStatus = PhoneBookStatus.init,
    required this.phoneBookStudent,
    required this.phoneBookParent,
    required this.phoneBookTeacher,
    this.classTeacher = const [],
    this.classTeacherStatus = ApiCallStatus.init,
  });
  @override
  List<Object?> get props => [
        phoneBookStatus,
        phoneBookParent,
        phoneBookStudent,
        phoneBookTeacher,
        classTeacher,
        classTeacherStatus,
      ];

  PhoneBookState copyWith({
    PhoneBookStatus? phoneBookStatus,
    List<PhoneBookStudent>? phoneBookStudent,
    List<PhoneBook>? phoneBookParent,
    List<PhoneBookTeacher>? phoneBookTeacher,
    List<ClassTeacher>? classTeacher,
    ApiCallStatus? classTeacherStatus,
  }) {
    return PhoneBookState(
      phoneBookStatus: phoneBookStatus ?? this.phoneBookStatus,
      phoneBookParent: phoneBookParent ?? this.phoneBookParent,
      phoneBookStudent: phoneBookStudent ?? this.phoneBookStudent,
      phoneBookTeacher: phoneBookTeacher ?? this.phoneBookTeacher,
      classTeacher: classTeacher ?? this.classTeacher,
      classTeacherStatus: classTeacherStatus ?? this.classTeacherStatus,
    );
  }
}
