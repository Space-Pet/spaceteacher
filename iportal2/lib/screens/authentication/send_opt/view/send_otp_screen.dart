import 'package:core/resources/app_colors.dart';
import 'package:core/resources/app_strings.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/screens/authentication/change_password/view/change_password.dart';
import 'package:iportal2/screens/authentication/utilites/dialog_utils.dart';
import 'package:iportal2/utils/utils_export.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:repository/repository.dart';
import 'dart:async';

import '../bloc/send_otp_bloc.dart';

class SendOTPScreen extends StatelessWidget {
  const SendOTPScreen({
    super.key,
    required this.phoneNumber,
    required this.userType,
  });
  final String phoneNumber;
  final String userType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendOtpBloc(
        phoneNumber: phoneNumber,
        authRepository: RepositoryProvider.of<AuthRepository>(context),
      )..add(SendOtpRequested()),
      child: BlocListener<SendOtpBloc, SendOtpState>(
        listener: (context, state) {
          switch (state.status) {
            case SendOtpStatus.success:
              LoadingDialog.hide(context);
              context.pushReplacement(ChangePasswordScreen(
                numberPhone: phoneNumber,
                type: userType,
              ));
              break;
            case SendOtpStatus.loading:
              LoadingDialog.show(context);
              break;
            case SendOtpStatus.error:
              LoadingDialog.hide(context);
              Fluttertoast.showToast(
                  msg: 'Lỗi không xác định. Vui lòng thử lại sau.',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: AppColors.black,
                  textColor: AppColors.white);
              break;
            default:
          }
        },
        listenWhen: (previous, current) => previous.status != current.status,
        child: SendOTPView(
          phoneNumber: phoneNumber,
          userType: userType,
        ),
      ),
    );
  }
}

class SendOTPView extends StatefulWidget {
  const SendOTPView({
    super.key,
    required this.phoneNumber,
    required this.userType,
  });

  final String phoneNumber;
  final String userType;

  @override
  State<SendOTPView> createState() => _SendOTPViewState();
}

class _SendOTPViewState extends State<SendOTPView> {
  late int _counter;
  late Timer _timer;
  final TextEditingController _otpController = TextEditingController();

  final int _otpLength = 6;
  @override
  void initState() {
    super.initState();
    _counter = 300;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  bool _isOtpValid(String otp) {
    return otp.length == _otpLength;
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SendOtpBloc>();
    double screenHeight = MediaQuery.of(context).size.height;
    int minutes = (_counter ~/ 60);
    int seconds = _counter % 60;

    String minutesStr = minutes < 10 ? '0$minutes' : '$minutes';
    String secondsStr = seconds < 10 ? '0$seconds' : '$seconds';
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Assets.images.forgot.provider(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    size: 34,
                    color: AppColors.white,
                  )),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 14, right: 14),
                height: screenHeight / 1.8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        AppStrings.enterOTP,
                        style: TextStyle(
                          color: AppColors.blueForgorPassword,
                          fontSize: 23,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.09,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        textAlign: TextAlign.center,
                        AppStrings.textOTP,
                        style: TextStyle(
                          color: AppColors.grayText,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    OTPTextField(
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 60,
                      length: _otpLength,
                      style: const TextStyle(fontSize: 30),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      onChanged: (otp) {
                        setState(() {
                          _otpController.text = otp;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_isOtpValid(_otpController.text)) {
                          bloc.add(SendOtpVerified(otp: _otpController.text));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Mã OTP không hợp lệ'),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: AppColors.primaryRedColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Text(
                                AppStrings.confirm,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Text(
                        '$minutesStr : $secondsStr',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: GestureDetector(
                        onTap: () {
                          bloc.add(SendOtpResent());
                        },
                        child: const Text(
                          AppStrings.resendOTP,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blueForgorPassword,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
