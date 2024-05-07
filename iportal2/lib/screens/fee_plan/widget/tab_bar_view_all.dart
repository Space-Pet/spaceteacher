import 'package:core/resources/app_colors.dart';
import 'package:core/resources/app_text_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/components/buttons/rounded_button.dart';
import 'package:iportal2/components/dialog/show_dialog.dart';
import 'package:iportal2/screens/fee_plan/models/tariff_model.dart';

class TabBarViewAll extends StatefulWidget {
  const TabBarViewAll({
    super.key,
  });

  @override
  State<TabBarViewAll> createState() => _TabBarViewAll();
}

class _TabBarViewAll extends State<TabBarViewAll> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  feePlanList.length,
                  (index) => TariffRadioItemWidget(
                    planItem: FeePlanItem(
                        id: feePlanList[index].id,
                        title: feePlanList[index].title,
                        paymentType: feePlanList[index].paymentType,
                        oneTimePayment: feePlanList[index].oneTimePayment,
                        multiTimePayment: feePlanList[index].multiTimePayment),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Dịch vụ giáo dục',
                  style: AppTextStyles.semiBold16(
                    color: AppColors.brand600,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                ...List.generate(
                  eduService.length,
                  (index) => TariffEduServiceItemWidget(
                    eduServiceItem: EducationServiceItem(
                        id: eduService[index].id,
                        title: eduService[index].title,
                        totalPayment: eduService[index].totalPayment,
                        payDue: eduService[index].payDue),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 44,
          child: RoundedButton(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ShowDialog(
                      title: 'Đã gửi yêu cầu đến trường.',
                      textConten:
                          'Quý cha mẹ học sinh vui lòng chờ nhân viên trường kiểm tra và áp giảm giá (nếu có)',
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFFECFDF3),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFFD1FADF),
                          child: Icon(
                            Icons.done,
                            color: AppColors.green600,
                          ),
                        ),
                      ),
                    );
                  });
            },
            borderRadius: 70,
            padding: EdgeInsets.zero,
            buttonColor: AppColors.red90001,
            child: Text(
              'Xác nhận biểu phí',
              style: AppTextStyles.semiBold16(
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TariffRadioItemWidget extends StatefulWidget {
  final FeePlanItem planItem;

  const TariffRadioItemWidget({super.key, required this.planItem});

  @override
  State<TariffRadioItemWidget> createState() => _TariffRadioItemWidgetState();
}

class _TariffRadioItemWidgetState extends State<TariffRadioItemWidget> {
  int? _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        Text(
          widget.planItem.title,
          style: AppTextStyles.semiBold16(
            color: AppColors.brand600,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppColors.gray,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nộp 1 lần (Cả năm)',
                        style: AppTextStyles.semiBold16(
                          color: AppColors.brand600,
                        ),
                      ),
                      if (widget.planItem.paymentType == PaymentType.all)
                        SizedBox(
                          height: 40,
                          width: 20,
                          child: Radio(
                            activeColor: AppColors.green400,
                            value: 1,
                            groupValue: _selectedIndex,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedIndex = value;
                              });
                            },
                          ),
                        )
                      else if (widget.planItem.paymentType ==
                          PaymentType.oneTime)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Đã áp dụng',
                            style: AppTextStyles.semiBold14(
                                color: AppColors.green400),
                          ),
                        )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.gray300,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng tiền',
                        style: AppTextStyles.normal14(
                          color: AppColors.gray600,
                        ),
                      ),
                      Text(
                        widget.planItem.oneTimePayment.totalPayment,
                        style: AppTextStyles.semiBold14(
                          color: AppColors.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: DottedLine(
                      dashLength: 2,
                      dashColor: AppColors.gray300,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hạn nộp',
                        style: AppTextStyles.normal14(
                          color: AppColors.gray600,
                        ),
                      ),
                      Text(
                        widget.planItem.oneTimePayment.payDue,
                        style: AppTextStyles.semiBold14(
                          color: AppColors.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        if (widget.planItem.multiTimePayment != null)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nộp 4 lần (Theo học phần)',
                          style: AppTextStyles.semiBold16(
                            color: AppColors.brand600,
                          ),
                        ),
                        if (widget.planItem.paymentType == PaymentType.all)
                          SizedBox(
                            height: 40,
                            width: 20,
                            child: Radio(
                              activeColor: AppColors.green400,
                              value: 2,
                              groupValue: _selectedIndex,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedIndex = value;
                                });
                              },
                            ),
                          )
                        else if (widget.planItem.paymentType ==
                            PaymentType.oneTime)
                          const Text('123123')
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.gray300,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng tiền',
                          style: AppTextStyles.normal14(
                            color: AppColors.gray600,
                          ),
                        ),
                        Text(
                          widget.planItem.multiTimePayment!.totalPayment,
                          style: AppTextStyles.semiBold14(
                            color: AppColors.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: DottedLine(
                        dashLength: 2,
                        dashColor: AppColors.gray300,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hạn nộp 1',
                          style: AppTextStyles.normal14(
                            color: AppColors.gray600,
                          ),
                        ),
                        Text(
                          widget.planItem.multiTimePayment!.payDue1,
                          style: AppTextStyles.semiBold14(
                            color: AppColors.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: DottedLine(
                        dashLength: 2,
                        dashColor: AppColors.gray300,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hạn nộp 2',
                          style: AppTextStyles.normal14(
                            color: AppColors.gray600,
                          ),
                        ),
                        Text(
                          widget.planItem.multiTimePayment!.payDue2,
                          style: AppTextStyles.semiBold14(
                            color: AppColors.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: DottedLine(
                        dashLength: 2,
                        dashColor: AppColors.gray300,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hạn nộp 3',
                          style: AppTextStyles.normal14(
                            color: AppColors.gray600,
                          ),
                        ),
                        Text(
                          widget.planItem.multiTimePayment!.payDue3,
                          style: AppTextStyles.semiBold14(
                            color: AppColors.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: DottedLine(
                        dashLength: 2,
                        dashColor: AppColors.gray300,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hạn nộp 4',
                          style: AppTextStyles.normal14(
                            color: AppColors.gray600,
                          ),
                        ),
                        Text(
                          widget.planItem.multiTimePayment!.payDue4,
                          style: AppTextStyles.semiBold14(
                            color: AppColors.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class TariffEduServiceItemWidget extends StatefulWidget {
  final EducationServiceItem eduServiceItem;

  const TariffEduServiceItemWidget({super.key, required this.eduServiceItem});

  @override
  State<TariffEduServiceItemWidget> createState() =>
      _TariffEduServiceItemWidgetState();
}

class _TariffEduServiceItemWidgetState
    extends State<TariffEduServiceItemWidget> {
  bool checkedItem = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.eduServiceItem.title,
                    style: AppTextStyles.semiBold16(
                      color: AppColors.brand600,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 20,
                    child: Checkbox(
                      activeColor: AppColors.green400,
                      value: checkedItem,
                      onChanged: (value) => {
                        setState(() {
                          if (value != null) {
                            debugPrint('$value');
                            checkedItem = value;
                          }
                        })
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.gray300,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng tiền',
                    style: AppTextStyles.normal14(
                      color: AppColors.gray600,
                    ),
                  ),
                  Text(
                    widget.eduServiceItem.totalPayment,
                    style: AppTextStyles.semiBold14(
                      color: AppColors.gray600,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: double.infinity,
                child: DottedLine(
                  dashLength: 2,
                  dashColor: AppColors.gray300,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hạn nộp',
                    style: AppTextStyles.normal14(
                      color: AppColors.gray600,
                    ),
                  ),
                  Text(
                    widget.eduServiceItem.payDue,
                    style: AppTextStyles.semiBold14(
                      color: AppColors.gray600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
