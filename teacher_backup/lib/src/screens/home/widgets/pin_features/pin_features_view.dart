// ignore_for_file: unused_local_variable

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:core/core.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teacher/model/user_info.dart';

import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/i18n/locale_keys.g.dart';

import 'package:teacher/src/screens/bus/bus_screen.dart';
import 'package:teacher/src/screens/gallery/gallery_screen.dart';
import 'package:teacher/src/screens/home/models/feature_model.dart';
import 'package:teacher/src/screens/home/widgets/pin_features/bottom_sheet_feature.dart';
import 'package:teacher/src/screens/home/widgets/pin_features/feature_item.dart';
import 'package:teacher/src/screens/leave/on_leave_screen.dart';
import 'package:teacher/src/screens/menu/menu_screen.dart';
import 'package:teacher/src/screens/observation_schedule/screen/observation_schedule_screen.dart';
import 'package:teacher/src/screens/survey/survey_screen.dart';

import 'package:teacher/src/utils/extension_context.dart';

class PinFeatures extends StatefulWidget {
  const PinFeatures(
      {super.key, required this.isKinderGarten, required this.userInfo});
  final UserInfo userInfo;
  final bool isKinderGarten;

  @override
  State<PinFeatures> createState() => _PinFeaturesState();
}

class _PinFeaturesState extends State<PinFeatures> {
  late List<FeatureModel> featuresByGrade;
  late List<FeatureModel> pinnedFeatures;
  late List<FeatureModel> tempPinnedFeatures;
  void addBtnAllFeatureByDefault() {
    pinnedFeatures.add(FeatureModel(
      id: 999,
      hasPinned: true,
      highSIcon: Assets.icons.features.dots.path,
      preSIcon: Assets.icons.features.dots.path,
      name: LocaleKeys.all.tr(),
      category: FeatureCategory.all,
      gradientType: FeatureGradient.gray,
    ));
  }

  void onSavePinned(List<FeatureModel> newPinnedFeatures) async {
    context.pop();
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      pinnedFeatures = newPinnedFeatures;
      tempPinnedFeatures = List<FeatureModel>.from(pinnedFeatures);
    });

    addBtnAllFeatureByDefault();
  }

  void onTapFeature(FeatureModel feature) async {
    if (feature.category == FeatureCategory.all) {
      showFlexibleBottomSheet(
        minHeight: 0,
        initHeight: 0.95,
        maxHeight: 1,
        context: context,
        builder: (
          BuildContext context,
          ScrollController scrollController,
          double bottomSheetOffset,
        ) =>
            BottomSheetFeature(
          scrollController: scrollController,
          onSavePinned: onSavePinned,
          pinnedFeatures: tempPinnedFeatures,
          listFeature: featuresByGrade,
          isKinderGarten: widget.isKinderGarten,
        ),
        anchors: [0, 1],
        isSafeArea: true,
        bottomSheetBorderRadius: AppRadius.roundedTop16,
      );
    } else {
      switch (feature.id) {
        case 1:
          context.push(SurveyScreen.routeName);
          break;

        case 3:
          context.push(BusScreen.routeName);
          // final UserInfo userInfo =
          //     await UserManager.instance.getUser(Injection.get<Settings>()) ??
          //         UserInfo();
          // // ignore: use_build_context_synchronously
          // context.push(GalleryScreen.routeName,
          //     arguments: {'teacherId': 10007548});
          break;

        case 4:
          context.push(
            MenuScreen.routeName,
            arguments: {
              'userInfo': widget.userInfo,
            },
          );
          break;

        case 5:
          // context.push(const OnLeaveScreen());
          context.push(
            OnLeaveScreen.routeName,
            arguments: {
              'userInfo': widget.userInfo,
            },
          );
          break;

        case 6:
          context.push(ObservationSchedule.routeName);
          // context.push(const StudentScoreScreenMain());
          break;

        case 9:
          break;
        case 12:
          context.push(GalleryScreen.routeName);
          break;

        default:
      }
    }
  }

  @override
  void initState() {
    super.initState();
    featuresByGrade = features
        .where(
          (element) =>
              element.gradeLevel == FeatureGradeLevel.both ||
              (widget.isKinderGarten
                  ? element.gradeLevel == FeatureGradeLevel.preschool
                  : element.gradeLevel == FeatureGradeLevel.highschool),
        )
        .toList();

    pinnedFeatures =
        featuresByGrade.where((element) => element.pinnedDefault).toList();
    tempPinnedFeatures = List<FeatureModel>.from(pinnedFeatures);
    addBtnAllFeatureByDefault();
  }

  @override
  Widget build(BuildContext context) {
    final listFeature = List.generate(pinnedFeatures.length, (index) {
      final feature = pinnedFeatures[index];

      return GestureDetector(
        onTap: () {
          onTapFeature(feature);
        },
        child: FeatureItem(
          feature: feature,
          isPinned: false,
          isUpdatePin: false,
          isKinderGarten: widget.isKinderGarten,
        ),
      );
    });

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      width: double.infinity,
      child: Wrap(
        // spacing: (MediaQuery.of(context).size.width - 372) / 3,
        runSpacing: 16,
        children: listFeature,
      ),
    );
  }
}