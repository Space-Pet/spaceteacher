// part of '../preferences_helper.dart';

// @Injectable(as: PreferencesHelper)
// class PreferencesHelperImpl extends PreferencesHelper {
//   final SharedPreferences _prefs = injector.get();

//   @override
//   SupportedTheme getTheme() {
//     final theme = _prefs.getString(PreferencesKey.theme);
//     if (theme == null || theme == SupportedTheme.light.name) {
//       return SupportedTheme.light;
//     }
//     return SupportedTheme.dark;
//   }

//   @override
//   Future<bool?> setTheme(String? data) async {
//     if (data == null) {
//       return _prefs.remove(PreferencesKey.theme);
//     }
//     return _prefs.setString(PreferencesKey.theme, data);
//   }

//   @override
//   String? getLocalization() {
//     return _prefs.getString(PreferencesKey.localization);
//   }

//   @override
//   Future<bool?> saveLocalization(String? locale) async {
//     if (locale == null) {
//       return _prefs.remove(PreferencesKey.localization);
//     }
//     return _prefs.setString(PreferencesKey.localization, locale);
//   }

//   @override
//   Future<bool?> clearData() async {
//     final theme = getTheme();
//     final locale = getLocalization();

//     await _prefs.clear();

//     final result = await Future.wait([
//       saveLocalization(locale),
//       setTheme(theme.name),
//     ]);

//     return result.any((e) => e == false) == false;
//   }

//   @override
//   bool isFirstLaunch() {
//     return _prefs
//             .getString(
//               PreferencesKey.isFirstLaunch,
//             )
//             .isNullOrEmpty ==
//         true;
//   }

//   @override
//   Future<void> markFirstLaunch() async {
//     await _prefs.setString(PreferencesKey.isFirstLaunch, 'yes');
//   }

//   @override
//   String? get token => _prefs.getString(PreferencesKey.token);

//   @override
//   set token(String? value) => _prefs.setString(
//         PreferencesKey.token,
//         value ?? '',
//       );

//   @override
//   String? get refreshToken => _prefs.getString(PreferencesKey.refreshToken);

//   @override
//   set refreshToken(String? value) => _prefs.setString(
//         PreferencesKey.refreshToken,
//         value ?? '',
//       );

//   // @override
//   // List<BookingAddressType>? getListBookingAddressType() {
//   //   final data = _prefs.getStringList(PreferencesKey.listBookingAddressType);

//   //   if (data == null) {
//   //     return null;
//   //   }

//   //   final listBookingAddressType = data
//   //       .map((stringData) => BookingAddressType.fromJson(
//   //           jsonDecode(stringData) as Map<String, dynamic>))
//   //       .toList();

//   //   return listBookingAddressType;
//   // }

//   // @override
//   // Future<bool?> saveListBookingAddressType(
//   //     List<BookingAddressType>? listBookingAddressType) async {
//   //   if (listBookingAddressType == null) {
//   //     return _prefs.remove(PreferencesKey.listBookingAddressType);
//   //   }
//   //   return _prefs.setStringList(
//   //       PreferencesKey.listBookingAddressType,
//   //       listBookingAddressType
//   //           .map((type) => jsonEncode(type.toJson()))
//   //           .toList());
//   // }

//   // @override
//   // AppSetting? get appSettings {
//   //   final settingsStr = _prefs.getString(PreferencesKey.appSettings);
//   //   if (settingsStr == null) {
//   //     return null;
//   //   }
//   //   return AppSetting.fromJson(jsonDecode(settingsStr));
//   // }

//   // @override
//   // set appSettings(AppSetting? value) {
//   //   if (value == null) {
//   //     _prefs.remove(PreferencesKey.appSettings);
//   //     return;
//   //   }
//   //   _prefs.setString(
//   //     PreferencesKey.appSettings,
//   //     jsonEncode(value.toJson()),
//   //   );
//   // }

//   // @override
//   // List<BookingSetting>? get bookingSettings {
//   //   final settingsStr = _prefs.getStringList(PreferencesKey.bookingSettings);
//   //   if (settingsStr == null) {
//   //     return null;
//   //   }
//   //   return settingsStr
//   //       .map((e) => BookingSetting.fromJson(jsonDecode(e)))
//   //       .toList();
//   // }

