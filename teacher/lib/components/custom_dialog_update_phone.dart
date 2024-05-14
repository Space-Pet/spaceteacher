import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/textfield/input_text.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/resources.dart';

class CustomDialogUpdatePhone extends StatelessWidget {
  final String title;
  final String saveButtonTitle;
  final String closeButtonTitle;
  final Function()? onSavePressed;
  final Function()? onClosePressed;
  final TextEditingController? textController;
  const CustomDialogUpdatePhone({
    super.key,
    required this.title,
    required this.saveButtonTitle,
    required this.closeButtonTitle,
    this.textController,
    this.onSavePressed,
    this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        textAlign: TextAlign.center,
        title,
        style: AppTextStyles.semiBold18(),
      ),
      surfaceTintColor: Colors.transparent,
      content: SizedBox(
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TitleAndInputText(
                keyboardType: TextInputType.phone,
                hintText: 'enter new phone num'.tr(),
                onChanged: (value) {},
                prefixIcon: Assets.icons.phone.image(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 6),
                child: ElevatedButton(
                  onPressed: onSavePressed ?? () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redMenu),
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        saveButtonTitle,
                        style:
                            const TextStyle(color: AppColors.whiteBackground),
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color?>(AppColors.white),
                  side: WidgetStateProperty.all<BorderSide>(
                    const BorderSide(color: AppColors.gray300),
                  ),
                ),
                onPressed: onClosePressed ?? () => Navigator.pop(context),
                child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      style: const TextStyle(color: AppColors.black),
                      closeButtonTitle,
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
