// ignore_for_file: one_member_abstracts

import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../di/di.dart';
import '../../../../presentation/theme/theme_data.dart';
import '../../../models/address.dart';
import '../../../models/app_setting.dart';
import '../../../models/booking.dart';
import '../../../models/booking_setting.dart';
import 'preferences_key.dart';

part 'impl/preferences_helper.impl.dart';

abstract class PreferencesHelper extends AppPreferenceData {}

/// Define common local data can be using for both app
abstract class AppPreferenceData {
  SupportedTheme getTheme();

  Future<bool?> setTheme(String? data);

  String? getLocalization();

  Future<bool?> saveLocalization(String? locale);

  Future<bool?> clearData();

  Future<void> markFirstLaunch();

  bool isFirstLaunch();

  /// Token
  String? get token;

  set token(String? token);

  /// Token
  String? get refreshToken;

  set refreshToken(String? token);

  List<BookingAddressType>? getListBookingAddressType();

  Future<bool?> saveListBookingAddressType(
    List<BookingAddressType>? listBookingAddressType,
  );

  /// App settings
  AppSetting? get appSettings;

  set appSettings(AppSetting? value);

  /// Booking settings
  List<BookingSetting>? get bookingSettings;

  set bookingSettings(List<BookingSetting>? value);

  /// Notification settings
  bool? get notificationEnabled;

  set notificationEnabled(bool? value);

  Address? getLastBookingAddress();
  ServiceItems? getLastBookingServiceItems();

  Future<bool?> saveLastBookingAddress(Address? address);
  Future<bool?> saveLastBookingServiceItems(ServiceItems? serviceItems);

  Address? getInputAddress();
  Future<bool?> saveInputAddress(Address? inputAddress);
  ServiceItems? getInputWorkingTime();
  Future<bool?> saveInputWorkingTime(ServiceItems? serviceItems);
  String? getPartnerId();
  Future<bool?> savePartnerId(String? id);
}
