class FeePlanItem {
  final int id;
  final String title;
  final PaymentType paymentType;
  final OneTimePaymentClass oneTimePayment;
  final MultiTimePaymentClass? multiTimePayment;

  FeePlanItem({
    required this.id,
    required this.title,
    required this.paymentType,
    required this.oneTimePayment,
    this.multiTimePayment,
  });
}

class FeeRequestedItem {
  final int id;
  final String title;
  final PaymentType paymentType;
  final PaymentStatus paymentStatus;
  final int originalPrice;
  final int discount;
  final String payDue;

  FeeRequestedItem({
    required this.id,
    required this.title,
    required this.paymentType,
    required this.paymentStatus,
    required this.originalPrice,
    required this.discount,
    required this.payDue,
  });
}

class EducationServiceItem {
  final int id;
  final String title;
  final String totalPayment;
  final String payDue;

  EducationServiceItem({
    required this.id,
    required this.title,
    required this.totalPayment,
    required this.payDue,
  });
}

enum PaymentType { all, service, oneTime, multiTime, kit, csvc }

extension PaymentTypeX on PaymentType {
  String text() {
    switch (this) {
      case PaymentType.all:
        return "Tất cả";
      case PaymentType.service:
        return "Dịch vụ";
      case PaymentType.oneTime:
        return "Nộp 1 lần (Cả năm)";
      case PaymentType.multiTime:
        return "Nộp 4 lần (Theo học phần)";
      case PaymentType.kit:
        return "Kit";
      case PaymentType.csvc:
        return "CSVC";
      default:
        return "Tất cả";
    }
  }
}

enum PaymentStatus { applied, requested, failed }

extension PaymentStatusX on PaymentStatus {
  String text() {
    switch (this) {
      case PaymentStatus.applied:
        return "Đã áp dụng";
      case PaymentStatus.requested:
        return "Gửi duyệt";
      case PaymentStatus.failed:
        return "Thất bại";
      default:
        return "Gửi duyệt";
    }
  }
}

class OneTimePaymentClass {
  final String totalPayment;
  final String payDue;

  OneTimePaymentClass({
    required this.totalPayment,
    required this.payDue,
  });
}

class MultiTimePaymentClass {
  final String totalPayment;
  final String payDue1;
  final String payDue4;
  final String payDue3;
  final String payDue2;

  MultiTimePaymentClass({
    required this.totalPayment,
    required this.payDue1,
    required this.payDue4,
    required this.payDue3,
    required this.payDue2,
  });
}

final List<FeePlanItem> feePlanList = [
  FeePlanItem(
      id: 1,
      title: 'Học phí',
      oneTimePayment: OneTimePaymentClass(
          totalPayment: '43.469.125 đ', payDue: '31/07/2023'),
      paymentType: PaymentType.all,
      multiTimePayment: MultiTimePaymentClass(
          totalPayment: '3.469.125 đ/học phần',
          payDue1: '31/07/2023',
          payDue4: '31/07/2023',
          payDue3: '31/07/2023',
          payDue2: '31/07/2023')),
  FeePlanItem(
      id: 2,
      title: 'Phí bán trú',
      oneTimePayment: OneTimePaymentClass(
          totalPayment: '43.469.125 đ', payDue: '31/07/2023'),
      paymentType: PaymentType.all,
      multiTimePayment: MultiTimePaymentClass(
          totalPayment: '3.469.125 đ/học phần',
          payDue1: '31/07/2023',
          payDue4: '31/07/2023',
          payDue3: '31/07/2023',
          payDue2: '31/07/2023')),
  FeePlanItem(
    id: 3,
    title: 'Phí nội trú',
    oneTimePayment:
        OneTimePaymentClass(totalPayment: '43.469.125 đ', payDue: '31/07/2023'),
    paymentType: PaymentType.oneTime,
  )
];

final List<EducationServiceItem> eduService = [
  EducationServiceItem(
      id: 1, title: 'Kit', totalPayment: '43.469.125 đ', payDue: '31/07/2023'),
  EducationServiceItem(
      id: 2, title: 'CSVC', totalPayment: '43.469.125 đ', payDue: '31/07/2023'),
];

final List<FeeRequestedItem> feeRequestedList = [
  FeeRequestedItem(
    id: 1,
    title: 'Học phí',
    paymentType: PaymentType.oneTime,
    paymentStatus: PaymentStatus.requested,
    originalPrice: 43469125,
    discount: 1000000,
    payDue: '31/07/2023',
  ),
  FeeRequestedItem(
    id: 2,
    title: 'Phí bán trú',
    paymentType: PaymentType.oneTime,
    paymentStatus: PaymentStatus.applied,
    originalPrice: 43469125,
    discount: 1000000,
    payDue: '31/07/2023',
  ),
  FeeRequestedItem(
    id: 3,
    title: 'Phí nội trú',
    paymentType: PaymentType.oneTime,
    paymentStatus: PaymentStatus.applied,
    originalPrice: 43469125,
    discount: 1000000,
    payDue: '31/07/2023',
  ),
  FeeRequestedItem(
    id: 4,
    title: 'Dịch vụ giáo dục',
    paymentType: PaymentType.kit,
    paymentStatus: PaymentStatus.applied,
    originalPrice: 43469125,
    discount: 1000000,
    payDue: '31/07/2023',
  ),
  FeeRequestedItem(
    id: 5,
    title: 'Dịch vụ giáo dục',
    paymentType: PaymentType.csvc,
    paymentStatus: PaymentStatus.applied,
    originalPrice: 43469125,
    discount: 1000000,
    payDue: '31/07/2023',
  ),
];
