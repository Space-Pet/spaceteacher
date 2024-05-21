import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';

import 'package:teacher/src/screens/observation_schedule/widgets/card_filter_observation.dart';

import 'package:teacher/src/utils/extension_context.dart';

class FilterObservation extends StatefulWidget {
  const FilterObservation({super.key});
  static const routeName = '/filter_observation';

  @override
  State<FilterObservation> createState() => _FilterObservationState();
}

class _FilterObservationState extends State<FilterObservation> {
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
                  'Filter',
                  canGoBack: true,
                  onBack: () {
                    context.pop();
                  },
                  actionWidget: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    maxRadius: 20,
                    child: IconButton(
                      // padding: EdgeInsets.zero,
                      icon: const Icon(Icons.refresh_outlined,
                          color: AppColors.white),
                      onPressed: () {
                        // context.pop();
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 100),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: const Column(
                  children: [
                    CardFilterObservation(
                      title: 'Subject',
                      typeField: 1,
                    ),
                    CardFilterObservation(
                      title: 'Teacher',
                      typeField: 2,
                    ),
                    CardFilterObservation(
                      title: 'Class',
                      typeField: 3,
                    ),
                    CardFilterObservation(
                      title: 'Lesson',
                      typeField: 4,
                    ),
                  ],
                )),
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
                    'Apply Filter',
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
