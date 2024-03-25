import 'package:injectable/injectable.dart';

import '../../../../models/payment_method.dart';
import '../../../../models/payment_object.dart';
import '../../data_repository.dart';
import 'payment_repository.dart';

@Singleton(as: PaymentRepository)
class PaymentRepositoryImpl with DataRepository implements PaymentRepository {
  @override
  Future<List<PaymentMethod>?> fetchPaymentMethodList() async {
    const query = '''
        query GetPaymentMethods {
          payment_method {
            id
            description
            icon_url
          }
        }

    ''';
    final items = await graphqlProvider.queryList(
      query,
      PaymentMethod.fromJson,
      'payment_method',
    );
    return items;
  }

  @override
  Future<PaymentRequest?> getPaymentUrl(
    String? bookingId,
    String? paymentMethod,
    String? returnUrl,
    String? transactionType,
    String? locale,
  ) async {
    const query = '''
                mutation GetPaymentURL(\$data: PaymentRequestInput!) {
                  paymentRequest(data: \$data) {
                    payment_request_id
                    payment_method_id
                    payment_url
                  }
                }

     ''';
    final result = await graphqlProvider.mutate(
      query,
      PaymentRequest.fromJson,
      'paymentRequest',
      variables: {
        'data': {
          'booking_id': bookingId,
          'payment_method_id': paymentMethod,
          'return_url': returnUrl,
          'transaction_type': transactionType,
          'locale': locale
        }
      },
    );

    return result;
  }

  @override
  Future<PaymentRequest?> getTopUpPaymentUrl(
    PaymentTopup? paymentTopup,
  ) async {
    const query = '''
                mutation GetPaymentURL(\$data: PaymentRequestInput!) {
                  paymentRequest(data: \$data) {
                    payment_request_id
                    payment_method_id
                    payment_url
                  }
                }

     ''';
    final result = await graphqlProvider.mutate(
      query,
      PaymentRequest.fromJson,
      'paymentRequest',
      variables: {
        'data': paymentTopup?.toJson(),
      },
    );

    return result;
  }

  @override
  Future<String?> checkPaymentStatus(
    String? paymentRequestId,
  ) async {
    const query = '''
                        query CheckPaymentStatus(\$data: CheckPaymentInput = {payment_request_id: ""}) {
              checkPayment(data: \$data) {
                status
              }
            }

     ''';
    final result = await graphqlProvider.query(
      query,
      (response) => response['status'],
      'checkPayment',
      variables: {
        'data': {'payment_request_id': paymentRequestId}
      },
    );

    return result;
  }
}
