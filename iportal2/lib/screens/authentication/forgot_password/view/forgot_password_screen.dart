import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/input_text.dart';
import 'package:iportal2/resources/app_strings.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/authentication/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:iportal2/screens/authentication/send_opt/view/send_otp_screen.dart';
import 'package:iportal2/screens/authentication/utilites/dialog_utils.dart';
import 'package:iportal2/utils/utils_export.dart';
import 'package:repository/repository.dart';

enum UserType { parent, pupil }

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  static const routeName = '/forgotPassword';
  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();
    TextEditingController phoneNumberController =
        TextEditingController(); // Khai báo ở mức trên của class
    UserType selectedType = UserType.parent;
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(authRepository: authRepository),
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listenWhen: (previous, current) {
          return previous.forgotPasswordStatus != current.forgotPasswordStatus;
        },
        listener: (context, state) {
          if (state.forgotPasswordStatus == ForgotPasswordStatus.loading) {
            LoadingDialog.show(context);
          } else if (state.forgotPasswordStatus == ForgotPasswordStatus.error) {
            LoadingDialog.hide(context);
            Fluttertoast.showToast(
                msg: state.message ?? 'Lỗi hệ thống',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.black,
                textColor: AppColors.white);
          } else if (state.forgotPasswordStatus ==
              ForgotPasswordStatus.success) {
            LoadingDialog.hide(context);
            context.pushReplacement(
              SendOTPScreen(
                numberPhone: phoneNumberController.text,
                type: selectedType.name,
              ),
            );
          }
        },
        child: ForgotPasswordView(
          phoneNumberController:
              phoneNumberController, // Truyền controller vào widget con
          selectedType: selectedType,
        ),
      ),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView(
      {super.key,
      required this.phoneNumberController,
      required this.selectedType});
  final TextEditingController phoneNumberController;
  UserType selectedType;
  final List<String> tabs = ['Cha mẹ học sinh', 'Học sinh'];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.images.forgot.provider(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 8, right: 12),
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
                  top: 6, bottom: 24, left: 14, right: 14),
              height: screenHeight / 1.7,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 4),
                    child: Text(
                      AppStrings.titleForgotPassword,
                      style: AppTextStyles.bold16(
                        color: AppColors.textTitleLogin,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
                    child: Text(
                      textAlign: TextAlign.center,
                      AppStrings.derForgotPassword,
                      style: AppTextStyles.normal14(color: AppColors.gray79),
                    ),
                  ),
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.blackTransparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: TabBar(
                                labelColor: AppColors.white,
                                unselectedLabelColor: AppColors.gray400,
                                dividerColor: Colors.transparent,
                                labelStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                unselectedLabelStyle: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                indicator: BoxDecoration(
                                  color: AppColors.brand600,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                indicatorPadding:
                                    const EdgeInsets.symmetric(horizontal: -15),
                                tabs: _buildTabs(),
                                onTap: (index) {
                                  if (index == 0) {
                                    selectedType = UserType.parent;
                                  } else {
                                    selectedType = UserType.pupil;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: TitleAndInputText(
                        isValid: isValidPhoneNumber(phoneNumberController.text),
                        title: 'title',
                        textInputType: false,
                        hintText: AppStrings.enterPhone,
                        prefixIcon: Assets.icons.phone.image(),
                        onChanged: (value) {
                          phoneNumberController.text = value;
                        }),
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (isValidPhoneNumber(phoneNumberController.text)) {
                        context.read<ForgotPasswordBloc>().add(CheckNumberPhone(
                            numnberPhone: phoneNumberController.text,
                            type: selectedType.name));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Số điện thoại chưa đúng'),
                        ));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
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
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: Text(
                              AppStrings.next,
                              style:
                                  AppTextStyles.semiBold16(color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  List<Widget> _buildTabs() {
    return tabs.map((title) {
      return Tab(
        child: Align(
          child: Center(
              child: Text(
            title,
            textAlign: TextAlign.center,
          )),
        ),
      );
    }).toList();
  }
}

bool isValidPhoneNumber(String input) {
  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
  return phoneRegex.hasMatch(input);
}
