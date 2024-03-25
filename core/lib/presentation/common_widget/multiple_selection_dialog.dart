import 'package:flutter/material.dart';

import '../../common/utils.dart';
import '../theme/theme_button.dart';
import 'input_container/input_container.dart';

class MultipleSelectionDialog<T> extends StatefulWidget {
  final List<T> items;
  final List<T>? initalItems;
  final Function(List<T>) onSelected;
  final Function onCancel;
  final Widget Function(BuildContext, T, bool) itemBuilder;
  final bool Function(T item, String? filter) filterFn;
  final bool Function(T, T)? compareFunction;
  final dynamic trans;

  const MultipleSelectionDialog({
    Key? key,
    required this.items,
    this.initalItems,
    this.compareFunction,
    required this.onSelected,
    required this.onCancel,
    required this.itemBuilder,
    required this.filterFn,
    required this.trans,
  }) : super(key: key);

  @override
  _MultipleSelectionDialog<T> createState() => _MultipleSelectionDialog<T>();
}

class _MultipleSelectionDialog<T> extends State<MultipleSelectionDialog<T>> {
  late ValueNotifier<List<T>> searchNotifier;
  late Debouncer _debouncer;

  late final List<T> multipleSelected = widget.initalItems ?? [];

  @override
  void initState() {
    searchNotifier = ValueNotifier(widget.items);
    _debouncer = Debouncer<String>(const Duration(milliseconds: 500), search);
    super.initState();
  }

  @override
  void dispose() {
    searchNotifier.dispose();
    super.dispose();
  }

  void search(String? filter) {
    final result = widget.items.where((element) {
      return widget.filterFn(element, filter);
    }).toList();

    searchNotifier.value = result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _toolbar(context),
                  InputContainer(
                    hint: widget.trans.search,
                    onTextChanged: (text) {
                      _debouncer.value = text;
                    },
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ValueListenableBuilder<List<T>>(
                      valueListenable: searchNotifier,
                      builder: (ctx, items, w) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          addAutomaticKeepAlives: false,
                          itemBuilder: (ctx, idx) {
                            final item = items[idx];
                            final index = _indexOfSelected(item);
                            final selected = index != -1;
                            return InkWell(
                              onTap: () {
                                if (selected) {
                                  setState(() {
                                    multipleSelected.removeAt(index);
                                  });
                                  return;
                                }

                                setState(() {
                                  multipleSelected.add(items[idx]);
                                });
                              },
                              child:
                                  widget.itemBuilder(ctx, items[idx], selected),
                            );
                          },
                          itemCount: items.length,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _toolbar(BuildContext context) => Container(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            ThemeButton.notRecommend(
              context: context,
              title: widget.trans.cancel,
              onPressed: () {
                widget.onCancel();
              },
            ),
            Expanded(child: Container()),
            ThemeButton.recommend(
              context: context,
              title: widget.trans.confirm,
              onPressed: () {
                widget.onSelected.call(multipleSelected);
              },
            ),
          ],
        ),
      );

  // bool _isItemSelected(T item) {
  //   return _indexOfSelected(item) != -1;
  // }

  int _indexOfSelected(T item) {
    return multipleSelected.indexWhere((element) => _isEqual(element, item));
  }

  bool _isEqual(T first, T second) {
    if (widget.compareFunction != null) {
      return widget.compareFunction!.call(first, second);
    }
    return first == second;
  }
}
