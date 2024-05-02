import 'package:bloc/bloc.dart';
import 'package:repository/repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AuthRepository authRepository;

  ChangePasswordBloc({required this.authRepository})
      : super(const ChangePasswordState()) {
    on<ChangePassword>(_onChangePassword);
  }
  void _onChangePassword(
      ChangePassword event, Emitter<ChangePasswordState> emit) async {
    emit(state.copyWith(changePasswordStatus: ChangePasswordStatus.loading));
    final data = await authRepository.getPassword(
        numberPhone: event.numberPhone,
        type: event.type,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation);
    if (data == 'Đặt lại mật khẩu thành công.') {
      emit(state.copyWith(changePasswordStatus: ChangePasswordStatus.success));
    } else {
      emit(state.copyWith(
          changePasswordStatus: ChangePasswordStatus.error, message: data));
    }
  }
}
