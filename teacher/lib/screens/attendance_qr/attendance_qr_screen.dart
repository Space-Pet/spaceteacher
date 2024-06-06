import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/attendance_qr/bloc/attendance_qr_bloc.dart';
import 'package:teacher/screens/phone_book/model/list_phone_book.dart';

import '../authentication/utilites/dialog_utils.dart';

class AttendanceQRScreen extends StatelessWidget {
  const AttendanceQRScreen(
      {super.key,
      this.attendanceTeacher,
      this.type,
      required this.date,
      required this.onTapAttendance});
  final AttendanceTeacher? attendanceTeacher;
  final int? type;
  final DateTime date;
  static const routeName = '/attendanceQR';
  final VoidCallback onTapAttendance;
  @override
  Widget build(BuildContext context) {
    final currentUserBloc = context.read<CurrentUserBloc>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final attendanceQrBloc = AttendanceQrBloc(
      appFetchApiRepository: appFetchApiRepository,
      currentUserBloc: currentUserBloc,
    );
    attendanceQrBloc.add(GetListAttendance(
      subjectId: attendanceTeacher?.subjectId ?? 0,
      classId: attendanceTeacher?.classId ?? 0,
      date: date.yyyyMMdd,
      numberOfClassPeriod: attendanceTeacher?.numberOfClassPeriod ?? 0,
      type: attendanceTeacher?.attendanceType ?? '',
    ));
    late List<bool> isAbsent = [];
    late List<AttendanceDataList> attendanceData = [];
    return BlocProvider(
      create: (_) => attendanceQrBloc,
      child: BlocConsumer<AttendanceQrBloc, AttendanceQrState>(
          listener: (context, state) {
        if (state.attendanceQrStatus == AttendanceQrStatus.fail) {
          Fluttertoast.showToast(
              msg: 'Không lấy được danh sách lớp',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: AppColors.black,
              textColor: AppColors.white);
        } else if (state.attendanceQrStatus ==
            AttendanceQrStatus.successGetList) {
          isAbsent = state.listAttendance
              .map((attendance) =>
                  attendance.status?.contains('vang_mat') ?? false)
              .toList();

          attendanceData = state.listAttendance.map((attendance) {
            return AttendanceDataList(
              pupilId: attendance.pupilId,
              status: isAbsent[state.listAttendance.indexOf(attendance)]
                  ? 'vang_mat'
                  : 'co_mat',
              numberOfClassPeriod: attendanceTeacher?.numberOfClassPeriod ?? 0,
              classId: attendanceTeacher?.classId ?? 0,
              subjectId: attendanceTeacher?.subjectId ?? 0,
            );
          }).toList();
        } else if (state.attendanceQrStatus ==
            AttendanceQrStatus.successPostAttendance) {
          LoadingDialog.hide(context);
          onTapAttendance();
        } else if (state.attendanceQrStatus == AttendanceQrStatus.failPost) {
          LoadingDialog.hide(context);
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: AppColors.black,
              textColor: AppColors.white);
        } else if (state.attendanceQrStatus ==
            AttendanceQrStatus.loadingPostAttendance) {
          LoadingDialog.show(context);
        }
      }, builder: (context, state) {
        return AttendanceQRView(
          type: type,
          attendanceTeacher: attendanceTeacher,
          state: state,
          isAbsent: isAbsent,
          date: date,
          attendanceData: attendanceData,
        );
      }),
    );
  }
}

// ignore: must_be_immutable
class AttendanceQRView extends StatefulWidget {
  AttendanceQRView(
      {Key? key,
      this.type,
      this.attendanceTeacher,
      required this.state,
      required this.attendanceData,
      required this.date,
      required this.isAbsent})
      : super(key: key);
  final int? type;
  final AttendanceTeacher? attendanceTeacher;
  final AttendanceQrState state;
  late List<bool> isAbsent;
  final DateTime date;
  late List<AttendanceDataList> attendanceData;
  @override
  State<AttendanceQRView> createState() => _AttendanceQRViewState();
}

