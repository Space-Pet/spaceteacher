part of '../constants.dart';

class ServerGender {
  static const String male = 'male';
  static const String female = 'female';
}

class ServerErrorCode {
  static const String invalidToken = 'invalid_token';
  static const String userNotFound = 'user_not_found';
  static const String refreshToken = 'refresh_token';
}

class ServiceType {
  static const String cleaning = 'cleaning';
  static const String repairs = 'repairs';
  static const String electricalRefrigeration = 'electrical_refrigeration';
  static const String repairElectricalRefrigeration =
      'repairs_electrical_refrigeration';

  static const List<String> serviceList = [
    'cleaning',
    'repairs',
    'electrical_refrigeration'
  ];
}

class MaterialItemType {
  static const String waterRepair = 'water';
  static const String refrigeration = 'refrigeration';
  static const String electronic = 'electronic';
  static const String electrical = 'electrical';
  static const List<String> list = [
    'water',
    'refrigeration',
    'electronic',
    'electrical'
  ];
}

class AddressPositionType {
  static const String point = 'Point';
}

class BookingSettings {
  static const String priority = 'priority';
  static const String maxDistance = 'max_distance';
  static const String limit = 'limit';
}

enum ActivitiesChildPageType {
  current,
  history,
}

class iportalReactionConst {
  static const String favorited = 'favorited';
}

class TransactionType {
  static const String deposit = 'D';
  static const String transfer = 'T';
  static const String withdraw = 'W';
  static const String bookingFee = 'booking_fee';
  static const String tranSfer = 'transfer';
  static const String withDraw = 'with_draw';
  static const String topUp = 'top_up';
  static const String refund = 'refund';
  static const String bookingTax = 'booking_tax';
  static const String bookingReceived = 'booking_received';
  static const String bookingPromotion = 'booking_promotion';

  static const String referralBonus = 'referral_bonus';
}

class WalletType {
  static const String defaultWallet = 'default';
  static const String bonusWallet = 'bonus_vnd';
}

class PaymentMethodType {
  static const String bank = 'bank';
  static const String cash = 'cash';
  static const String system = 'system';
  static const String vnpay = 'vn_pay';
  static const String momo = 'momo';
  static const String bonus = 'bonus';

  static const String bonusToDefault = 'bonus_to_default';
  static const String kpiBonus = 'kpi_bonus';
}

class TransactionStatus {
  static const String requesting = 'R';
  static const String processing = 'P';
  static const String success = 'S';
  static const String failure = 'F';
  static const String canceled = 'C';
}

class BookingSettingConstant {
  static const String bookingBuffer = 'booking_buffer';
  static const String totalCleaningBookingWorkingHour = 'total_amount';
}

class RoleType {
  static const String partner = 'partner';
  static const String iportal = 'iportal';
}

class KpiType {
  static const String week = 'week';
  static const String day = 'day';
  static const String month = 'month';
  static const String year = 'year';
}

class PurchaseConstant {
  static const String bookingPaymentTransaction = 'booking_payment';
  static const String topupTransaction = 'top_up';
  static const String appMomoIos = 'https://apps.apple.com/app/id918751511';
  static const String appMomoAndroid =
      'market://details?id=com.mservice.momotransfer';
}

class ChannelConstant {
  static const String vnpayChannel = 'vnpay_channel';
  static const String vnpay = 'startVnPay';
  static const String momoChannel = 'momo_channel';
  static const String momo = 'startMomo';
}

class ChatConstant {
  static const String photo = 'photo';
  static const String text = 'text';
  static const String iportal = 'iportal';
  static const String partner = 'partner';
}

class PaymentStatus {
  static const String appBackAction = 'AppBackAction';
  static const String callMobileBankingApp = 'CallMobileBankingApp';
  static const String webBackAction = 'WebBackAction';
  static const String faildBackAction = 'FaildBackAction';
  static const String failBackAction = 'FailBackAction';
  static const String successBackAction = 'SuccessBackAction';
  static const String success = 'success';
  static const String failed = 'failed';
  static const String pending = 'pending';
}

class SupportConstants {
  static const String appZaloAndroid =
      'https://play.google.com/store/apps/details?id=com.zing.zalo';

  static const String appZaloIos =
      'https://apps.apple.com/us/app/zalo/id579523206';
}
