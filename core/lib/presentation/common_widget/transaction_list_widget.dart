// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../common/constants.dart';
// import '../../common/utils.dart';
// import '../../data/models/transaction.dart';
// import '../theme/theme_color.dart';

// class TransactionListWidget extends StatelessWidget {
//   final List<TransactionListItemData> listItemsData;
//   final String icon;
//   final Color primaryColor;
//   final Function(UserTransaction) onItemTap;

//   const TransactionListWidget({
//     Key? key,
//     int? maximumItems,
//     required this.listItemsData,
//     required this.icon,
//     required this.primaryColor,
//     required this.onItemTap,
//   })  : _maximumItems = maximumItems,
//         super(key: key);

//   final int? _maximumItems;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       physics: const NeverScrollableScrollPhysics(),
//       padding: EdgeInsets.zero,
//       shrinkWrap: true,
//       itemBuilder: (context, index) => TransactionListItem(
//         data: listItemsData[index],
//         icon: icon,
//         primaryColor: primaryColor,
//         onItemTap: onItemTap,
//       ),
//       separatorBuilder: (context, index) => const Divider(
//         thickness: 1,
//         height: 1,
//       ),
//       itemCount: _maximumItems != null
//           ? (_maximumItems! > listItemsData.length
//               ? listItemsData.length
//               : _maximumItems!)
//           : listItemsData.length,
//     );
//   }
// }

// class TransactionListItem extends StatelessWidget {
//   final TransactionListItemData data;
//   final String icon;
//   final Color primaryColor;
//   final Function(UserTransaction) onItemTap;

//   const TransactionListItem({
//     Key? key,
//     required this.data,
//     required this.icon,
//     required this.primaryColor,
//     required this.onItemTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return InkWell(
//       onTap: () => onItemTap.call(data.transaction),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     data.title,
//                     style: theme.textTheme.bodyText2?.copyWith(fontSize: 14),
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Text(
//                     data.date?.toBookingDateTimeFormat() ?? '--',
//                     style: theme.textTheme.subtitle2?.copyWith(fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 8,
//             ),
//             SvgPicture.asset(
//               icon,
//               width: 20,
//               height: 20,
//               fit: BoxFit.contain,
//               color: data.isNegative ? themeColor.colorFF9A05 : primaryColor,
//             ),
//             const SizedBox(
//               width: 4,
//             ),
//             Text(
//               '${data.isNegative ? '-' : '+'}${data.amount.toCurrencyString()}',
//               style: theme.textTheme.bodyText2?.copyWith(
//                 fontSize: 14,
//                 color: data.isNegative ? themeColor.colorFF9A05 : primaryColor,
//               ),
//             ),
//             const SizedBox(
//               width: 8,
//             ),
//             SvgPicture.asset(
//               coreImageConstant.icChevronRight,
//               width: 24,
//               height: 24,
//               fit: BoxFit.contain,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TransactionListItemData {
//   final String title;
//   final int amount;
//   final DateTime? date;
//   final bool isNegative;
//   final UserTransaction transaction;

//   TransactionListItemData({
//     required this.title,
//     required this.amount,
//     required this.date,
//     required this.isNegative,
//     required this.transaction,
//   });
// }
