import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/screens/fee_plan/widget/w_field_row_card_detail.dart';
import 'package:iportal2/screens/school_fee/widget/method_payment/method_payment_screen.dart';

class SchoolFeePaymentScreen extends StatefulWidget {
  static const routeName = '/school-fee-payment';
  const SchoolFeePaymentScreen({super.key});

  @override
  State<SchoolFeePaymentScreen> createState() => _SchoolFeePaymentScreenState();
}

class _SchoolFeePaymentScreenState extends State<SchoolFeePaymentScreen> {
  bool _btnTypePayment1 = true;
  bool _btnTypePayment2 = false;

  final TextEditingController _textController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.gray200,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.gray500,
                        ),
                        splashColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Xem trước nội dung thu tiền",
                        style: AppTextStyles.bold14(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      FieldRowCardDetail(
                        title: "Họ và tên học sinh",
                        value: "Phan Thanh Phước Thịnh",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.gray700),
                        valueStyle: AppTextStyles.semiBold14(),
                      ),
                      FieldRowCardDetail(
                        title: "Số tiền thu",
                        value: NumberFormatUtils.displayMoney(
                                double.parse('${25000000}')) ??
                            "",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.gray700),
                        valueStyle: AppTextStyles.semiBold14(),
                      ),
                      FieldRowCardDetail(
                          title: "Ngày thu",
                          titleStyle:
                              AppTextStyles.normal14(color: AppColors.gray700),
                          valueStyle: AppTextStyles.semiBold14(),
                          value: DateFormat("dd/MM/yyyy")
                              .format(
                                DateFormat("dd-MM-yyyy").parse("31-07-2023"),
                              )
                              .toString(),
                          isLastItem: false),
                      FieldRowCardDetail(
                        title: "Hình thức thanh toán",
                        value: "Thanh toán online",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.gray700),
                        valueStyle: AppTextStyles.semiBold14(),
                      ),

                      // List card detail info payment
                      _buildCardInfoPayment(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildCardInfoPayment() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.gray200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    "Phí bán trú - Nộp 4 lần",
                    style: AppTextStyles.bold16(
                      color: AppColors.brand600,
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.gray300,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      FieldRowCardDetail(
                        title: "Phí niêm yết",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.gray700),
                        valueStyle:
                            AppTextStyles.semiBold14(color: AppColors.gray700),
                        value:
                            "${NumberFormatUtils.displayMoney(double.parse('${25000000}'))}/học phần",
                        isLastItem: false,
                      ),
                      FieldRowCardDetail(
                        title: "Giảm giá",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.gray700),
                        valueStyle:
                            AppTextStyles.semiBold14(color: AppColors.gray700),
                        value:
                            "${NumberFormatUtils.displayMoney(double.parse('${250000}'))}",
                        isLastItem: false,
                      ),
                      FieldRowCardDetail(
                        title: "Phải nộp",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.brand500),
                        valueStyle:
                            AppTextStyles.semiBold14(color: AppColors.brand500),
                        value:
                            "${NumberFormatUtils.displayMoney(double.parse('${25000000 - 250000}'))}",
                        isLastItem: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.gray200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    "Phí nội trú - Nộp 1 lần (Cả năm)",
                    style: AppTextStyles.bold16(
                      color: AppColors.brand600,
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.gray300,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      FieldRowCardDetail(
                        title: "Độ ưu tiên",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.gray700),
                        valueStyle:
                            AppTextStyles.semiBold14(color: AppColors.gray700),
                        value: "6.30",
                        isLastItem: false,
                      ),
                      FieldRowCardDetail(
                        title: "Phí niêm yết",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.gray700),
                        valueStyle:
                            AppTextStyles.semiBold14(color: AppColors.gray700),
                        value:
                            "${NumberFormatUtils.displayMoney(double.parse('${250000}'))}",
                        isLastItem: false,
                      ),
                      FieldRowCardDetail(
                        title: "Giảm giá",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.gray700),
                        valueStyle:
                            AppTextStyles.semiBold14(color: AppColors.gray700),
                        value:
                            "${NumberFormatUtils.displayMoney(double.parse('${250000}'))}",
                        isLastItem: false,
                      ),
                      FieldRowCardDetail(
                        title: "Phải nộp",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.gray700),
                        valueStyle:
                            AppTextStyles.semiBold14(color: AppColors.gray700),
                        value:
                            "${NumberFormatUtils.displayMoney(double.parse('${25000000 - 250000}'))}",
                        isLastItem: false,
                      ),
                      FieldRowCardDetail(
                        title: "Thực thu",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.gray700),
                        valueStyle:
                            AppTextStyles.semiBold14(color: AppColors.gray700),
                        value:
                            "${NumberFormatUtils.displayMoney(double.parse('${25000000 - 250000}'))}",
                        isLastItem: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Chọn số tiền cần thanh toán",
            style: AppTextStyles.bold14(),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _btnTypePayment1 = true;
                      _btnTypePayment2 = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _btnTypePayment1 == true
                        ? AppColors.brand600
                        : AppColors.white,
                    side: _btnTypePayment1 == false
                        ? const BorderSide(color: AppColors.brand600)
                        : BorderSide.none,
                    elevation: 0,
                  ),
                  child: Text(
                    "Nộp toàn bộ",
                    style: AppTextStyles.bold14(
                        color: _btnTypePayment1 == false
                            ? AppColors.brand600
                            : AppColors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _btnTypePayment1 = false;
                      _btnTypePayment2 = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _btnTypePayment2 == true
                        ? AppColors.brand600
                        : AppColors.white,
                    side: _btnTypePayment2 == false
                        ? const BorderSide(color: AppColors.brand600)
                        : BorderSide.none,
                    elevation: 0,
                  ),
                  child: Text(
                    "Nộp một phần",
                    style: AppTextStyles.bold14(
                        color: _btnTypePayment2 == false
                            ? AppColors.brand600
                            : AppColors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState: _btnTypePayment1
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Container(
              decoration: BoxDecoration(
                color: AppColors.gray200,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Số tiền cần thanh toán: ",
                    style: AppTextStyles.normal14(),
                  ),
                  Text(
                    "${NumberFormatUtils.displayMoney(double.parse('${25000000}'))}",
                    style: AppTextStyles.bold14(),
                  ),
                ],
              ),
            ),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    Text(
                      "Tổng:",
                      style: AppTextStyles.normal14(),
                    ),
                    Text(
                      "${NumberFormatUtils.displayMoney(double.parse('${25000000}'))}",
                      style: AppTextStyles.bold14(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  enabled: _btnTypePayment2,
                  controller: _textController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Nhập số tiền cần thanh toán >/= 50.000đ",
                    hintStyle: AppTextStyles.normal14(
                      color: AppColors.gray500,
                    ),
                    contentPadding: const EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: AppColors.gray300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: AppColors.brand600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (ctx) =>
                      const Material(child: MethodPaymentScreen()));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brand500, elevation: 0),
            child: Text(
              "Thanh toán",
              style: AppTextStyles.bold14(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