class _AttendanceQRViewState extends State<AttendanceQRView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  void _updateAttendanceDataStatus(int index) {
    setState(() {
      widget.attendanceData[index].status =
          widget.isAbsent[index] ? 'vang_mat' : 'co_mat';
    });
  }

  @override
  Widget build(BuildContext context) {
    int presentCount = widget.state.listAttendance.length -
        widget.isAbsent.where((isAbsent) => isAbsent).length;
    int absent = widget.isAbsent.where((isAbsent) => isAbsent).length;

    return BlocBuilder<AttendanceQrBloc, AttendanceQrState>(
        builder: (context, state) {
      final isLoading =
          state.attendanceQrStatus == AttendanceQrStatus.loadingGetList;
      return Scaffold(
        body: BackGroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenAppBar(
                title: widget.type == 1
                    ? 'LocaleKeys.attendance.tr()'
                    : 'LocaleKeys.attendanceQR.tr()',
                canGoback: true,
                onBack: () {
                  context.pop();
                },
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: AppRadius.roundedTop28,
                  ),
                  child: AppSkeleton(
                    isLoading: isLoading,
                  
                    child: Column(
                      children: [
                        if (widget.type == 1)
                          SelectDate(
                            selectDate: widget.date,
                          ),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            widget.attendanceTeacher
                                                    ?.numberOfClassPeriod
                                                    .toString() ??
                                                '',
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
                                            presentCount.toString(),
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
                                            absent.toString(),
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
                            itemCount: widget.state.listAttendance.length,
                            itemBuilder: (context, index) {
                              final info = widget.state.listAttendance[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.isAbsent[index] =
                                          !widget.isAbsent[index];
                                      _updateAttendanceDataStatus(index);
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    info.urlImage.mobile),
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
                                                info.pupilName,
                                                style: AppTextStyles.normal14(
                                                    color: AppColors.brand600),
                                              ),
                                              Text(
                                                info.pupilId.toString(),
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
                                            widget.isAbsent[index]
                                                ? info.leaveApplicationData
                                                        ?.first.content ??
                                                    'Không phép'
                                                : '',
                                            style: AppTextStyles.normal12(
                                                color: AppColors.orange400),
                                          ),
                                          widget.isAbsent[index]
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 12),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AttendanceQrBloc>()
                                  .add(PostAttendance(
                                    attendanceData: widget.attendanceData,
                                    classId:
                                        widget.attendanceTeacher?.classId ?? 0,
                                    date: widget.date.yyyyMMdd,
                                    numberOfClasspriod: widget.attendanceTeacher
                                            ?.numberOfClassPeriod ??
                                        0,
                                    roomId:
                                        widget.attendanceTeacher?.roomId ?? 0,
                                    roomTitle:
                                        widget.attendanceTeacher?.roomTitle ??
                                            '',
                                    subject:
                                        widget.attendanceTeacher?.subjectId ??
                                            0,
                                    type: widget.attendanceTeacher
                                            ?.attendanceType ??
                                        '',
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(6),
                              backgroundColor: AppColors.red900,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Assets.icons.verifiedCheck.svg(
                                    width: 24,
                                    height: 24,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Hoàn tất điểm danh',
                                    style: AppTextStyles.semiBold14(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
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
            widget.isAbsent[index] = false;
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

class SelectDate extends StatefulWidget {
  const SelectDate(
      {super.key, this.onDatePicked, this.datePicked, this.selectDate});

  final Function(DateTime date)? onDatePicked;
  final DateTime? datePicked;
  final DateTime? selectDate;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime now = DateTime.now();

  DateFormat formatDate = DateFormat('EEEE, dd/MM/yyyy', 'vi_VN');
  late String datePickedFormat;

  @override
  void initState() {
    super.initState();
    if (widget.datePicked != null) {
      datePickedFormat = formatDate.format(widget.datePicked!);
    } else {
      datePickedFormat = formatDate.format(now);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.gray300),
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: const [
          BoxShadow(
            color: AppColors.gray9000c,
            blurRadius: 2,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                  color: AppColors.gray500,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    child: Text(
                      DateFormat('dd/MM/yyyy')
                          .format(widget.selectDate ?? DateTime.now()),
                      style: AppTextStyles.normal16(color: AppColors.gray500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
