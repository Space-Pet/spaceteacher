import 'dart:async';
import 'dart:io';
import 'package:core/resources/app_colors.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getFCMToken();
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

  Future<void> getFCMToken() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    fcmToken = await firebaseMessaging.getToken();

    print(fcmToken);
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      deviceData = switch (defaultTargetPlatform) {
        TargetPlatform.android =>
          _readAndroidBuildData(await deviceInfoPlugin.androidInfo),
        TargetPlatform.iOS =>
          _readIosDeviceInfo(await deviceInfoPlugin.iosInfo),
        _ => {},
      };
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'model': build.model,
      'id': build.id,
      'version.release': build.version.release,
      'platform': 'Android',
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'model': data.model,
      'platform': 'iOS',
    };
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
        final deviceId = await _getDeviceId();
        final platform = Platform.isAndroid ? 'Android' : 'iOS';
        context.read<LoginBloc>().add(LoginQR(
              deviceId: deviceId,
              model: _deviceData['model'],
              platform: platform,
              qrCode: result!.code.toString(),
              tokenFirebase: fcmToken ?? '',
            ));

        print(result!.code.toString());
      }
    });
  }

  Future<String> _getDeviceId() async {
    if (Platform.isAndroid) {
      // Lấy thông tin về thiết bị Android
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      // Lấy thông tin về thiết bị iOS
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.systemName;
    } else {
      // Nếu không phải Android hoặc iOS, trả về giá trị mặc định
      return 'Unknown';
    }
  }

  void _startCamera() {
    if (controller != null) {
      controller!.resumeCamera();
      setState(() {
        isCameraRunning = true;
      });
    }
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
