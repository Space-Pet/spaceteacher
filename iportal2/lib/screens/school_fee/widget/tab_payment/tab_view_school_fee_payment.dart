import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_bloc.dart';
import 'package:iportal2/screens/school_fee/screen/school_fee_payment_screen.dart';
import 'package:iportal2/screens/school_fee/widget/tab_payment/w_card_detail_school_fee_payment.dart';

class TabViewSchoolFeePayment extends StatefulWidget {
  const TabViewSchoolFeePayment({super.key});

  @override
  State<TabViewSchoolFeePayment> createState() => _TabViewSchoolFeePayment();
}

class _TabViewSchoolFeePayment extends State<TabViewSchoolFeePayment>
    with SingleTickerProviderStateMixin {
  List<bool> isShowDetailList = [];

  double totalThanhTien = 0;
  bool isClearingDebt = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SchoolFeeBloc>.value(
      value: context.read<SchoolFeeBloc>()..add(const FetchSchoolFee()),
      child: BlocConsumer<SchoolFeeBloc, SchoolFeeState>(
        listener: (context, state) {
          if (state.schoolFeePreviewStatus == SchoolFeePreviewStatus.loaded) {
            context.push(
              SchoolFeePaymentScreen(
                schoolFeePaymentPreview:
                    state.schoolFeePaymentClearingDebtPreview ??
                        SchoolFeePaymentPreview(),
                paymentGateways: state.paymentGateways ?? [],
                isClearingDebt: isClearingDebt,
              ),
            );
          }
          if (state.schoolFeeStatus == SchoolFeeStatus.loaded) {
            isShowDetailList = List.generate(
              state.schoolFee?.schoolFeeItems?.length ?? 0,
              (index) => false,
            );
            isClearingDebt = false;
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Skeletonizer(
              enabled: state.schoolFeeStatus == SchoolFeeStatus.loading,
              child: CustomRefresh(
                onRefresh: () async {
                  context.read<SchoolFeeBloc>().add(const FetchSchoolFee());
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      state.schoolFee?.schoolFeeItems?.length ?? 0,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            isShowDetailList[index] = !isShowDetailList[index];
                          });
                        },
                        child: CardDetailSchoolFeePayment(
                          isShowDetail: isShowDetailList.length > index
                              ? isShowDetailList[index]
                              : false,
                          item: state.schoolFee?.schoolFeeItems?[index] ??
                              SchoolFeeItem(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: _buildBottomNavigationBar(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, SchoolFeeState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tiền còn thừa",
                    style: AppTextStyles.normal14(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "${NumberFormatUtils.displayMoney(NumberFormatUtils.parseDouble("${state.schoolFee?.totalCanTru ?? 0}"))}",
                    style: AppTextStyles.bold14(color: AppColors.green700),
                  ),
                ],
              ),
              if (state.schoolFee?.totalCanTru != "0")
                ElevatedButton(
                  onPressed: () {
                    _clearingDebt(
                      state.schoolFee ?? SchoolFee(),
                      context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    side: const BorderSide(
                      color: AppColors.brand600,
                    ),
                  ),
                  child: Text(
                    "Cấn trừ",
                    style: AppTextStyles.bold14(color: AppColors.brand600),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tổng cộng:",
                style: AppTextStyles.normal14(fontWeight: FontWeight.w400),
              ),
              Text(
                "${NumberFormatUtils.displayMoney(isClearingDebt == true ? totalThanhTien : NumberFormatUtils.parseDouble("${state.schoolFee?.totalChuaNop ?? 0}"))}",
                style: AppTextStyles.bold14(),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context
                .push(
              SchoolFeePaymentScreen(
                schoolFeePaymentPreview:
                    state.schoolFeePaymentPreview ?? SchoolFeePaymentPreview(),
                paymentGateways: state.paymentGateways ?? [],
                // amountToBePaid: int.parse('${totalThanhTien.round()}'),
                isClearingDebt: isClearingDebt,
              ),
            )
                .then((res) {
              if (res == true) {
                context.read<SchoolFeeBloc>().add(const FetchSchoolFee());
                isClearingDebt = false;
              }
            });
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.red90001),
          child: Text(
            'Nộp phí',
            style: AppTextStyles.semiBold16(color: AppColors.white),
          ),
        ),
      ],
    );
  }

  void _clearingDebt(SchoolFee schoolFee, BuildContext context) {
    setState(() {
      final totalCanTruDouble = double.parse(schoolFee.totalCanTru ?? "0");
      final totalChuaNop = schoolFee.totalChuaNop ?? 0.0;

      if (totalChuaNop <= totalCanTruDouble) {
        totalThanhTien = totalChuaNop.toDouble();
      } else {
        totalThanhTien = totalChuaNop - totalCanTruDouble;
      }
      isClearingDebt = true;
    });
    context.read<SchoolFeeBloc>().add(GetSchoolFeeClearingDebtPreview(
          totalMoneyPayment: int.parse('${totalThanhTien.round()}'),
        ));
  }
}
