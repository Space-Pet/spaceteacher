// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../common/services/implementation/firebase_upload_service.dart' as _i9;
import '../common/services/upload_service.dart' as _i8;
import '../data/data_source/local/local_data_manager.dart' as _i3;
import '../data/data_source/local/preferences_helper/preferences_helper.dart'
    as _i4;
import '../data/data_source/remote/repository/services_repository/services_repository.dart'
    as _i5;
import '../data/data_source/remote/repository/services_repository/services_repository.impl.dart'
    as _i6;
import 'di.dart' as _i10;

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
  gh.singleton<_i3.LocalDataManager>(_i3.LocalDataManager());
  gh.factory<_i4.PreferencesHelper>(() => _i4.PreferencesHelperImpl());
  gh.singleton<_i5.ServicesRepository>(_i6.ServicesRepositoryImpl());
  await gh.factoryAsync<_i7.SharedPreferences>(
    () => appModule.sharedPreferences,
    preResolve: true,
  );
  gh.factory<_i8.UploadService>(() => _i9.FirebaseUploadService());
  return getIt;
}

class _$AppModule extends _i10.AppModule {}
