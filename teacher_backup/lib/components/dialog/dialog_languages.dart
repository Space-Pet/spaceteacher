import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DialogLanguages extends StatefulWidget {
  const DialogLanguages({
    super.key,
    required this.title,
    this.onSavePressed,
    this.onClosePressed,
    this.selectedLanguage,
    this.onSelectLanguage,
  });

  final String title;
  final Function()? onSavePressed;
  final Function()? onClosePressed;
  final String? selectedLanguage;
  final Function(String)? onSelectLanguage;

  @override
  State<DialogLanguages> createState() => _DialogLanguagesState();
}

class _DialogLanguagesState extends State<DialogLanguages> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      surfaceTintColor: Colors.transparent,
      content: IntrinsicHeight(
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            buildLanguageRow('Tiếng Việt', 'assets/images/vn.png'),
            const SizedBox(height: 16),
            buildLanguageRow('English', 'assets/images/en.png'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: widget.onSavePressed ?? () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redMenu,
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  'Cập nhật',
                  style: TextStyle(color: AppColors.whiteBackground),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color?>(
                  AppColors.white,
                ),
                side: MaterialStateProperty.all<BorderSide>(
                  const BorderSide(color: AppColors.gray300),
                ),
              ),
              onPressed: widget.onClosePressed ?? () => Navigator.pop(context),
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  'Đóng',
                  style: TextStyle(color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLanguageRow(String language, String imagePath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                widget.onSelectLanguage?.call(language);
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  color: Colors.transparent,
                ),
                child: widget.selectedLanguage == language
                    ? const Padding(
                        padding: EdgeInsets.all(4),
                        child: CircleAvatar(
                          backgroundColor: AppColors.black,
                          radius: 4,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              language,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Image.asset(imagePath),
        ),
      ],
    );
  }
}
