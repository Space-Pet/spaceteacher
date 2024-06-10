import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_bloc.dart';
import 'package:iportal2/screens/school_fee/screen/school_fee_payment_screen.dart';
import 'package:iportal2/screens/school_fee/widget/tab_payment/w_card_detail_school_fee_payment.dart';

class TabViewSchoolFeePayment extends StatefulWidget {
  const TabViewSchoolFeePayment({
    super.key,
  });

  @override
  State<TabViewSchoolFeePayment> createState() => _TabViewSchoolFeePayment();
}

class _TabViewSchoolFeePayment extends State<TabViewSchoolFeePayment>
    with SingleTickerProviderStateMixin {
  late List<bool> isShowDetailList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SchoolFeeBloc, SchoolFeeState>(
      listener: (context, state) {
        switch (state.schoolFeeStatus) {
          case SchoolFeeStatus.loaded:
            isShowDetailList.clear();
            isShowDetailList.addAll(
              List.generate(
                state.schoolFee?.schoolFeeItems?.length ?? 0,
                (index) => false,
              ),
            );
            break;
          default:
        }
      },
      builder: (context, state) {
        final itemsLength = state.schoolFee?.schoolFeeItems?.length ?? 0;
        if (isShowDetailList.length != itemsLength) {
          isShowDetailList.clear();
          isShowDetailList.addAll(List.filled(itemsLength, false));
        }
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
                    itemsLength,
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
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Tiền còn thừa",
                            style: AppTextStyles.normal14(
                                fontWeight: FontWeight.w400)),
                        Text(
                          "${NumberFormatUtils.displayMoney(
                            NumberFormatUtils.parseDouble(
                                "${state.schoolFee?.totalCanTru ?? 0}"),
                          )}",
                          style:
                              AppTextStyles.bold14(color: AppColors.green700),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          side: const BorderSide(
                            color: AppColors.brand600,
                          )),
                      child: Text(
                        "Cấn trừ",
                        style: AppTextStyles.bold14(
                          color: AppColors.brand600,
                        ),
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
                    Text("Tổng cộng:",
                        style: AppTextStyles.normal14(
                            fontWeight: FontWeight.w400)),
                    Text(
                      "${NumberFormatUtils.displayMoney(
                        NumberFormatUtils.parseDouble(
                            "${state.schoolFee?.totalThanhTien ?? 0}"),
                      )}",
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
                      schoolFeePaymentPreview: state.schoolFeePaymentPreview ??
                          SchoolFeePaymentPreview(),
                      paymentGateways: state.paymentGateways ?? [],
                    ),
                  )
                      .then(
                    (res) {
                      if (res == true) {
                        context
                            .read<SchoolFeeBloc>()
                            .add(const FetchSchoolFee());
                      }
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red90001,
                ),
                child: Text(
                  'Nộp phí',
                  style: AppTextStyles.semiBold16(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
