import 'package:core/core.dart';
import 'package:core/data/models/student_fees.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/fee_plan/bloc/fee_plan_bloc.dart';
import 'package:iportal2/screens/fee_plan/models/tariff_model.dart';

class TabBarViewRequested extends StatefulWidget {
  const TabBarViewRequested({
    super.key,
    required this.studentFeesResponse,
  });
  final StudentFeesResponse studentFeesResponse;
  @override
  State<TabBarViewRequested> createState() => _TabBarViewRequested();
}

class _TabBarViewRequested extends State<TabBarViewRequested> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeePlanBloc, FeePlanState>(
      builder: (context, state) {
        final it = state.studentFeesRequestedData?.data;
        return ListView(
          children: [
            if (!isNullOrEmpty(it?.sp1_001))
              FeeCategoryWidget(category: it?.sp1_001 ?? FeeCategory()),
            if (!isNullOrEmpty(it?.sp1_002))
              FeeCategoryWidget(category: it?.sp1_002 ?? FeeCategory()),
            if (!isNullOrEmpty(it?.sp1_003))
              FeeCategoryWidget(category: it?.sp1_003 ?? FeeCategory()),
            if (!isNullOrEmpty(it?.sp1_004))
              FeeCategoryWidget(category: it?.sp1_004 ?? FeeCategory()),
            if (!isNullOrEmpty(it?.sp1_005))
              FeeCategoryWidget(category: it?.sp1_005 ?? FeeCategory()),
          ],
        );
      },
    );
  }
}

// class RequestedFeeItem extends StatelessWidget {
//   const RequestedFeeItem({
//     super.key,
//     required this.category,
//   });

//   final FeeCategory category;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(
//           height: 12,
//         ),
//         Text(
//           category.data?.title ?? "",
//           style: AppTextStyles.semiBold16(
//             color: AppColors.brand600,
//           ),
//         ),
//         const SizedBox(
//           height: 6,
//         ),
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: const BoxDecoration(
//             color: AppColors.gray,
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//           ),
//           child: Container(
//             decoration: const BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         category.data,
//                         style: AppTextStyles.semiBold16(
//                           color: AppColors.brand600,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         child: Text(
//                           requestedFeeItem.paymentStatus.text(),
//                           style: AppTextStyles.semiBold14(
//                               color: _getColorBasedOnStatus(
//                                   requestedFeeItem.paymentStatus)),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         color: AppColors.gray300,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Phải nộp',
//                         style: AppTextStyles.semiBold14(
//                           color: AppColors.gray600,
//                         ),
//                       ),
//                       Text(
//                         NumberFormat.currency(
//                           locale: 'vi_VN',
//                           symbol: 'đ',
//                           decimalDigits: 0,
//                         ).format(requestedFeeItem.originalPrice -
//                             requestedFeeItem.discount),
//                         style: AppTextStyles.semiBold14(
//                           color: AppColors.gray600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: DottedLine(
//                       dashLength: 2,
//                       dashColor: AppColors.gray300,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Phí niêm yết',
//                         style: AppTextStyles.normal14(
//                           color: AppColors.gray400,
//                         ),
//                       ),
//                       Text(
//                         NumberFormat.currency(
//                           locale: 'vi_VN',
//                           symbol: 'đ',
//                           decimalDigits: 0,
//                         ).format(requestedFeeItem.originalPrice),
//                         style: AppTextStyles.semiBold14(
//                           color: AppColors.gray400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: DottedLine(
//                       dashLength: 2,
//                       dashColor: AppColors.gray300,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Giảm giá',
//                         style: AppTextStyles.normal14(
//                           color: AppColors.gray400,
//                         ),
//                       ),
//                       Text(
//                         NumberFormat.currency(
//                           locale: 'vi_VN',
//                           symbol: 'đ',
//                           decimalDigits: 0,
//                         ).format(requestedFeeItem.discount),
//                         style: AppTextStyles.semiBold14(
//                           color: AppColors.gray400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: DottedLine(
//                       dashLength: 2,
//                       dashColor: AppColors.gray300,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Hạn nộp',
//                         style: AppTextStyles.semiBold14(
//                           color: AppColors.gray600,
//                         ),
//                       ),
//                       Text(
//                         requestedFeeItem.payDue,
//                         style: AppTextStyles.semiBold14(
//                           color: AppColors.gray600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

Color _getColorBasedOnStatus(PaymentStatus status) {
  switch (status) {
    case PaymentStatus.requested:
      return AppColors.amberWarn; // Example color for pending status
    case PaymentStatus.applied:
      return AppColors.green400; // Example color for completed status
    case PaymentStatus.failed:
      return AppColors.red90001; // Example color for failed status
    default:
      return AppColors.gray400; // Default color
  }
}

class FeeCategoryWidget extends StatelessWidget {
  final FeeCategory category;

  const FeeCategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(category.data?.title ?? ""),
      children: category.data?.items?.map((item) {
            return ListTile(
              title: Text(item.title ?? ""),
              subtitle: Text('Giá: ${item.price} đ'),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: item.meta_data?.items?.map((meta) {
                      return Text('${meta.label}: ${meta.date}');
                    }).toList() ??
                    [],
              ),
            );
          }).toList() ??
          [],
    );
  }
}
