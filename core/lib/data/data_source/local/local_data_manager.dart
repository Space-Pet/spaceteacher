import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../di/di.dart';
import '../../../presentation/theme/theme_data.dart';
import '../../models/address.dart';
import '../../models/adminstrative.dart';
import '../../models/app_setting.dart';
import '../../models/booking.dart';
import '../../models/booking_setting.dart';
import 'preferences_helper/preferences_helper.dart';

@Singleton()
class LocalDataManager implements AppPreferenceData {
  late final PreferencesHelper _preferencesHelper = injector.get();
  Box<Province>? _administrativeHiveBox;

  LocalDataManager() {
    init();
  }

  @factoryMethod
  Future<void> init() async {
    Hive.registerAdapter(ProvinceAdapter());
    _administrativeHiveBox = await Hive.openBox<Province>(
      'administrative_hive_box',
    );
  }

////////////////////////////////////////////////////////
  ///             Preferences helper
  ///
  @override
  SupportedTheme getTheme() {
    return _preferencesHelper.getTheme();
  }

  @override
  Future<bool?> setTheme(String? data) {
    return _preferencesHelper.setTheme(data);
  }

  @override
  String? getLocalization() {
    return _preferencesHelper.getLocalization();
  }

  @override
  Future<bool?> saveLocalization(String? locale) {
    return _preferencesHelper.saveLocalization(locale);
  }

  @override
  Future<bool?> clearData() async {
    await _administrativeHiveBox?.clear();
    return _preferencesHelper.clearData();
  }

////////////////////////////////////////////////////////
  ///             Administrative helper
  ///
  Future<void>? saveAdministrative(List<Province> data) {
    for (final element in data) {
      final _ = _administrativeHiveBox?.add(element);
    }
    return null;
  }

  List<Province>? getListProvinces() {
    return _administrativeHiveBox?.values.toList();
  }

  List<District>? getListDistricts(String provinceId) {
    return province(provinceId)?.districts;
  }

  List<Ward>? getListWards(String province, String district) {
    return getListDistricts(province)
        ?.where((element) => element.code == district)
        .first
        .wards;
  }

  Province? province(String id) {
    try {
      return getListProvinces()?.firstWhere((element) => element.code == id);
    } catch (e) {
      return null;
    }
  }

  District? district(String province, String district) {
    try {
      return getListDistricts(province)
          ?.firstWhere((element) => element.code == district);
    } catch (e) {
      return null;
    }
  }

  Ward? ward(String province, String district, String ward) {
    try {
      return getListWards(province, district)
          ?.firstWhere((element) => element.code == ward);
    } catch (e) {
      return null;
    }
  }

  @override
  bool isFirstLaunch() {
    return _preferencesHelper.isFirstLaunch();
  }

  @override
  Future<void> markFirstLaunch() {
    return _preferencesHelper.markFirstLaunch();
  }

  /// Token
  @override
  String? get token => _preferencesHelper.token;

  @override
  set token(String? value) {
    _preferencesHelper.token = value;
  }

  /// Token
  @override
  String? get refreshToken => _preferencesHelper.refreshToken;

  @override
  set refreshToken(String? value) {
    _preferencesHelper.refreshToken = value;
  }

  @override
  List<BookingAddressType>? getListBookingAddressType() {
    return _preferencesHelper.getListBookingAddressType();
  }

  @override
  Future<bool?> saveListBookingAddressType(
      List<BookingAddressType>? listBookingAddressType) {
    return _preferencesHelper
        .saveListBookingAddressType(listBookingAddressType);
  }

  @override
  AppSetting? get appSettings {
    return _preferencesHelper.appSettings;
  }

  @override
  set appSettings(AppSetting? value) {
    _preferencesHelper.appSettings = value;
  }

  @override
  List<BookingSetting>? get bookingSettings {
    return _preferencesHelper.bookingSettings;
  }

  @override
  set bookingSettings(List<BookingSetting>? value) {
    _preferencesHelper.bookingSettings = value;
  }

  @override
  bool? get notificationEnabled {
    return _preferencesHelper.notificationEnabled;
  }

  @override
  set notificationEnabled(bool? enabled) {
    _preferencesHelper.notificationEnabled = enabled;
  }

  @override
  Address? getLastBookingAddress() {
    return _preferencesHelper.getLastBookingAddress();
  }

  @override
  ServiceItems? getLastBookingServiceItems() {
    return _preferencesHelper.getLastBookingServiceItems();
  }

  @override
  Future<bool?> saveLastBookingAddress(Address? address) {
    return _preferencesHelper.saveLastBookingAddress(address);
  }

  @override
  Future<bool?> saveLastBookingServiceItems(ServiceItems? serviceItems) {
    return _preferencesHelper.saveLastBookingServiceItems(serviceItems);
  }

  @override
  Address? getInputAddress() {
    return _preferencesHelper.getInputAddress();
  }

  @override
  Future<bool?> saveInputAddress(Address? inputAddress) {
    return _preferencesHelper.saveInputAddress(inputAddress);
  }

  @override
  ServiceItems? getInputWorkingTime() {
    return _preferencesHelper.getInputWorkingTime();
  }

  @override
  Future<bool?> saveInputWorkingTime(ServiceItems? serviceItems) {
    return _preferencesHelper.saveInputWorkingTime(serviceItems);
  }

  @override
  Future<bool?> savePartnerId(String? id) {
    return _preferencesHelper.savePartnerId(id);
  }

  @override
  String? getPartnerId() {
    return _preferencesHelper.getPartnerId();
  }
}
