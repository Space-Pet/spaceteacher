import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/screens/score/widgets/score_card_subject/score_card_subject.dart';

class MoetView extends StatefulWidget {
  const MoetView({
    super.key,
     this.diemMoetTxt,
    required this.isSecondSemester,
  });

  final TxtDiemMoetType? diemMoetTxt;
  final bool isSecondSemester;

  @override
  State<MoetView> createState() => _TabViewMonet();
}

class _TabViewMonet extends State<MoetView> {
  int? expandedIndex;
  TextEditingController diemTBM = TextEditingController();
  TextEditingController kqht = TextEditingController();
  TextEditingController kqrl = TextEditingController();
  TextEditingController xlhl = TextEditingController();
  TextEditingController xlhk = TextEditingController();
  TextEditingController dh = TextEditingController();
  late TextEditingController _commentController;
  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController(
        text:
            'Thai rat toasdfsafhsalkfjhdslkfhsdlfkhdsfokldshfsdkljfhdskljfhdsljkfhdskjlfh  sdjklhdsjkldskljdsjklfhsdklt');
  }

  void _handleExpansion(int index) {
    if (index == expandedIndex) {
      setState(() {
        expandedIndex = null;
      });
    } else {
      setState(() {
        expandedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        children: [
          if (widget.isSecondSemester)
            SummaryGroup(
              category: 'Điểm trung bình môn',
              evaluation: '',
              textColor: AppColors.red90001,
              onSelected: (value) {
                setState(() {
                  diemTBM.text = value;
                });
              },
            ),
          SummaryGroup(
            category: 'Kết quả học tập',
            evaluation: '' ?? kqht.text,
            textColor: AppColors.brand600,
            onSelected: (value) {
              setState(() {
                kqht.text = value;
              });
            },
          ),
          SummaryGroup(
            category: 'Kết quả rèn luyện',
            evaluation: '' ?? kqrl.text,
            textColor: AppColors.brand600,
            onSelected: (value) {
              setState(() {
                kqrl.text = value;
              });
            },
          ),
          if (widget.isSecondSemester)
            Column(
              children: [
                SummaryGroup(
                  category: 'Xếp loại học lực',
                  evaluation: '' ?? xlhl.text,
                  textColor: AppColors.brand600,
                  onSelected: (value) {
                    setState(() {
                      xlhl.text = value;
                    });
                  },
                ),
                SummaryGroup(
                  category: 'Xếp loại hạnh kiểm',
                  evaluation: '' ?? xlhk.text,
                  textColor: AppColors.brand600,
                  onSelected: (value) {
                    setState(() {
                      xlhk.text = value;
                    });
                  },
                ),
                SummaryGroup(
                  category: 'Danh hiệu',
                  evaluation: '' ?? dh.text,
                  textColor: AppColors.brand600,
                  onSelected: (value) {
                    setState(() {
                      dh.text = value;
                    });
                  },
                ),
              ],
            ),
        ],
      ),
      Container(
        padding: const EdgeInsets.all(6),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            colors: [
              Color(0xFFFEF0C7),
              Color(0xFFFEF0C7),
            ],
            stops: [
              0.0189,
              0.9356,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.10),
              offset: Offset(0.0, 5.0),
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: const Color(0xFFF88F33),
                  child: SvgPicture.asset(
                    'assets/icons/emoji-normal.svg',
                    height: 12,
                    width: 12,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'Nhận xét',
                  style: AppTextStyles.bold14(color: AppColors.brand600),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.10),
                    offset: Offset(0.0, 5.0),
                    blurRadius: 20.0,
                  ),
                ],
              ),
              child: TextField(
                controller: _commentController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: AppTextStyles.normal14(color: AppColors.gray600),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border(
              top: BorderSide(
                color: AppColors.gray300,
              ),
              left: BorderSide(
                color: AppColors.gray300,
              ),
              right: BorderSide(
                color: AppColors.gray300,
              ),
            )),
        child: Column(
          children: [
            ...List.generate(
                4,
                (index) => CardScoreSubject(
                    isExpanded: expandedIndex == index,
                    index: index,
                    onExpansionChanged: () => _handleExpansion(index),
                    //scoreCard: widget.diemMoetTxt.scoreData![index],
                    lastIndex: 4 - 1))
          ],
        ),
      ),
    ]);
  }
}

class SummaryGroup extends StatelessWidget {
  const SummaryGroup({
    super.key,
    required this.evaluation,
    required this.category,
    required this.textColor,
    required this.onSelected,
  });

  final String evaluation;
  final String category;
  final Color textColor;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.10),
            offset: Offset(0.0, 5.0),
            blurRadius: 20.0,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: Text(
              category,
              textAlign: TextAlign.center,
              style: AppTextStyles.normal14(color: AppColors.blueGray700),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: VerticalDivider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Expanded(
            child: evaluation.isEmpty
                ? DropdownButton<String>(
                    hint: Text(
                      'Chọn',
                      style: AppTextStyles.normal12(
                        color: AppColors.gray500,
                      ),
                    ),
                    items: <String>['Tốt', 'Giỏi', 'Khá'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        onSelected(value);
                      }
                    },
                    underline: Container(),
                    isExpanded: true,
                  )
                : Text(
                    evaluation,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bold18(color: textColor),
                  ),
          ),
        ],
      ),
    );
  }
}
