import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';

class NotiMultiSelect extends StatefulWidget {
  const NotiMultiSelect({
    super.key,
    required this.listSelectedPupilId,
    required this.listPupil,
  });

  final List<PupilInClass> listPupil;
  final List<int> listSelectedPupilId;

  @override
  State<NotiMultiSelect> createState() => _MultiSelectItemPageState();
}

class _MultiSelectItemPageState extends State<NotiMultiSelect> {
  List<int> listPupilId = [];
  List<PupilInClass> listPupilState = [];
  String search = '';

  @override
  void initState() {
    super.initState();
    listPupilState = widget.listPupil;
    // clone list widget.listSelectedPupilId to listPupilId

    listPupilId = List<int>.from(widget.listSelectedPupilId);
    if (widget.listPupil.isNotEmpty && widget.listPupil[0].pupilId != 0) {
      listPupilState.insert(0, PupilInClass.empty());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.9,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Column(
            children: [
              Text('Chọn người nhận thông báo',
                  style: AppTextStyles.semiBold16()),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TitleAndInputText(
                  obscureText: false,
                  hintText: 'Tìm kiếm theo tên',
                  onChanged: (value) {
                    setState(() {
                      search = value;
                      if (value.isEmpty) {
                        listPupilState = widget.listPupil;
                      } else {
                        listPupilState = widget.listPupil
                            .where((element) => element.fullName
                                .toLowerCase()
                                .contains(search.toLowerCase()))
                            .toList();
                      }
                    });
                  },
                  prefixIcon: Assets.images.search.image(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (builder, index) {
                    final pupil = listPupilState[index];
                    final isSelected = index == 0
                        ? listPupilId.length == listPupilState.length
                        : listPupilId.contains(pupil.pupilId);

                    return ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      onTap: () {
                        if (index == 0) {
                          setState(() {
                            if (isSelected) {
                              listPupilId.clear();
                            } else {
                              listPupilId.clear();
                              listPupilId
                                  .addAll(listPupilState.map((e) => e.pupilId));
                            }
                          });
                          return;
                        }

                        setState(() {
                          if (isSelected) {
                            listPupilId.remove(pupil.pupilId);
                          } else {
                            listPupilId.add(pupil.pupilId);
                          }
                        });
                      },
                      title: Row(
                        children: [
                          Text(
                            pupil.fullName,
                            style: AppTextStyles.normal14(),
                          ),
                        ],
                      ),
                      // subtitle: Container(
                      //   child: Wrap(
                      //     children: [
                      //       Text("Email    :   "),
                      //     ],
                      //   ),
                      // ),
                      trailing: Icon(
                        isSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: AppColors.brand600,
                      ),
                      // leading: _mainUI(isSelectedData!, data),
                    );
                  },
                  itemCount: listPupilState.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color?>(AppColors.red90001),
                    side: WidgetStateProperty.all<BorderSide>(
                      const BorderSide(color: AppColors.red90001),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, listPupilId);
                  },
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        style: AppTextStyles.semiBold16(color: AppColors.white),
                        'Xác nhận',
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
