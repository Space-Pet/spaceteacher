import 'package:core/common/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/screens/exercise_notice/exercise_screen.dart';
import 'package:iportal2/screens/home/home_navigator.dart';
import 'package:iportal2/screens/home/models/feature_model.dart';
import 'package:iportal2/screens/home/widgets/pin_features/current_pinned_feature.dart';
import 'package:iportal2/screens/home/widgets/pin_features/list_feature.dart';
import 'package:iportal2/screens/leave/on_leave_screen.dart';
import 'package:iportal2/screens/phone_book/phone_book_screen.dart';
import 'package:iportal2/screens/register_notebook/register_notebook_screen.dart';
import 'package:iportal2/screens/student_score/student_score_screen_main.dart';

class BottomSheetFeature extends StatefulWidget {
  const BottomSheetFeature({
    super.key,
    required this.scrollController,
    required this.pinnedFeatures,
    required this.listFeature,
    required this.onSavePinned,
    required this.isKinderGarten,
  });

  final ScrollController scrollController;
  final List<FeatureModel> pinnedFeatures;
  final List<FeatureModel> listFeature;
  final bool isKinderGarten;
  final void Function(List<FeatureModel> pinnedFeatures) onSavePinned;

  @override
  State<BottomSheetFeature> createState() => _BottomSheetFeatureState();
}

class _BottomSheetFeatureState extends State<BottomSheetFeature> {
  bool isUpdatePin = false;

  late List<FeatureModel> tempPinnedFeatures;
  late List<FeatureModel> dailyFeatures;
  late List<FeatureModel> studyInfoFeatures;
  late List<FeatureModel> serviceFeatures;
  late List<FeatureModel> otherFeatures;

  void onSaved(List<FeatureModel> features) {
    setState(() {
      tempPinnedFeatures = features;
    });
    widget.onSavePinned(features);
  }

  bool compareFeaturesDeeply(
      List<FeatureModel> defaultList, List<FeatureModel> tempList) {
    if (defaultList.length != tempList.length) {
      return true;
    }

    for (int i = 0; i < defaultList.length; i++) {
      FeatureModel fDefault = defaultList[i];
      FeatureModel fTemp = tempList[i];

      if (fDefault.id != fTemp.id ||
          fDefault.name != fTemp.name ||
          fDefault.hasPinned != fTemp.hasPinned) {
        return true;
      }
    }
    return false;
  }

  void onTapFeature(int id, bool status) {
    if (isUpdatePin) {
      if (status) {
        if (tempPinnedFeatures.length == 7) {
          SnackBarUtils.showFloatingSnackBar(
              context, 'Chỉ có thể thêm tối đa 7 tính năng yêu thích');
          return;
        }

        final featureAdd = features
            .firstWhere((element) => element.id == id)
            .copyWith(hasPinned: status);

        final newPinnedList = List<FeatureModel>.from(tempPinnedFeatures);
        newPinnedList.add(featureAdd);

        setState(() {
          tempPinnedFeatures = newPinnedList;
        });
      } else {
        final newPinnedList =
            tempPinnedFeatures.where((element) => element.id != id).toList();
        setState(() {
          tempPinnedFeatures = newPinnedList;
        });
      }
    } else {
      Navigator.of(context).pop();

      switch (id) {
        case 1:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: RegisterNoteBoookScreen.routeName);
          break;

        case 4:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: ExerciseScreen.routeName);
          break;

        case 5:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: OnLeaveScreen.routeName);
          break;

        case 6:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: StudentScoreScreenMain.routeName);
          break;

        case 9:
          homeNavigatorKey.currentContext
              ?.pushNamed(routeName: PhoneBookScreen.routeName);
          break;

        default:
      }
    }
  }

  @override
  void initState() {
    super.initState();
    tempPinnedFeatures = widget.pinnedFeatures;
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
    final hasUpdated =
        compareFeaturesDeeply(widget.pinnedFeatures, tempPinnedFeatures);

    return Material(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurrentPinnedFeature(
                listFeature: tempPinnedFeatures,
                isUpdatePin: isUpdatePin,
                onSavePinned: onSaved,
                updatePin: () {
                  setState(() {
                    isUpdatePin = true;
                  });
                },
                removePinned: onTapFeature,
                hasUpdated: hasUpdated,
                isKinderGarten: widget.isKinderGarten,
              ),
              ListFeature(
                title: 'Hoạt động hằng ngày',
                listFeature: dailyFeatures,
                currentPinnedFeatures: tempPinnedFeatures,
                isUpdatePin: isUpdatePin,
                onTapFeature: onTapFeature,
                isKinderGarten: widget.isKinderGarten,
              ),
              ListFeature(
                title: 'Thông tin học tập',
                currentPinnedFeatures: tempPinnedFeatures,
                isUpdatePin: isUpdatePin,
                onTapFeature: onTapFeature,
                listFeature: studyInfoFeatures,
                isKinderGarten: widget.isKinderGarten,
              ),
              ListFeature(
                title: 'Dịch vụ học đường',
                currentPinnedFeatures: tempPinnedFeatures,
                isUpdatePin: isUpdatePin,
                onTapFeature: onTapFeature,
                listFeature: serviceFeatures,
                isKinderGarten: widget.isKinderGarten,
              ),
              ListFeature(
                title: 'Thông tin khác',
                currentPinnedFeatures: tempPinnedFeatures,
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
