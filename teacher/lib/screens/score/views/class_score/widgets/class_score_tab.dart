import 'package:core/core.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ClassScoreTab extends StatelessWidget {
  const ClassScoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        return DecoratedBox(
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
                    'Nguyễn Trung Quân',
                    style: AppTextStyles.semiBold14(
                      color: AppColors.brand600,
                    ),
                  ),
                  Text(
                    'MHS123456',
                    style: AppTextStyles.normal14(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            expanded: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Điểm đạt:',
                        style: AppTextStyles.normal14(
                          color: AppColors.gray600,
                        ),
                      ),
                      Text(
                        'T',
                        style: AppTextStyles.semiBold16(
                          color: AppColors.brand600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    width: 4,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundBrandRest2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            'Tốt',
                            style: AppTextStyles.normal14(
                              color: AppColors.gray600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
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
                        text: 'Điểm đạt: ',
                        style: AppTextStyles.normal14(
                          color: AppColors.gray600,
                        ),
                      ),
                      TextSpan(
                        text: 'T',
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
        );
      },
    );
  }
}
