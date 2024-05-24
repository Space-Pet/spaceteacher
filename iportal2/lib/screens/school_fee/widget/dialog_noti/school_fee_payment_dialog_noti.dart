import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/resources/assets.gen.dart';

class SchoolFeePaymentDialogNoti extends StatelessWidget {
  const SchoolFeePaymentDialogNoti({this.isSuccess = false, super.key});
  final bool isSuccess;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      insetPadding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              isSuccess ? Assets.icons.iconSuccess : Assets.icons.iconFailure,
            ),
            const SizedBox(height: 20),
            Text(
              isSuccess ? "Nộp phí thành công." : "Nộp phí không thành công",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              isSuccess
                  ? "Vui lòng xem chi tiết tại Lịch sử thanh toán"
                  : "Vui lòng thao tác lại hoặc liên hệ nhân viên trường",
              textAlign: TextAlign.center,
              style: AppTextStyles.normal14(color: AppColors.gray700),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.pop(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brand500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Đóng",
                style: AppTextStyles.bold14(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
