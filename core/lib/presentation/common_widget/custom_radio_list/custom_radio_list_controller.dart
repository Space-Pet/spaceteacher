import 'package:flutter/material.dart';

class CustomRadioListItemData<T> {
  final String? title;
  final T? item;

  CustomRadioListItemData(this.title, this.item);
}

class CustomRadioListController<V, T extends CustomRadioListItemData<V>>
    extends ValueNotifier<T?> {
  CustomRadioListController({T? value}) : super(value);
}
