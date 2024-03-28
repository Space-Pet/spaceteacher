// import 'dart:math';

// import 'package:dartx/dartx.dart';
// import 'package:flutter/material.dart';

// import '../../data/models/service.dart';
// import '../theme/theme_color.dart';
// import 'cache_network_image_wrapper.dart';

// class HomeMenu extends StatefulWidget {
//   final List<Service> services;
//   final bool loading;
//   final void Function(Service?) onSelectMenuItem;
//   final String languageCode;
//   final int maximumItemsInRow = 4;

//   HomeMenu({
//     Key? key,
//     required this.services,
//     this.loading = false,
//     required this.onSelectMenuItem,
//     required this.languageCode,
//   }) : super(key: key);

//   @override
//   State<HomeMenu> createState() => _HomeMenuState();
// }

// class _HomeMenuState extends State<HomeMenu> {
//   late int maximumItemsInRow;

//   @override
//   void initState() {
//     maximumItemsInRow = widget.maximumItemsInRow;

//     if (widget.services.length < 4) {
//       maximumItemsInRow = widget.services.length;
//     }

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.loading) {
//       return _loading();
//     }
//     return _buildMenu();
//   }

//   Widget _loading() {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }

//   Widget _buildMenu() {
//     final items = <Widget>[
//       ...widget.services.map(
//         (e) => HomeMenuItem(
//           languageCode: widget.languageCode,
//           onTap: widget.onSelectMenuItem,
//           service: e,
//         ),
//       ),
//     ];

//     final hasViewAll = items.length > maximumItemsInRow * 2; // Two rows
//     final emptyContainerCount = max((hasViewAll ? 7 : 8) - items.length, 0);
//     for (var index = 0; index < emptyContainerCount; index++) {
//       items.add(const SizedBox());
//     }

//     final viewAll = InkWell(
//       onTap: () => widget.onSelectMenuItem.call(null),
//       child: Column(
//         children: [
//           Container(
//             width: 56,
//             height: 56,
//             decoration: BoxDecoration(
//               color: const Color(0xFFFFF5F0),
//               borderRadius: BorderRadius.circular(28),
//             ),
//             child: Icon(
//               Icons.more_horiz,
//               size: 36,
//               color: themeColor.primaryColor,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Xem tất cả',
//             style: Theme.of(context).textTheme.subtitle2,
//             textAlign: TextAlign.center,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );

//     final firstRowItems = items.sublist(0, maximumItemsInRow);

//     final firstRows = Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: firstRowItems.map((e) => Expanded(child: e)).toList(),
//     );

//     final secondRowItems =
//         items.sublist(maximumItemsInRow, 2 * maximumItemsInRow - 1)
//           ..add(
//             hasViewAll ? viewAll : items[2 * maximumItemsInRow - 1],
//           );

//     final secondRows = Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: secondRowItems.map((e) => Expanded(child: e)).toList(),
//     );

//     if (items.length <= maximumItemsInRow) {
//       return firstRows;
//     }

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         firstRows,
//         if (widget.services.length > maximumItemsInRow) ...[
//           const SizedBox(
//             height: 20,
//           ),
//           secondRows
//         ],
//       ],
//     );
//   }
// }

// class HomeMenuItem extends StatelessWidget {
//   final Service service;
//   final void Function(Service) onTap;
//   final String languageCode;

//   const HomeMenuItem({
//     Key? key,
//     required this.service,
//     required this.onTap,
//     required this.languageCode,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//       child: InkWell(
//         onTap: () => onTap(service),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _image(),
//             const SizedBox(height: 8),
//             Text(
//               service.contents
//                       ?.where((element) => element.language == languageCode)
//                       .firstOrNull
//                       ?.name ?? '',
//               // languageCode == 'vi' ? service.contents?.where((element) => element.language == 'vi').firstOrNull?.name ?? '_'
//               //  : service.contents?.where((element) => element.language == 'en').firstOrNull?.name ?? '_',
//               style: Theme.of(context)
//                   .textTheme
//                   .subtitle2
//                   ?.copyWith(fontSize: 12, color: themeColor.black),
//               textAlign: TextAlign.center,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _image() {
//     return Container(
//       width: 60,
//       height: 60,
//       decoration: BoxDecoration(
//         color: themeColor.primaryColorLight,
//         borderRadius: BorderRadius.circular(28),
//       ),
//       padding: const EdgeInsets.all(10),
//       child: Center(
//         child: CachedNetworkImageWrapper.item(
//           url: service.iconUrl ?? '',
//           fit: BoxFit.contain,
//           width: 36,
//           height: 36,
//         ),
//       ),
//     );
//   }
// }
