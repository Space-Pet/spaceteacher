import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/input_text.dart';
import 'package:iportal2/resources/app_strings.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/authentication/send_opt/view/send_otp_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  static const routeName = '/forgotPassword';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    TextEditingController phoneNumberController = TextEditingController();

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
                  TitleAndInputText(
                      isValid: isValidPhoneNumber(phoneNumberController.text),
                      title: 'title',
                      hintText: AppStrings.enterPhone,
                      prefixIcon: Assets.icons.phone.image(),
                      onChanged: (value) {
                        phoneNumberController.text = value;
                      }),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (isValidPhoneNumber(phoneNumberController.text)) {
                        context.push(const SendOTPScreen());
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
}

bool isValidPhoneNumber(String input) {
  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
  return phoneRegex.hasMatch(input);
}
