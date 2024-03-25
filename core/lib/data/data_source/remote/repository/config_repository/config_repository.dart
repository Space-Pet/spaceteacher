import '../../../../models/adminstrative.dart';
import '../../../../models/app_setting.dart';
import '../../../../models/booking_setting.dart';

abstract class ConfigRepository {
  Future<List<Province>> getProvincesData();

  Future<List<BookingSetting>?> getBookingSettings();

  Future<AppSetting?> getAppSettings();



  Future<bool?> sendFeedback(
    String content,
  );

  Future<List<TermsOfUse>?> getTermsOfUseData();
}
