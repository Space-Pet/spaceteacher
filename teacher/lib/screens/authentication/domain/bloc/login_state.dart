part of 'login_bloc.dart';

enum LoginStatus {
  init,
  loading,
  readyToSubmit,
  success,
  failure,
  domainInit,
  domainFailure,
  chooseSchool,
  listSchoolTeacher,
}

class LoginState extends Equatable {
  const LoginState({
    this.showError = false,
    this.status = LoginStatus.init,
    this.cachedDomain = '',
    this.listSchoolTeacher = const [],
  });

  final bool showError;
  final LoginStatus status;
  final String cachedDomain;
  final List<SchoolTeacher> listSchoolTeacher;

  @override
  List<Object> get props => [
        showError,
        status,
        cachedDomain,
        listSchoolTeacher,
      ];

  bool get isReadyToSubmit => status == LoginStatus.readyToSubmit;
  bool get isSuccess => status == LoginStatus.success;

  LoginState copyWith({
    bool? showError,
    LoginStatus? status,
    String? cachedDomain,
    List<SchoolTeacher>? listSchoolTeacher,
  }) {
    return LoginState(
      showError: showError ?? this.showError,
      status: status ?? this.status,
      cachedDomain: cachedDomain ?? this.cachedDomain,
      listSchoolTeacher: listSchoolTeacher ?? this.listSchoolTeacher,
    );
  }
}
