import '../../../../models/payment_method.dart';
import '../../../../models/payment_object.dart';
import '../../data_repository.dart';

abstract class PaymentRepository with DataRepository {
  Future<List<PaymentMethod>?> fetchPaymentMethodList();
  Future<PaymentRequest?> getPaymentUrl(
      String? bookingId,
      String? paymentMethod,
      String? returnUrl,
      String? transactionType,
      String? locale);

  Future<PaymentRequest?> getTopUpPaymentUrl(PaymentTopup? paymentTopup);

  Future<String?> checkPaymentStatus(String? paymentRequestId);
}
