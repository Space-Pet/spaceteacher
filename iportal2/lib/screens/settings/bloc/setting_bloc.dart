import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc({required this.appFetchApiRepo}) : super(const SettingState()) {
    on<ChangePassword>(_onChangePassword);
  }
  final AppFetchApiRepository appFetchApiRepo;

  _onChangePassword(
    ChangePassword event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(settingStatus: SettingStatus.loading));
    final data = await appFetchApiRepo.changePassword(
      password: event.password,
      currentPassword: event.currentPassword,
      passwordConfirmation: event.passwordConfirmation,
    );

    if (data!['code'] == 200 && data['status'] == 'success') {
      emit(state.copyWith(settingStatus: SettingStatus.success));
    } else {
      emit(state.copyWith(
        settingStatus: SettingStatus.error,
        errorMsg: data['message'],
      ));
    }
  }
}
