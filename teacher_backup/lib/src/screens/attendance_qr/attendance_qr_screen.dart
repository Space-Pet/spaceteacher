import 'package:core/presentation/common_widget/select_date.dart';
import 'package:core/resources/resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/i18n/locale_keys.g.dart';
import 'package:teacher/src/utils/extension_context.dart';

import '../phone_book/model/example.dart';

class AttendanceQRScreen extends StatefulWidget {
  const AttendanceQRScreen({Key? key, this.type}) : super(key: key);
  final int? type;
  static const routeName = '/attendanceQR';

  @override
  State<AttendanceQRScreen> createState() => _AttendanceQRScreenState();
}

class _AttendanceQRScreenState extends State<AttendanceQRScreen> {
  late List<bool> isAbsent;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void initState() {
    super.initState();
    isAbsent =
        List<bool>.filled(phoneBook.length, widget.type == 1 ? false : true);
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: widget.type == 1
                ? LocaleKeys.attendance.tr()
                : LocaleKeys.attendanceQR.tr(),
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: AppRadius.roundedTop28,
              ),
              child: Column(
                children: [
                  if (widget.type == 1) const SelectDate(),
                  if (widget.type != 1)
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text('Quét mã QR để điểm danh'),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          height: 200,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              QRView(
                                key: qrKey,
                                onQRViewCreated: _onQRViewCreated,
                                overlay: QrScannerOverlayShape(
                                  borderColor: Colors.green,
                                  borderRadius: 10,
                                  borderLength: 30,
                                  borderWidth: 10,
                                  cutOutSize: 400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Assets.images.ateendancePink.provider(),
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      '2',
                                      style: AppTextStyles.normal18(
                                        color: AppColors.brand600,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Tiết học',
                                      style: AppTextStyles.normal14(
                                        color: AppColors.gray500,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 20,
                                color: AppColors.gray300,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      '2',
                                      style: AppTextStyles.normal18(
                                        color: AppColors.green600,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Có mặt',
                                      style: AppTextStyles.normal14(
                                        color: AppColors.gray500,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 20,
                                color: AppColors.gray300,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      '2',
                                      style: AppTextStyles.normal18(
                                        color: AppColors.red700,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Vắng',
                                      style: AppTextStyles.normal14(
                                        color: AppColors.gray500,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 16),
                      itemCount: phoneBook.length,
                      itemBuilder: (context, index) {
                        final info = phoneBook[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // Toggle the absent status
                                isAbsent[index] = !isAbsent[index];
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(info.image),
                                        ),
                                        shape: BoxShape.circle,
                                        color: AppColors.white,
                                        border: Border.all(
                                          color: AppColors.white,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          info.name,
                                          style: AppTextStyles.normal14(
                                              color: AppColors.brand600),
                                        ),
                                        Text(
                                          info.id,
                                          style: AppTextStyles.normal12(
                                              color: AppColors.secondary),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      isAbsent[index] ? 'Có phép' : '',
                                      style: AppTextStyles.normal12(
                                          color: AppColors.orange400),
                                    ),
                                    isAbsent[index]
                                        ? Assets.icons.absent.svg()
                                        : Assets.icons.checkDone.svg(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        _handleQRCodeScan(scanData.code);
      });
    });
  }

  void _handleQRCodeScan(String? code) {
    if (code != null) {
      for (int index = 0; index < phoneBook.length; index++) {
        if (phoneBook[index].id == code) {
          setState(() {
            isAbsent[index] = false; // Mark as present
          });
        }
      }
    }
  }

  void _disposeCamera() {
    controller?.dispose();
  }

  @override
  void dispose() {
    _disposeCamera();
    super.dispose();
  }
}
