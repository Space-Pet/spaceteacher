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

  bool isPayWithBalance = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SchoolFeeBloc>.value(
      value: context.read<SchoolFeeBloc>(),
      child: BlocConsumer<SchoolFeeBloc, SchoolFeeState>(
        listener: (context, state) {
          if (state.schoolFeePreviewStatus == SchoolFeePreviewStatus.loaded) {
            context.read<SchoolFeeBloc>().add(
                  UpdateStatusSchoolFeeEvent(
                    schoolFeeHistoryStatus: state.schoolFeeHistoryStatus,
                    paymentStatus: state.paymentStatus,
                    schoolFeeStatus: state.schoolFeeStatus,
                    schoolFeePreviewStatus: SchoolFeePreviewStatus.initial,
                  ),
                );
            context
                .push(
              SchoolFeePaymentScreen(
                schoolFeePaymentPreview: state.schoolFeePayWithBalancePreview ??
                    SchoolFeePaymentPreview(),
                paymentGateways: state.paymentGateways ?? [],
                isPayWithBalance: isPayWithBalance,
              ),
            )
                .then(
              (value) {
                if (value == true) {
                  context.read<SchoolFeeBloc>().add(const FetchSchoolFee());
                }
              },
            );
          }
          if (state.schoolFeeStatus == SchoolFeeStatus.loaded) {
            isShowDetailList = List.generate(
              state.schoolFee?.schoolFeeItems?.length ?? 0,
              (index) => false,
            );
            isPayWithBalance = false;
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

              // Kiểm tra totalCanTru không phải là null và khác 0 thì hiển thị nút cấn trừ.
              if (!isNullOrEmpty(state.schoolFee?.totalCanTru) &&
                  int.tryParse(state.schoolFee?.totalCanTru ?? "0") != 0)
                ElevatedButton(
                  onPressed: () {
                    _payWithBalance(
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
                "${NumberFormatUtils.displayMoney(state.schoolFee?.totalChuaNop?.toDouble())}",
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
                isPayWithBalance: isPayWithBalance,
              ),
            )
                .then((res) {
              if (res == true) {
                context.read<SchoolFeeBloc>().add(const FetchSchoolFee());
                isPayWithBalance = false;
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

  // Thanh toán cấn trừ.
  void _payWithBalance(SchoolFee schoolFee, BuildContext context) {
    setState(() {
      isPayWithBalance = true;
      context.read<SchoolFeeBloc>().add(GetSchoolFeePayWithBalancePreview(
            totalMoneyPayment: int.parse('${schoolFee.totalCanTru}'),
          ));
    });
  }
}
