import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/fee_plan/widget/w_field_row_card_detail.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_bloc.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_status.dart';
import 'package:iportal2/screens/school_fee/widget/dialog/school_fee_payment_dialog_noti.dart';
import 'package:iportal2/screens/school_fee/widget/method_payment/method_payment_screen.dart';
import 'package:repository/repository.dart';

class SchoolFeePaymentScreen extends StatefulWidget {
  static const routeName = '/school-fee-payment';
  const SchoolFeePaymentScreen({
    required this.schoolFeePaymentPreview,
    required this.paymentGateways,
    this.isPayWithBalance,
    super.key,
  });

  final SchoolFeePaymentPreview schoolFeePaymentPreview;
  final List<PaymentGateway> paymentGateways;
  final bool? isPayWithBalance;

  @override
  State<SchoolFeePaymentScreen> createState() => _SchoolFeePaymentScreenState();
}

class _SchoolFeePaymentScreenState extends State<SchoolFeePaymentScreen> {
  bool _btnTypePayment1 = true;
  bool _btnTypePayment2 = false;
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SchoolFeeBloc(
          appFetchApiRepo: context.read<AppFetchApiRepository>(),
          currentUserBloc: context.read<CurrentUserBloc>()),
      child: BlocConsumer<SchoolFeeBloc, SchoolFeeState>(
        listener: (context, state) {
          if (state.paymentStatus == PaymentStatus.loaded &&
              state.isPayWithBalance == true) {
            showDialog(
              context: context,
              builder: (ctx) => SchoolFeePaymentDialogNoti(
                  isSuccess: state.isPayWithBalance ?? false),
            ).then(
              (resDialog) {
                if (resDialog != null && resDialog == true) {
                  Navigator.of(context).pop({'refresh': true, 'tabIndex': 1});
                }
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(context),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          _buildFieldRowCardDetail(
                            title: "Họ và tên học sinh",
                            value: widget
                                    .schoolFeePaymentPreview.pupil?.fullName ??
                                "",
                          ),
                          _buildFieldRowCardDetail(
                            title: "Số tiền thu",
                            value: NumberFormatUtils.displayMoney(
                                  double.parse(
                                      '${widget.schoolFeePaymentPreview.tongPhaiNop ?? 0}'),
                                ) ??
                                "",
                          ),
                          _buildFieldRowCardDetail(
                            title: "Ngày thu",
                            value:
                                widget.schoolFeePaymentPreview.ngayThanhToan ??
                                    DateTime.now().ddMMyyyySlash,
                          ),
                          _buildCardInfoPayment(
                              widget.schoolFeePaymentPreview.items ?? []),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar:
                _buildBottomBar(context, widget.paymentGateways),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.gray200,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop({'refresh': false}),
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
    );
  }

  Widget _buildFieldRowCardDetail(
      {required String title, required String? value}) {
    return FieldRowCardDetail(
      title: title,
      value: value ?? "",
      titleStyle: AppTextStyles.normal14(color: AppColors.gray700),
      valueStyle: AppTextStyles.semiBold14(),
    );
  }

  Widget _buildCardInfoPayment(List<SchoolFeePaymentPreviewItem> items) {
    return Column(
      children: items.map((item) => _buildCardDetail(item)).toList(),
    );
  }

  Widget _buildCardDetail(SchoolFeePaymentPreviewItem item) {
    return Container(
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
                item.noiDung ?? '',
                style: AppTextStyles.bold16(color: AppColors.brand600),
              ),
            ),
            const Divider(color: AppColors.gray300),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  _buildFieldRowCardDetail(
                    title: "Độ ưu tiên",
                    value: item.doUuTien ?? '',
                  ),
                  _buildFieldRowCardDetail(
                    title: "Phí niêm yết",
                    value: NumberFormatUtils.displayMoney(
                      double.parse('${item.phiNiemYet ?? 0}'),
                    ),
                  ),
                  _buildFieldRowCardDetail(
                    title: "Giảm giá",
                    value: NumberFormatUtils.displayMoney(
                      double.parse('${item.giamGia ?? 0}'),
                    ),
                  ),
                  _buildFieldRowCardDetail(
                    title: "Phải nộp",
                    value: NumberFormatUtils.displayMoney(
                      double.parse('${item.phaiNop ?? 0}'),
                    ),
                  ),
                  _buildFieldRowCardDetail(
                    title: "Thực thu",
                    value: NumberFormatUtils.displayMoney(
                      double.parse('${item.thucThu ?? 0}'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(
      BuildContext context, List<PaymentGateway> paymentGateways) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.isPayWithBalance == false
                ? "Chọn số tiền cần thanh toán"
                : "${widget.schoolFeePaymentPreview.hinhThucThanhToan}",
            style: AppTextStyles.bold14(),
          ),
          const SizedBox(height: 10),
          if (widget.isPayWithBalance == false)
            Row(
              children: [
                _buildPaymentButton(
                  context,
                  label: "Nộp toàn bộ",
                  isSelected: _btnTypePayment1,
                  onPressed: () => _selectPaymentType(1),
                ),
                const SizedBox(width: 5),
                _buildPaymentButton(
                  context,
                  label: "Nộp một phần",
                  isSelected: _btnTypePayment2,
                  onPressed: () => _selectPaymentType(2),
                ),
              ],
            ),
          const SizedBox(height: 10),
          _buildPaymentAmount(),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _handlePayment(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brand500,
              elevation: 0,
            ),
            child: Text(
              "Thanh toán",
              style: AppTextStyles.bold14(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.brand600 : AppColors.white,
          side: !isSelected
              ? const BorderSide(color: AppColors.brand600)
              : BorderSide.none,
          elevation: 0,
        ),
        child: Text(
          label,
          style: AppTextStyles.bold14(
            color: isSelected ? AppColors.white : AppColors.brand600,
          ),
        ),
      ),
    );
  }

  void _selectPaymentType(int type) {
    setState(() {
      _btnTypePayment1 = type == 1;
      _btnTypePayment2 = type == 2;
    });
  }

  Widget _buildPaymentAmount() {
    return AnimatedCrossFade(
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
            Text("Số tiền cần thanh toán: ", style: AppTextStyles.normal14()),
            Text(
              "${NumberFormatUtils.displayMoney(
                double.parse('${widget.schoolFeePaymentPreview.tongThanhToan}'),
              )}",
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
              SizedBox(width: MediaQuery.of(context).size.width * 0.3),
              Text("Tổng:", style: AppTextStyles.normal14()),
              Text(
                "${NumberFormatUtils.displayMoney(
                  double.parse(
                      '${widget.schoolFeePaymentPreview.tongThanhToan}'),
                )}",
                style: AppTextStyles.bold14(),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Form(
            key: _formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              enabled: _btnTypePayment2,
              controller: _textController,
              keyboardType: TextInputType.number,
              validator: _validatePayment,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(),
              ],
              decoration: InputDecoration(
                hintText: "Nhập số tiền cần thanh toán >/= 50.000đ",
                hintStyle: AppTextStyles.normal14(color: AppColors.gray500),
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
          ),
        ],
      ),
    );
  }

  // Xác thực số tiền thanh toán
  String? _validatePayment(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số tiền';
    }

    // Loại bỏ các dấu phân cách hàng ngàn
    value = value.replaceAll('.', '');

    final numValue = int.tryParse(value);
    if (numValue == null || numValue < 50000) {
      return 'Số tiền phải lớn hơn hoặc bằng 50.000đ';
    }
    return null;
  }

  // Thanh toán dựa trên điều kiện thanh toán bằng số dư hiện tại hoặc các phương thức thanh toán khác.
  void _handlePayment(BuildContext context) {
    if (widget.isPayWithBalance == true) {
      context.read<SchoolFeeBloc>().add(
            PayWithBalance(
                totalMoneyPayment:
                    widget.schoolFeePaymentPreview.tongThanhToan ?? 0),
          );
    } else {
      if (_btnTypePayment2 == true) {
        if (_formKey.currentState?.validate() ?? false) {
          final value = _textController.text.replaceAll('.', '');
          _showMethodPaymentScreen(context, int.parse(value));
        }
      } else {
        _showMethodPaymentScreen(
          context,
          widget.schoolFeePaymentPreview.tongThanhToan ?? 0,
        );
      }
    }
  }

  // Hiển thị màn hình phương thức thanh toán dưới dạng bottom sheet
  void _showMethodPaymentScreen(BuildContext context, int totalMoneyPayment) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Material(
        child: MethodPaymentScreen(
          paymentGateways: widget.paymentGateways,
          totalMoneyPayment: totalMoneyPayment,
        ),
      ),
    );
  }
}
