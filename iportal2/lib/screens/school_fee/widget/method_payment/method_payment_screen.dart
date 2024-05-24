import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/school_fee/widget/dialog_noti/school_fee_payment_dialog_noti.dart';

class MethodPaymentScreen extends StatefulWidget {
  const MethodPaymentScreen({super.key});

  @override
  State<MethodPaymentScreen> createState() => _MethodPaymentScreenState();
}

enum MethodPayment { stripe, card, paypal }

class _MethodPaymentScreenState extends State<MethodPaymentScreen> {
  MethodPayment? _methodPayment = MethodPayment.card;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Chọn phương thức thanh toán",
                  style: AppTextStyles.bold16(),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: EdgeInsets.zero,
                  splashColor: Colors.transparent,
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.gray200,
            thickness: 1,
          ),
          Column(
            children: List.generate(
              MethodPayment.values.length,
              (index) {
                return RadioListTile<MethodPayment>(
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    MethodPayment.values[index].toText(),
                    style: AppTextStyles.bold14(),
                  ),
                  subtitle: MethodPayment.values[index].index ==
                          MethodPayment.card.index
                      ? Text(
                          "Phí dịch vụ tối thiểu: 5.000 VND",
                          style: AppTextStyles.bold12(
                            color: AppColors.gray600,
                          ),
                        )
                      : null,
                  secondary: MethodPayment.values[index].getIcon(),
                  value: MethodPayment.values[index],
                  groupValue: _methodPayment,
                  onChanged: (value) {
                    setState(() {
                      _methodPayment = value;
                    });
                  },
                  activeColor: AppColors.brand600,
                );
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              onPressed: () async {
                bool isPaymentSuccess = true;
                final res = await showDialog(
                    context: context,
                    builder: (ctx) => SchoolFeePaymentDialogNoti(
                        isSuccess: isPaymentSuccess));
                if (res != null && res == true) {
                  context.pop();
                  context.pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brand500,
              ),
              child: Text(
                "Tiếp tục",
                style: AppTextStyles.bold14(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension MethodPaymentX on MethodPayment {
  String toText() {
    switch (this) {
      case MethodPayment.card:
        return "Debit • Credit Card";
      case MethodPayment.stripe:
        return "Stripe";
      case MethodPayment.paypal:
        return "Paypal";
    }
  }

  SvgPicture getIcon() {
    switch (this) {
      case MethodPayment.card:
        return SvgPicture.asset(Assets.icons.iconCreditDebitCard);
      case MethodPayment.stripe:
        return SvgPicture.asset(Assets.icons.iconStripeGateway);
      case MethodPayment.paypal:
        return SvgPicture.asset(Assets.icons.iconPaypalGateway);
    }
  }
}
