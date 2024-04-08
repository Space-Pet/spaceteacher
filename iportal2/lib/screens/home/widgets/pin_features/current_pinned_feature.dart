import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iportal2/components/home_shadow_box.dart';
import 'package:iportal2/screens/home/models/feature_model.dart';
import 'package:iportal2/screens/home/widgets/pin_features/feature_item.dart';
import 'package:iportal2/resources/resources.dart';

class CurrentPinnedFeature extends StatelessWidget {
  const CurrentPinnedFeature({
    super.key,
    required this.listFeature,
    required this.isUpdatePin,
    required this.updatePin,
    required this.removePinned,
    required this.hasUpdated,
    required this.onSavePinned,
    required this.isKinderGarten,
  });

  final List<FeatureModel> listFeature;
  final bool isUpdatePin;
  final bool hasUpdated;
  final bool isKinderGarten;
  final void Function() updatePin;
  final void Function(FeatureKey key, bool status) removePinned;
  final void Function(List<FeatureModel> pinnedFeatures) onSavePinned;

  @override
  Widget build(BuildContext context) {
    final w = SizeUtils.width - 40;

    final features = List.generate(8, (index) {
      final feature = index < listFeature.length
          ? listFeature[index]
          : FeatureModel.empty();

      // Can only pinned 7 features
      // => max index feature slot is 6
      // => 7 is saved button
      return index == 7
          ? GestureDetector(
              onTap: () {
                onSavePinned(listFeature);
              },
              child: SavedButton(w: w, hasUpdated: hasUpdated),
            )
          : index > listFeature.length - 1 && index < 7
              ? DottedBlock(w: w)
              : GestureDetector(
                  onTap: () {
                    removePinned(feature.key, false);
                  },
                  child: FeatureItem(
                    feature: feature,
                    isUpdatePin: isUpdatePin,
                    isPinned: false,
                    isInBottomSheet: true,
                    isPinnedList: true,
                    isKinderGarten: isKinderGarten,
                  ),
                );
    });

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: isUpdatePin ? 250.v : 20,
      child: isUpdatePin
          ? ShaDowBoxContainer(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Text(
                      'Danh mục được ghim',
                      textAlign: TextAlign.left,
                      style: AppTextStyles.semiBold16(
                          color: AppColors.blueGray800),
                    ),
                  ),
                  Expanded(
                    child: Wrap(
                      children: features,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              margin: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        updatePin();
                      },
                      child: SvgPicture.asset('assets/icons/pin.svg')),
                ],
              ),
            ),
    );
  }
}

class DottedBlock extends StatelessWidget {
  const DottedBlock({
    super.key,
    required this.w,
  });

  final double w;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w / 4,
      height: 90.v,
      child: Center(
        child: Column(
          children: [
            DottedBorder(
              dashPattern: const [4, 4],
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              padding: const EdgeInsets.all(4),
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: SizedBox(
                  height: 44,
                  width: 44,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 10,
              width: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: AppColors.gray300,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SavedButton extends StatelessWidget {
  const SavedButton({
    super.key,
    required this.w,
    required this.hasUpdated,
  });

  final double w;
  final bool hasUpdated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w / 4,
      height: 90.v,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: hasUpdated ? AppColors.red90001 : AppColors.gray300,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: const Center(
              child: Icon(
                Icons.save_rounded,
                color: AppColors.white,
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Lưu',
            style: AppTextStyles.custom(
              fontSize: 12.fSize,
              fontWeight: FontWeight.w500,
              height: 20 / 12,
              color: hasUpdated ? AppColors.red90001 : AppColors.gray400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
