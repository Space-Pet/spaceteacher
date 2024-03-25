import 'package:flutter/material.dart';

class FeatureModel {
  final int id;
  final List<Color> gradientColors;
  final String iconPath;
  final String name;
  final bool hasPinned;
  final FeatureCategory category;

  FeatureModel({
    required this.id,
    required this.gradientColors,
    required this.iconPath,
    required this.name,
    required this.hasPinned,
    required this.category,
  });

  FeatureModel copyWith({
    int? ind,
    bool? hasPinned,
    List<Color>? gradientColors,
    String? iconPath,
    String? name,
    FeatureCategory? category,
  }) {
    return FeatureModel(
      id: id,
      hasPinned: hasPinned ?? this.hasPinned,
      gradientColors: gradientColors ?? this.gradientColors,
      iconPath: iconPath ?? this.iconPath,
      name: name ?? this.name,
      category: category ?? this.category,
    );
  }

  factory FeatureModel.empty() => FeatureModel(
        id: -1,
        category: FeatureCategory.other,
        hasPinned: false,
        iconPath: '',
        gradientColors: [],
        name: '',
      );
}

enum FeatureCategory { daily, studyInfo, services, other, all, exercise }
