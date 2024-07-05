import 'package:core/core.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

class ClassScoreTab extends StatelessWidget {
  const ClassScoreTab({
    super.key,
    required this.dataMoet,
    required this.classScore,
    required this.moetHighData,
  });
  final MoetHighData? moetHighData;
  final Data? dataMoet;
  final ClassScore classScore;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // Calculate half of the screen height
    double halfScreenHeight = screenHeight / 4;

    return Column(
      children: [
        if (dataMoet?.scoreData.length == 0 &&
            moetHighData?.scoreData.length == 0)
          Padding(
            padding: EdgeInsets.only(top: halfScreenHeight),
            child: EmptyScreen(text: 'Không có dữ liệu'),
          ),
        if (dataMoet?.scoreData.length != 0)
          ViewMoetPramary(dataMoet: dataMoet),
        if (moetHighData?.scoreData.length != 0)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 16),
              itemCount: moetHighData?.scoreData.length,
              itemBuilder: (context, index) {
                final item = moetHighData?.scoreData[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index == 0)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/bold-note-document.svg',
                              width: 20,
                              height: 20,
                              color: AppColors.brand600,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                moetHighData?.subject.subjectName ?? '',
                                style: AppTextStyles.normal14(
                                  color: AppColors.brand600,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            index == 0 ? 20 : 0,
                          ),
                          topRight: Radius.circular(
                            index == 0 ? 20 : 0,
                          ),
                          bottomLeft: Radius.circular(
                            index == 29 ? 20 : 0,
                          ),
                          bottomRight: Radius.circular(
                            index == 29 ? 20 : 0,
                          ),
                        ),
                      ),
                      child: ExpandablePanel(
                        theme: const ExpandableThemeData(
                          iconPadding: EdgeInsets.fromLTRB(12, 12, 12, 8),
                          alignment: Alignment.topCenter,
                          tapBodyToExpand: true,
                          tapHeaderToExpand: true,
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                        ),
                        header: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                item?.pupilName ?? '',
                                style: AppTextStyles.semiBold14(
                                  color: AppColors.brand600,
                                ),
                              ),
                              Text(
                                item?.pupilId.toString() ?? '',
                                style: AppTextStyles.normal14(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        expanded: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 1, right: 8),
                                  width: 4,
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundBrandRest2,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Kiểm tra thường xuyên',
                                            style: AppTextStyles.normal14(
                                              color: AppColors.gray600,
                                            ),
                                          ),
                                          Text(
                                            item!.score.ddgtx!.join(', '),
                                            style: AppTextStyles.semiBold16(
                                              color: AppColors.brand600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Giữa kỳ',
                                            style: AppTextStyles.normal14(
                                              color: AppColors.gray600,
                                            ),
                                          ),
                                          Text(
                                            item.score.ddggk!.join(', '),
                                            style: AppTextStyles.semiBold16(
                                              color: AppColors.brand600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Cuối kỳ',
                                            style: AppTextStyles.normal14(
                                              color: AppColors.gray600,
                                            ),
                                          ),
                                          Text(
                                            item.score.ddgck!.join(', '),
                                            style: AppTextStyles.semiBold16(
                                              color: AppColors.brand600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Container(
                                          width: double.infinity,
                                          height: 0.5,
                                          color: AppColors.gray300,
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.gray100,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                SvgPicture.asset(
                                                  'assets/icons/chat_round_call.svg',
                                                  width: 24,
                                                  height: 24,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  'Nhận xét của giáo viên',
                                                  style: AppTextStyles.normal14(
                                                    color: AppColors.brand600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              item.comment ?? '',
                                              style: AppTextStyles.normal14(
                                                color: AppColors.gray600,
                                              ),
                                            ),
                                            Text(
                                              'GV: ${context.read<CurrentUserBloc>().state.user.name}',
                                              style: AppTextStyles.normal14(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        collapsed: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: AppColors.gray300,
                                width: 1,
                              ),
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Điểm trung bình: ',
                                    style: AppTextStyles.normal14(
                                      color: AppColors.gray600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: item.averageScore.toString(),
                                    style: AppTextStyles.semiBold14(
                                      color: AppColors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
      ],
    );
  }
}

class ViewMoetPramary extends StatelessWidget {
  const ViewMoetPramary({
    super.key,
    required this.dataMoet,
  });

  final Data? dataMoet;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 16),
        itemCount: dataMoet?.scoreData.length,
        itemBuilder: (context, index) {
          final item = dataMoet?.scoreData[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/bold-note-document.svg',
                        width: 20,
                        height: 20,
                        color: AppColors.brand600,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          dataMoet?.subject.subjectName ?? '',
                          style: AppTextStyles.normal14(
                            color: AppColors.brand600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      index == 0 ? 20 : 0,
                    ),
                    topRight: Radius.circular(
                      index == 0 ? 20 : 0,
                    ),
                    bottomLeft: Radius.circular(
                      index == 29 ? 20 : 0,
                    ),
                    bottomRight: Radius.circular(
                      index == 29 ? 20 : 0,
                    ),
                  ),
                ),
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    iconPadding: EdgeInsets.fromLTRB(12, 12, 12, 8),
                    alignment: Alignment.topCenter,
                    tapBodyToExpand: true,
                    tapHeaderToExpand: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                  ),
                  header: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          item?.pupilName ?? '',
                          style: AppTextStyles.semiBold14(
                            color: AppColors.brand600,
                          ),
                        ),
                        Text(
                          item?.pupilId.toString() ?? '',
                          style: AppTextStyles.normal14(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  expanded: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 1, right: 8),
                            width: 4,
                            decoration: BoxDecoration(
                              color: AppColors.backgroundBrandRest2,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Mức đạt được:',
                                      style: AppTextStyles.normal14(
                                        color: AppColors.gray600,
                                      ),
                                    ),
                                    Text(
                                      item?.score.text ?? '',
                                      style: AppTextStyles.semiBold16(
                                        color: AppColors.brand600,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Container(
                                    width: double.infinity,
                                    height: 0.5,
                                    color: AppColors.gray300,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.gray100,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            'assets/icons/chat_round_call.svg',
                                            width: 24,
                                            height: 24,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Nhận xét của giáo viên',
                                            style: AppTextStyles.normal14(
                                              color: AppColors.brand600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item?.comment ?? '',
                                        style: AppTextStyles.normal14(
                                          color: AppColors.gray600,
                                        ),
                                      ),
                                      Text(
                                        'GV: ${context.read<CurrentUserBloc>().state.user.name}',
                                        style: AppTextStyles.normal14(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  collapsed: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: AppColors.gray300,
                          width: 1,
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Mức đạt được: ',
                              style: AppTextStyles.normal14(
                                color: AppColors.gray600,
                              ),
                            ),
                            TextSpan(
                              text: item?.score.text,
                              style: AppTextStyles.semiBold14(
                                color: AppColors.brand600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