//   // @override
//   // set bookingSettings(List<BookingSetting>? value) {
//   //   if (value == null || value.isEmpty) {
//   //     _prefs.remove(PreferencesKey.bookingSettings);
//   //     return;
//   //   }
//   //   _prefs.setStringList(
//   //     PreferencesKey.bookingSettings,
//   //     value.map(jsonEncode).toList(),
//   //   );
//   // }

//   @override
//   bool? get notificationEnabled {
//     return _prefs.getBool(PreferencesKey.notificationEnabled);
//   }

//   @override
//   set notificationEnabled(bool? enabled) {
//     _prefs.setBool(
//       PreferencesKey.notificationEnabled,
//       enabled ?? false,
//     );
//   }

//   // @override
//   // Address? getLastBookingAddress() {
//   //   final lastBooking = _prefs.getString(PreferencesKey.lastBookingAddress);
//   //   if (lastBooking == null) {
//   //     return null;
//   //   }
//   //   return Address.fromJson(jsonDecode(lastBooking));
//   // }

//   // @override
//   // ServiceItems? getLastBookingServiceItems() {
//   //   final lastBooking = _prefs.getString(PreferencesKey.lastBookingServiceItem);
//   //   if (lastBooking == null) {
//   //     return null;
//   //   }
//   //   return ServiceItems.fromJson(jsonDecode(lastBooking));
//   // }

//   // @override
//   // Future<bool?> saveLastBookingAddress(Address? address) {
//   //   if (address == null) {
//   //     return _prefs.remove(PreferencesKey.lastBookingAddress);
//   //   }
//   //   return _prefs.setString(
//   //       PreferencesKey.lastBookingAddress, jsonEncode(address.toJson()));
//   // }

//   // @override
//   // Future<bool?> saveLastBookingServiceItems(ServiceItems? serviceItems) {
//   //   if (serviceItems == null) {
//   //     return _prefs.remove(PreferencesKey.lastBookingServiceItem);
//   //   }
//   //   return _prefs.setString(PreferencesKey.lastBookingServiceItem,
//   //       jsonEncode(serviceItems.toJson()));
//   // }

//   // @override
//   // Address? getInputAddress() {
//   //   final inputAddress = _prefs.getString(PreferencesKey.inputAddress);
//   //   if (inputAddress == null) {
//   //     return null;
//   //   }
//   //   return Address.fromJson(jsonDecode(inputAddress));
//   // }

//   // @override
//   // Future<bool?> saveInputAddress(Address? inputAddress) {
//   //   if (inputAddress == null) {
//   //     return _prefs.remove(PreferencesKey.inputAddress);
//   //   }
//   //   return _prefs.setString(
//   //       PreferencesKey.inputAddress, jsonEncode(inputAddress.toJson()));
//   // }

//   // @override
//   // ServiceItems? getInputWorkingTime() {
//   //   final inputWorkingTime = _prefs.getString(PreferencesKey.inputWorkingTime);
//   //   if (inputWorkingTime == null) {
//   //     return null;
//   //   }
//   //   return ServiceItems.fromJson(jsonDecode(inputWorkingTime));
//   // }

//   // @override
//   // Future<bool?> saveInputWorkingTime(ServiceItems? serviceItems) {
//   //   if (serviceItems == null) {
//   //     return _prefs.remove(PreferencesKey.inputWorkingTime);
//   //   }
//   //   return _prefs.setString(
//   //       PreferencesKey.inputWorkingTime, jsonEncode(serviceItems.toJson()));
//   // }

//   @override
//   Future<bool?> savePartnerId(String? id) {
//     if (id == null) {
//       return _prefs.remove(PreferencesKey.partnerId);
//     }
//     return _prefs.setString(PreferencesKey.partnerId, id);
//   }

//   @override
//   String? getPartnerId() {
//     final id = _prefs.getString(PreferencesKey.partnerId);
//     if (id == null) {
//       return null;
//     }
//     return id;
//   }
// }
