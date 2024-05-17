import 'package:flutter/material.dart';
import '../../../core.dart';
import '../../../resources/resources.dart';

class SelectPercent extends StatefulWidget {
  const SelectPercent(
      {super.key, required this.onPercentChanged, required this.hintText});

  final Function(String percent) onPercentChanged;
  final String hintText;

  @override
  State<SelectPercent> createState() => _SelectPercentState();
}

class _SelectPercentState extends State<SelectPercent> {
  String percentSelected = '';

  @override
  void initState() {
    super.initState();
  }

  final List<String> listPercent = [
    '0%',
    '10%',
    '20%',
    '30%',
    '40%',
    '50%',
    '60%',
    '70%',
    '80%',
    '90%',
    '100%',
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pickedPercent = await showDialog(
          context: context,
          useSafeArea: true,
          builder: (context) {
            return Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: AppColors.gray100,
                        ),
                        child: Text(
                          widget.hintText,
                          style: AppTextStyles.bold16(
                              color: AppColors.blueForgorPassword),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: listPercent.map(
                          (String value) {
                            return RadioListTile<String>(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              title: Text(value),
                              value: value,
                              groupValue: percentSelected,
                              controlAffinity: ListTileControlAffinity.trailing,
                              activeColor: AppColors.blueForgorPassword,
                              onChanged: (newValue) {
                                setState(() {
                                  percentSelected = newValue!;
                                  context.pop(result: newValue);
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );

        if (pickedPercent != null) {
          widget.onPercentChanged(pickedPercent);
          setState(() {
            percentSelected = pickedPercent;
          });
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.blueGray100),
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: const [
            BoxShadow(
              color: AppColors.gray9000c,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Text(
                isNullOrEmpty(percentSelected)
                    ? widget.hintText
                    : percentSelected,
                style: AppTextStyles.normal16(color: AppColors.gray500),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 24,
              color: AppColors.gray900,
            ),
          ],
        ),
      ),
    );
  }
}
