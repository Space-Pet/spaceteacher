import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/webview_screen.dart';

import 'package:iportal2/screens/school_fee/bloc/school_fee_bloc.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_status.dart';
import 'package:iportal2/screens/school_fee/widget/dialog/school_fee_payment_dialog_noti.dart';
import 'package:repository/repository.dart';

import '../../../authentication/utilites/dialog_utils.dart';

class MethodPaymentScreen extends StatefulWidget {
  const MethodPaymentScreen(
      {required this.paymentGateways,
      required this.totalMoneyPayment,
      super.key});
  final List<PaymentGateway> paymentGateways;
  final int totalMoneyPayment;
  @override
  State<MethodPaymentScreen> createState() => _MethodPaymentScreenState();
}

class _MethodPaymentScreenState extends State<MethodPaymentScreen> {
  late PaymentGateway _methodPayment;
  int _paymentId = 0;
  @override
  void initState() {
    super.initState();
    _methodPayment = widget.paymentGateways.first;
    _paymentId = widget.paymentGateways.first.id ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SchoolFeeBloc(
        appFetchApiRepo: context.read<AppFetchApiRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: Container(
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
                widget.paymentGateways.length,
                (index) {
                  final it = widget.paymentGateways[index];
                  return RadioListTile<PaymentGateway>(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(
                      it.name ?? "",
                      style: AppTextStyles.bold14(),
                    ),
                    subtitle: Text(
                      "Phí dịch vụ tối thiểu: ${it.serviceCharge ?? 0}",
                      style: AppTextStyles.bold12(
                        color: AppColors.gray600,
                      ),
                    ),
                    secondary: Image.network(
                      it.logo ?? "",
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                    value: widget.paymentGateways[index],
                    autofocus: true,
                    groupValue: _methodPayment,
                    onChanged: (value) {
                      setState(() {
                        _methodPayment = value ?? PaymentGateway();
                        _paymentId = it.id ?? 0;
                      });
                    },
                    activeColor: AppColors.brand600,
                  );
                },
              ),
            ),
            const Spacer(),
            BlocConsumer<SchoolFeeBloc, SchoolFeeState>(
              listener: (context, state) {
                if (state.paymentStatus == PaymentStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error ?? "Có lỗi xảy ra"),
                      backgroundColor: AppColors.red500,
                    ),
                  );
                } else if (state.paymentStatus == PaymentStatus.loaded) {
                  mainNavKey.currentState
                      ?.push(
                    MaterialPageRoute(
                      builder: (context) => WebViewScreen(
                        url: state.gateway?.urlGateway ?? "",
                      ),
                    ),
                  )
                      .then(
                    (res) {
                      LoadingDialog.hide(context);
                      showDialog(
                        context: context,
                        builder: (ctx) =>
                            SchoolFeePaymentDialogNoti(isSuccess: res),
                      ).then(
                        (resDialog) {
                          if (resDialog != null && resDialog == true) {
                            context.pop(true);
                            context.pop(true);
                          } else if (resDialog != null && resDialog == false) {
                            context.pop();
                          }
                        },
                      );
                    },
                  );
                } else if (state.paymentStatus == PaymentStatus.loading) {
                  LoadingDialog.show(context);
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<SchoolFeeBloc>().add(
                            OpenPaymentGateway(
                              paymentId: _paymentId,
                              totalMoneyPayment: widget.totalMoneyPayment,
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brand500,
                    ),
                    child: Text(
                      "Tiếp tục",
                      style: AppTextStyles.bold14(color: AppColors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
