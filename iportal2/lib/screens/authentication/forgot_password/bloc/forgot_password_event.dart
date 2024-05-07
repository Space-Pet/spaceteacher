part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {}

class CheckNumberPhone extends ForgotPasswordEvent {
  final String numnberPhone;
  CheckNumberPhone({
    required this.numnberPhone,
  });
}

class ForgotPasswordChangedTab extends ForgotPasswordEvent {
  final int index;

  ForgotPasswordChangedTab({
    required this.index,
  });
}
