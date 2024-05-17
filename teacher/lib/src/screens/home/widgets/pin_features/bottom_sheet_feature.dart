import 'package:core/common/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:teacher/src/screens/bus/bus_screen.dart';
import 'package:teacher/src/screens/gallery/gallery_screen.dart';
import 'package:teacher/src/screens/home/models/feature_model.dart';
import 'package:teacher/src/screens/home/widgets/pin_features/current_pinned_feature.dart';
import 'package:teacher/src/screens/home/widgets/pin_features/list_feature.dart';
import 'package:teacher/src/screens/menu/menu_screen.dart';
import 'package:teacher/src/screens/observation_schedule/screen/observation_schedule_screen.dart';
import 'package:core/presentation/extentions/extension_context.dart';

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
      // Navigator.of(context).pop();

      switch (id) {
        case 1:
          // context.push(const RegisterNoteBoookScreen());

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
          context.push(MenuScreen.routeName);
          break;

        case 5:
          // context.push(const OnLeaveScreen());
          context.push(ObservationSchedule.routeName);
          break;

        case 6:
          // context.push(const StudentScoreScreenMain());
          break;

        case 9:
          break;
        case 12:
          context.push(GalleryScreen.routeName,
              arguments: {'teacherId': 10007548});
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
