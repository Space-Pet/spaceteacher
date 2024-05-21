import 'dart:io';

import 'package:core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/app_main_layout.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/dialog/show_dialog.dart';
import 'package:iportal2/screens/authentication/login/bloc/login_bloc.dart';
import 'package:iportal2/screens/authentication/utilites/dialog_utils.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:repository/repository.dart';

class LoginQRScreen extends StatelessWidget {
  const LoginQRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();
    final currentUserBloc = context.read<CurrentUserBloc>();
    return BlocProvider(
      create: (context) => LoginBloc(
        context: context,
        authRepository: authRepository,
        currentUserBloc: currentUserBloc,
        userRepository: context.read<UserRepository>(),
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) {
          return previous.status != current.status;
        },
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            LoadingDialog.hide(context);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const AppMainLayout(),
              ),
            );
          } else if (state.status == LoginStatus.failure) {
            LoadingDialog.hide(context);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ShowDialog(
                    title: 'Lỗi',
                    textConten: 'Đăng nhập không thành công',
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFECFDF3),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFFD1FADF),
                        child: Icon(
                          Icons.error,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  );
                });
          } else if (state.status == LoginStatus.init ||
              state.status == LoginStatus.loading) {
            LoadingDialog.show(context);
          }
        },
        child: const LoginQRView(),
      ),
    );
  }
}

class LoginQRView extends StatefulWidget {
  const LoginQRView({super.key});

  @override
  State<LoginQRView> createState() => _LoginQRViewState();
}

class _LoginQRViewState extends State<LoginQRView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String? fcmToken;
  bool isCameraRunning = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quét QR'),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios_sharp),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.green,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ],
        ),
      );
    });
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      if (result != null) {
        _stopCamera();
        context.read<LoginBloc>().add(LoginQR(
              qrCode: result!.code.toString(),
            ));
      }
    });
  }

  void _stopCamera() {
    if (controller != null) {
      controller!.pauseCamera();
      setState(() {
        isCameraRunning = false;
      });
    }
  }
}
