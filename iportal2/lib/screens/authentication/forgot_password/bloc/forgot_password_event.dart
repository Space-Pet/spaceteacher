part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {}

class CheckNumberPhone extends ForgotPasswordEvent {
  final String numnberPhone;
  final String type;
  CheckNumberPhone({required this.numnberPhone, required this.type});
  List<Object> get props => [numnberPhone, type];
}
