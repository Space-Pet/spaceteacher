
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// part 'loading_splash_event.dart';
// part 'loading_splash_state.dart';

// class LoadingSplashBloc extends Bloc<LoadingSplashEvent, LoadingSplashState> {
//   LoadingSplashBloc() : super(const LoadingSplashState()) {
//     on<GetTokenLeanerEvent>(_handleGetTokenLeanerEvent);
//   }

//   Future<void> _handleGetTokenLeanerEvent(
//     GetTokenLeanerEvent event,
//     Emitter<LoadingSplashState> emit,
//   ) async {
//     await Future.delayed(const Duration(milliseconds: 1100));

//     await Hive.initFlutter();
//     final prefs = await SharedPreferences.getInstance();

//     final box = await Hive.openBox('boxIportal2');
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();

//     if (prefs.getString('app_version') != packageInfo.version) {
//       box.clear();
//       prefs.setString('app_version', packageInfo.version);
//     }

//     String tokenUser = box.get('token_user', defaultValue: '');
//     bool isFistTime = box.get('is_first_time', defaultValue: true);

//     if (isFistTime) {
//       return emit(state.copyWith(status: LoadingSplashStatus.firstTime));
//     }
//     if (tokenUser.isEmpty) {
//       return emit(state.copyWith(status: LoadingSplashStatus.errorToken));
//     }
//     APIService.instance.addAuthorization(token: tokenUser);
//     ProfileResponse profileResponse =
//         await ApplicationAPIsService.instance.getProfile();
//     if(profileResponse.isEmpty) {
//       return emit(state.copyWith(status: LoadingSplashStatus.errorToken));
//     }
//     return emit(state.copyWith(status: LoadingSplashStatus.successToken, userToken: tokenUser));
//   }
// }

