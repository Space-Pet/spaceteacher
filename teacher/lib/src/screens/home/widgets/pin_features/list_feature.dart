import 'package:flutter/material.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/home/models/feature_model.dart';
import 'package:teacher/src/screens/home/widgets/pin_features/feature_item.dart';

class ListFeature extends StatelessWidget {
  const ListFeature({
    super.key,
    required this.listFeature,
    required this.currentPinnedFeatures,
    required this.isUpdatePin,
    required this.title,
    required this.onTapFeature,
    required this.isKinderGarten,
  });

  final List<FeatureModel> listFeature;
  final List<FeatureModel> currentPinnedFeatures;
  final String title;
  final bool isUpdatePin;
  final bool isKinderGarten;
  final void Function(int id, bool status) onTapFeature;

  @override
  Widget build(BuildContext context) {
    final listPinnedId = currentPinnedFeatures.map((e) => e.id).toList();
    final features = List.generate(listFeature.length, (index) {
      final feature = listFeature[index];

      final isPinned = listPinnedId.contains(feature.id);

      return GestureDetector(
        onTap: () {
          onTapFeature(feature.id, !isPinned);
        },
        child: FeatureItem(
          feature: feature,
          isInBottomSheet: true,
          isUpdatePin: isUpdatePin,
          isPinned: isPinned,
          isKinderGarten: isKinderGarten,
        ),
      );
    });

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 16),
            child: Text(
              title,
              style: AppTextStyles.semiBold14(color: AppColors.blueGray800),
            ),
          ),
          Wrap(
            spacing: (MediaQuery.of(context).size.width - 372) / 3,
            children: features,
          ),
        ],
      ),
    );
  }
}
