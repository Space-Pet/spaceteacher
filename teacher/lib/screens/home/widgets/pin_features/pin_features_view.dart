import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:teacher/screens/bus/bus_screen.dart';
import 'package:teacher/screens/exercise_notice/exercise_screen.dart';
import 'package:teacher/screens/fee_plan/fee_plan_screen.dart';
import 'package:teacher/screens/gallery/gallery_screen.dart';
import 'package:teacher/screens/home/widgets/pin_features/bottom_sheet_feature.dart';
import 'package:teacher/screens/home/widgets/pin_features/feature_item.dart';
import 'package:teacher/screens/leave/on_leave_screen.dart';
import 'package:teacher/screens/menu/menu_screen.dart';
import 'package:teacher/screens/nutrition_heath/nutrition_screen.dart';
import 'package:teacher/screens/phone_book/phone_book_screen.dart';
import 'package:teacher/screens/pre_score/preS_score_screen.dart';
import 'package:teacher/screens/register_notebook/register_notebook_screen.dart';
import 'package:teacher/screens/score/score_screen.dart';
import 'package:teacher/screens/survey_iportal2/survey_screen.dart';
import 'package:local_data_source/local_data_source.dart';
import 'package:repository/repository.dart';

class PinFeatures extends StatefulWidget {
  const PinFeatures({
    super.key,
    required this.isKinderGarten,
    required this.userFeatures,
  });

  final bool isKinderGarten;
  final List<FeatureModel> userFeatures;

  @override
  State<PinFeatures> createState() => _PinFeaturesState();
}

class _PinFeaturesState extends State<PinFeatures> {
  late List<FeatureModel> pinnedFeatures;

  void addBtnAllFeatureByDefault() {
    pinnedFeatures.add(FeatureModel(
      key: FeatureKey.all,
      name: 'Tất cả',
      icon: 'dots',
      category: FeatureCategory.all,
      order: 8,
    ));
  }

  void onSavePinned(List<FeatureModel> newListFeatures) async {
    final userBloc = context.read<CurrentUserBloc>();
    final userRepository = context.read<UserRepository>();

    Navigator.of(context).pop();
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      pinnedFeatures = newListFeatures
          .where((element) => element.pinned)
          .toList()
        ..sort((a, b) => a.order.compareTo(b.order));
    });

    addBtnAllFeatureByDefault();

    final newUserFeatures = userBloc.state.user.copyWith(
      features: newListFeatures,
    );
    userRepository.saveUser(newUserFeatures);
    userBloc.add(CurrentUserUpdated(user: newUserFeatures));
  }

  void onTapFeature(FeatureModel feature) {
    if (feature.category == FeatureCategory.all) {
      showFlexibleBottomSheet(
        minHeight: 0,
        initHeight: widget.isKinderGarten ? 0.9 : 0.95,
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
          listFeature: widget.userFeatures,
          isKinderGarten: widget.isKinderGarten,
        ),
        anchors: [0, 1],
        isSafeArea: true,
        bottomSheetBorderRadius: AppRadius.roundedTop16,
      );
    } else {
      switch (feature.key) {
        case FeatureKey.registerNotebook:
          context.push(const RegisterNoteBoookScreen());
          break;

        case FeatureKey.bus:
          context.push(const BusScreen());
          break;
        case FeatureKey.tariff:
          context.push(const FeePlanScreen());
          break;

        case FeatureKey.instructionNotebook:
          context.push(const ExerciseScreen());
          break;

        case FeatureKey.onLeave:
          context.push(const OnLeaveScreen());
          break;

        case FeatureKey.scores:
          context.push(const ScoreScreen());
          break;
        case FeatureKey.comment:
          context.push(const PreScoreScreen());
          break;

        case FeatureKey.phoneBook:
          context.push(const PhoneBookScreen());
          break;

        case FeatureKey.health:
          context.push(const NutritionScreen());
          break;

        case FeatureKey.gallery:
          context.push(const GalleryScreen());
          break;

        case FeatureKey.menu:
          context.push(const MenuScreen());
          break;
        case FeatureKey.survey:
          mainNavKey.currentContext?.push(const SurveyScreen());

          break;

        default:
      }
    }
  }

  @override
  void initState() {
    super.initState();
    pinnedFeatures = widget.userFeatures
        .where((element) => element.pinned)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));

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
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      width: double.infinity,
      child: Wrap(
        children: listFeature,
      ),
    );
  }
}