import 'package:bloc/bloc.dart';
import 'package:repository/repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository authRepository;
  ForgotPasswordBloc({required this.authRepository})
      : super(const ForgotPasswordState()) {
    on<CheckNumberPhone>(_onCheckNumberPhone);
  }
  void _onCheckNumberPhone(
      CheckNumberPhone event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(forgotPasswordStatus: ForgotPasswordStatus.loading));
    final data = await authRepository.checkNumberPhone(
        numberPhone: event.numnberPhone, type: event.type);
    if (data == 'Số điện thoại tồn tại trên hệ thống') {
      emit(state.copyWith(forgotPasswordStatus: ForgotPasswordStatus.success));
    } else {
      emit(state.copyWith(
          forgotPasswordStatus: ForgotPasswordStatus.error, message: data));
    }
  }
}
