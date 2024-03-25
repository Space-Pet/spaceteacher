// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i16;

import '../common/services/implementation/firebase_upload_service.dart' as _i18;
import '../common/services/upload_service.dart' as _i17;
import '../data/data_source/local/local_data_manager.dart' as _i8;
import '../data/data_source/local/preferences_helper/preferences_helper.dart'
    as _i13;
import '../data/data_source/remote/app_api_service.dart' as _i3;
import '../data/data_source/remote/repository/chat_repository/chat_repository.dart'
    as _i4;
import '../data/data_source/remote/repository/chat_repository/chat_repository.impl.dart'
    as _i5;
import '../data/data_source/remote/repository/config_repository/config_repository.dart'
    as _i6;
import '../data/data_source/remote/repository/config_repository/config_repository_impl.dart'
    as _i7;
import '../data/data_source/remote/repository/notification_repository/notification_repository.dart'
    as _i9;
import '../data/data_source/remote/repository/payment_repository/payment_repository.dart'
    as _i10;
import '../data/data_source/remote/repository/payment_repository/payment_repository.impl.dart'
    as _i11;
import '../data/data_source/remote/repository/post_repository/post_repository.dart'
    as _i12;
import '../data/data_source/remote/repository/services_repository/services_repository.dart'
    as _i14;
import '../data/data_source/remote/repository/services_repository/services_repository.impl.dart'
    as _i15;
import 'di.dart' as _i19;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.factory<_i3.AppApiService>(() => _i3.AppApiService());
  gh.singleton<_i4.ChatRepository>(_i5.ChatRepositoryImpl());
  gh.singleton<_i6.ConfigRepository>(_i7.ConfigRepositoryImpl());
  gh.singleton<_i8.LocalDataManager>(_i8.LocalDataManager());
  gh.singleton<_i9.NotificationRepository>(_i9.NotificationRepositoryImpl());
  gh.singleton<_i10.PaymentRepository>(_i11.PaymentRepositoryImpl());
  gh.factory<_i12.PostRepository>(() => _i12.PostRepositoryImpl());
  gh.factory<_i13.PreferencesHelper>(() => _i13.PreferencesHelperImpl());
  gh.singleton<_i14.ServicesRepository>(_i15.ServicesRepositoryImpl());
  await gh.factoryAsync<_i16.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.factory<_i17.UploadService>(() => _i18.FirebaseUploadService());
  return getIt;
}

class _$AppModule extends _i19.AppModule {}
