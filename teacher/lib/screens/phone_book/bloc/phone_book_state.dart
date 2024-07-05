part of 'phone_book_bloc.dart';

enum PhoneBookStatus { init, success, error, loading }

class PhoneBookState extends Equatable {
  final List<PhoneBookStudent> phoneBookStudent;
  final List<Parent> phoneBookParent;
  final List<PhoneBookTeacher> phoneBookTeacher;
  final List<ClassTeacher> classTeacher;
  final ClassTeacher seletedClasss;

  final PhoneBookStatus phoneBookStatus;

  const PhoneBookState({
    this.phoneBookStatus = PhoneBookStatus.init,
    required this.phoneBookStudent,
    required this.phoneBookParent,
    required this.phoneBookTeacher,
    this.classTeacher = const [],
    required this.seletedClasss,
  });
  
  @override
  List<Object?> get props => [
        phoneBookStatus,
        phoneBookParent,
        phoneBookStudent,
        phoneBookTeacher,
        classTeacher,
        seletedClasss,
      ];

  PhoneBookState copyWith({
    PhoneBookStatus? phoneBookStatus,
    List<PhoneBookStudent>? phoneBookStudent,
    List<Parent>? phoneBookParent,
    List<PhoneBookTeacher>? phoneBookTeacher,
    List<ClassTeacher>? classTeacher,
    ClassTeacher? seletedClasss,
  }) {
    return PhoneBookState(
      phoneBookStatus: phoneBookStatus ?? this.phoneBookStatus,
      phoneBookParent: phoneBookParent ?? this.phoneBookParent,
      phoneBookStudent: phoneBookStudent ?? this.phoneBookStudent,
      phoneBookTeacher: phoneBookTeacher ?? this.phoneBookTeacher,
      classTeacher: classTeacher ?? this.classTeacher,
      seletedClasss: seletedClasss ?? this.seletedClasss,
    );
  }
}
