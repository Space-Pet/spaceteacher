part of 'phone_book_bloc.dart';

abstract class PhoneBookEvent extends Equatable {
  const PhoneBookEvent();
  @override
  List<Object> get props => [];
}

class GetPhoneBookStudent extends PhoneBookEvent {}
class GetPhoneBookTeacher extends PhoneBookEvent {}