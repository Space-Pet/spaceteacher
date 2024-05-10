import 'package:flutter/material.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/utils/extension_context.dart';

class HourAssessmentScreen extends StatefulWidget {
  static const routeName = '/hour_assessment';
  const HourAssessmentScreen({super.key});

  @override
  State<HourAssessmentScreen> createState() => _HourAssessmentScreenState();
}

class _HourAssessmentScreenState extends State<HourAssessmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundContainer(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned.fill(
              top: -20,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                child: ScreensAppBar(
                  '26 Th01,2024',
                  canGoBack: true,
                  onBack: () {
                    context.pop();
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.observationStatusMyObsBG,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Gửi đánh giá',
                    style: AppTextStyles.bold16(color: AppColors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
