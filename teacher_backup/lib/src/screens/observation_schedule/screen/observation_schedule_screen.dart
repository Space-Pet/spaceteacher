import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/resources/assets.gen.dart';

import 'package:teacher/src/screens/observation_schedule/mock_data/subject_mock.dart';
import 'package:teacher/src/screens/observation_schedule/screen/create_observation/create_observation_screen.dart';
import 'package:teacher/src/screens/observation_schedule/screen/observation_detail/overvation_detail_screen.dart';
import 'package:teacher/src/screens/observation_schedule/widgets/card_observation.dart';
import 'package:teacher/src/screens/observation_schedule/widgets/filter_observation.dart';
import 'package:teacher/src/utils/extension_context.dart';

class ObservationSchedule extends StatefulWidget {
  static const routeName = '/observation_schedule';
  const ObservationSchedule({super.key});

  @override
  State<ObservationSchedule> createState() => _ObservationScheduleState();
}

class _ObservationScheduleState extends State<ObservationSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundContainer(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ScreenAppBar(
                title: 'Observation Schedule',
                canGoback: true,
                onBack: () {
                  context.pop();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // seach bar & filter button
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: AppColors.gray400),
                              ),
                              fillColor: AppColors.gray400,
                              hintText: 'Search observation schedule',
                              prefixIcon: Image.asset(
                                Assets.images.search.path,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showGeneralDialog(
                              context: context,
                              routeSettings: const RouteSettings(
                                  name: FilterObservation.routeName),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const FilterObservation(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: AppColors.gray400,
                              ),
                            ),
                            child: Assets.icons.filter
                                .svg(color: AppColors.gray500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // list of observation schedule
                  Row(
                    children: [
                      Text(
                        '29 Th02,2024',
                        style: AppTextStyles.bold16(
                          color: AppColors.blueForgorPassword,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Thứ 3',
                        style: AppTextStyles.normal16(
                          color: AppColors.gray400,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (ctx, index) {
                        final it = listMockSubjectData[index];
                        return GestureDetector(
                          onTap: () {
                            context.push(
                              ObservationDetailScreen.routeName,
                              arguments: {
                                'data': it,
                                'typeObservation': it.typeObservation,
                              },
                            );
                          },
                          child: CardObservation(
                            isFirstIndex: it.id == listMockSubjectData.first.id,
                            isLastIndex: it.id == listMockSubjectData.last.id,
                            nameObservation: it.nameObservation ?? "",
                            time: it.time ?? "",
                            descriptionSubjectLesson:
                                it.descriptionSubjectLesson ?? "",
                            tietNum: '${it.subjectModel?.tietNum}',
                            teacherName: it.subjectModel?.teacherName ?? "",
                            typeObservation: it.typeObservation ?? 0,
                          ),
                        );
                      },
                      itemCount: listMockSubjectData.length,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () {
                      context.push(
                        CreateObservationScreen.routeName,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.observationStatusMyObsBG,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: AppColors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Mở lớp dự giờ',
                          style: AppTextStyles.bold16(color: AppColors.white),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
