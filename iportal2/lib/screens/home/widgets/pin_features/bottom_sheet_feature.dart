import 'package:core/common/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/screens/bus/bus_screen.dart';
import 'package:iportal2/screens/exercise_notice/exercise_screen.dart';
import 'package:iportal2/screens/fee_plan/fee_plan_screen.dart';
import 'package:iportal2/screens/gallery/gallery_screen.dart';
import 'package:iportal2/screens/home/home_navigator.dart';
import 'package:iportal2/screens/home/widgets/pin_features/current_pinned_feature.dart';
import 'package:iportal2/screens/home/widgets/pin_features/list_feature.dart';
import 'package:iportal2/screens/leave/on_leave_screen.dart';
import 'package:iportal2/screens/menu/menu_screen.dart';
import 'package:iportal2/screens/nutrition_heath/nutrition_screen.dart';
import 'package:iportal2/screens/phone_book/phone_book_screen.dart';
import 'package:iportal2/screens/pre_score/preS_score_screen.dart';
import 'package:iportal2/screens/register_notebook/register_notebook_screen.dart';
import 'package:iportal2/screens/school_fee/screen/school_fee_screen.dart';
import 'package:iportal2/screens/score/score_screen.dart';
import 'package:local_data_source/local_data_source.dart';

class BottomSheetFeature extends StatefulWidget {
  const BottomSheetFeature({
    super.key,
    required this.scrollController,
    required this.listFeature,
    required this.onSavePinned,
    required this.isKinderGarten,
  });

  final ScrollController scrollController;
  final List<FeatureModel> listFeature;
  final bool isKinderGarten;
  final void Function(List<FeatureModel> pinnedFeatures) onSavePinned;

  @override
  State<BottomSheetFeature> createState() => _BottomSheetFeatureState();
}

class _BottomSheetFeatureState extends State<BottomSheetFeature> {
  bool isUpdatePin = false;

  late List<FeatureModel> tempFeatures;
  late List<FeatureModel> dailyFeatures;
  late List<FeatureModel> studyInfoFeatures;
  late List<FeatureModel> serviceFeatures;
  late List<FeatureModel> otherFeatures;
  late List<FeatureModel> currentPinnedFeature;

  void onSaved() {
    widget.onSavePinned(tempFeatures);
  }

  bool compareFeaturesDeeply(
      List<FeatureModel> defaultList, List<FeatureModel> tempList) {
    for (int i = 0; i < defaultList.length; i++) {
      FeatureModel fDefault = defaultList[i];
      FeatureModel fTemp = tempList[i];

      if (fDefault.key != fTemp.key ||
          fDefault.pinned != fTemp.pinned ||
          fDefault.order != fTemp.order) {
        return true;
      }
    }
    return false;
  }

  void onTapFeature(FeatureKey key, bool status) {
    if (isUpdatePin) {
      if (status) {
        if (currentPinnedFeature.length == 7) {
          SnackBarUtils.showFloatingSnackBar(
              context, 'Chỉ có thể thêm tối đa 7 tính năng yêu thích');
          return;
        }

        final newPinFeature =
            tempFeatures.firstWhere((element) => element.key == key).copyWith(
                  pinned: status,
                  order: currentPinnedFeature.isEmpty
                      ? 1
                      : currentPinnedFeature[currentPinnedFeature.length - 1]
                              .order +
                          1,
                );

        setState(() {
          tempFeatures = tempFeatures
              .map((e) => e.key == key ? newPinFeature : e)
              .toList();
          currentPinnedFeature = tempFeatures
              .where((element) => element.pinned)
              .toList()
            ..sort((a, b) => a.order.compareTo(b.order));
        });
      } else {
        final unPinFeature = tempFeatures
            .firstWhere((element) => element.key == key)
            .copyWith(pinned: status);

        setState(() {
          tempFeatures =
              tempFeatures.map((e) => e.key == key ? unPinFeature : e).toList();
          currentPinnedFeature = tempFeatures
              .where((element) => element.pinned)
              .toList()
            ..sort((a, b) => a.order.compareTo(b.order));
        });
      }
    } else {
      Navigator.of(context).pop();

      switch (key) {
        case FeatureKey.registerNotebook:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: RegisterNoteBoookScreen.routeName);
          break;

        case FeatureKey.instructionNotebook:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: ExerciseScreen.routeName);
          break;

        case FeatureKey.onLeave:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: OnLeaveScreen.routeName);
          break;

        case FeatureKey.scores:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: ScoreScreen.routeName);
          break;

        case FeatureKey.comment:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: PreScoreScreen.routeName);
          break;

        case FeatureKey.phoneBook:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: PhoneBookScreen.routeName);
          break;

        case FeatureKey.health:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: NutritionScreen.routeName);
          break;

        case FeatureKey.gallery:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: GalleryScreen.routeName);
          break;

        case FeatureKey.menu:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: MenuScreen.routeName);
          break;
        case FeatureKey.bus:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: BusScreen.routeName);
          break;
        case FeatureKey.tariff:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: FeePlanScreen.routeName);
          break;
        case FeatureKey.tuition:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: SchoolFeeScreen.routeName);
          break;

        default:
      }
    }
  }

  @override
  void initState() {
    super.initState();
    tempFeatures = widget.listFeature;
    currentPinnedFeature = tempFeatures
        .where((element) => element.pinned)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));

    dailyFeatures = widget.listFeature
        .where((element) => element.category == FeatureCategory.daily)
        .toList();

    studyInfoFeatures = widget.listFeature
        .where((element) => element.category == FeatureCategory.studyInfo)
        .toList();

    serviceFeatures = widget.listFeature
        .where((element) => element.category == FeatureCategory.services)
        .toList();

    otherFeatures = widget.listFeature
        .where((element) => element.category == FeatureCategory.other)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasUpdated = compareFeaturesDeeply(widget.listFeature, tempFeatures);

    return Material(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurrentPinnedFeature(
                listFeature: currentPinnedFeature,
                isUpdatePin: isUpdatePin,
                onSavePinned: onSaved,
                updatePin: () {
                  setState(() {
                    isUpdatePin = !isUpdatePin;
                  });
                },
                removePinned: onTapFeature,
                hasUpdated: hasUpdated,
                isKinderGarten: widget.isKinderGarten,
              ),
              ListFeature(
                title: 'Hoạt động hằng ngày',
                listFeature: dailyFeatures,
                currentPinnedFeatures: currentPinnedFeature,
                isUpdatePin: isUpdatePin,
                onTapFeature: onTapFeature,
                isKinderGarten: widget.isKinderGarten,
              ),
              ListFeature(
                title: 'Thông tin học tập',
                currentPinnedFeatures: currentPinnedFeature,
                isUpdatePin: isUpdatePin,
                onTapFeature: onTapFeature,
                listFeature: studyInfoFeatures,
                isKinderGarten: widget.isKinderGarten,
              ),
              ListFeature(
                title: 'Dịch vụ học đường',
                currentPinnedFeatures: currentPinnedFeature,
                isUpdatePin: isUpdatePin,
                onTapFeature: onTapFeature,
                listFeature: serviceFeatures,
                isKinderGarten: widget.isKinderGarten,
              ),
              ListFeature(
                title: 'Thông tin khác',
                currentPinnedFeatures: currentPinnedFeature,
                isUpdatePin: isUpdatePin,
                onTapFeature: onTapFeature,
                listFeature: otherFeatures,
                isKinderGarten: widget.isKinderGarten,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
