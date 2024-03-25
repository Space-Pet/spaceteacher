import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/resources/app_decoration.dart';
import 'package:iportal2/screens/bus/bus_screen.dart';
import 'package:iportal2/screens/exercise_notice/exercise_screen.dart';
import 'package:iportal2/screens/home/models/feature_model.dart';
import 'package:iportal2/screens/home/widgets/pin_features/bottom_sheet_feature.dart';
import 'package:iportal2/screens/home/widgets/pin_features/feature_item.dart';
import 'package:iportal2/screens/leave/on_leave_screen.dart';
import 'package:iportal2/screens/phone_book/phone_book_screen.dart';
import 'package:iportal2/screens/register_notebook/register_notebook_screen.dart';
import 'package:iportal2/screens/student_score/student_score_screen_main.dart';

class PinFeatures extends StatefulWidget {
  const PinFeatures({
    super.key,
    required this.isKinderGarten,
  });

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
      highSIcon: 'dots',
      preSIcon: 'dots',
      name: 'Tất cả',
      category: FeatureCategory.all,
      gradientType: FeatureGradient.gray,
    ));
  }

  void onSavePinned(List<FeatureModel> newPinnedFeatures) async {
    Navigator.of(context).pop();
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      pinnedFeatures = newPinnedFeatures;
      tempPinnedFeatures = List<FeatureModel>.from(pinnedFeatures);
    });

    addBtnAllFeatureByDefault();
  }

  void onTapFeature(FeatureModel feature) {
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
          context.push(const RegisterNoteBoookScreen());
          break;

        case 3:
          context.push(const BusScreen());
          break;

        case 4:
          context.push(const ExerciseScreen());
          break;

        case 5:
          context.push(const OnLeaveScreen());
          break;

        case 6:
          context.push(const StudentScoreScreenMain());
          break;

        case 9:
          context.push(const PhoneBookScreen());
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
        children: listFeature,
      ),
    );
  }
}
