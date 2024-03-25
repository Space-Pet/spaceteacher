part of '../base.dart';

extension StateBaseExtention on StateBase {
  void hideKeyBoard() => CommonFunction.hideKeyBoard(context);

  Size get device => MediaQuery.of(context).size;

  double get paddingTop => MediaQuery.of(context).padding.top;

  double get paddingBottom => MediaQuery.of(context).padding.bottom;

  void refreshHeader() {
    bloc?.updateHeader({HttpConstants.language: languageCode});
  }

  Future<void> _cleanUp() async {
    await injector.get<AuthService>().signOut();
    await injector.get<LocalDataManager>().clearData();
  }

  Future<void> doLogout() async {
    showLoading();
    await _cleanUp();
    hideLoading();
  }

  /// put main specific for each app
  void backToHome(String route) {
    Navigator.of(context).popUntil(
      ModalRoute.withName(route),
    );
  }

  String? textFromGender(String? gender) {
    switch (gender) {
      case ServerGender.male:
        return trans.male;
      case ServerGender.female:
        return trans.female;
      default:
        return null;
    }
  }
}

void showToast(String message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color(0xffCCECF9),
    textColor: Colors.black,
    fontSize: 12.0,
  );
}
