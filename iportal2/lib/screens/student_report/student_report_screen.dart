// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:iportal2/components/app_bar/app_bar.dart';
// import 'package:iportal2/components/back_ground_container.dart';
// import 'package:iportal2/components/select_child.dart';
// import 'package:iportal2/resources/app_colors.dart';
// import 'package:iportal2/resources/app_decoration.dart';
// import 'package:iportal2/resources/app_text_styles.dart';
// import 'package:iportal2/resources/assets.gen.dart';
// import 'package:iportal2/screens/pre_score/widget/select_button/select_button_feedback/select_option_button_feedback_type.dart';
// import 'package:iportal2/screens/student_report/model/example.dart';


// class StudentReportScreen extends StatefulWidget {
//   const StudentReportScreen({super.key});

//   @override
//   State<StudentReportScreen> createState() => _StudentReportScreenState();
// }

// class _StudentReportScreenState extends State<StudentReportScreen> {
//   String selectedScoreType = "Điểm MOET";

//   final List<Color> circleAvatarColors = [
//     AppColors.red500,
//     AppColors.brand600,
//     AppColors.green600,
//     Colors.orange,
//   ];

//   void handleSelectedOptionChanged(String newOption) async {
//     setState(() {
//       selectedScoreType = newOption;
//     });
//   }

//   Color getTextColor(int type) {
//     if (type >= 1 && type <= circleAvatarColors.length) {
//       return circleAvatarColors[type - 1];
//     } else {
//       return Colors.black; // Mặc định là màu đen
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BackGroundContainer(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ScreenAppBar(
//             title: 'Nhận xét',
//             canGoback: true,
//             onBack: () {
//               Navigator.pop(context);
//             },
//           ),
//           Flexible(
//             child: Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: AppRadius.roundedTop28,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 12),
//                       child: Column(
//                         children: [
//                           SelectChild(),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: SelectFeedBackType(
//                               onSelectedOptionChanged:
//                                   handleSelectedOptionChanged,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         gradient: const LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           stops: [0.0, 0.401, 1.0],
//                           colors: [
//                             Color(0xFFDFEEFF),
//                             Color(0xFFFFFFFF),
//                             Color(0xFFFFFFFF),
//                           ],
//                         ),
//                       ),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 SvgPicture.asset(
//                                   Assets.icons.features.report,
//                                   width: 20,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 6),
//                                   child: Text(
//                                     'Thang đánh giá',
//                                     style: AppTextStyles.normal16(
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.brand600,
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 12),
//                               child: Container(
//                                 width: double.infinity,
//                                 padding: const EdgeInsets.all(12),
//                                 decoration: const BoxDecoration(
//                                   color: AppColors.white,
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(20),
//                                     topRight: Radius.circular(20),
//                                   ),
//                                 ),
//                                 child: Column(
//                                   children: title.asMap().entries.map((entry) {
//                                     final index = entry.key;
//                                     final item = entry.value;
//                                     return Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         CircleAvatar(
//                                           backgroundColor: circleAvatarColors[
//                                               index %
//                                                   circleAvatarColors.length],
//                                           radius: 10,
//                                           child: Text(
//                                             item.id.toString(),
//                                             style: AppTextStyles.normal14(
//                                                 color: AppColors.white),
//                                           ),
//                                         ),
//                                         const SizedBox(width: 8),
//                                         Expanded(
//                                           child: RichText(
//                                             text: TextSpan(
//                                               text: '',
//                                               style:
//                                                   DefaultTextStyle.of(context)
//                                                       .style,
//                                               children: <TextSpan>[
//                                                 TextSpan(
//                                                   text: '${item.titile}: ',
//                                                   style: const TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 16,
//                                                   ),
//                                                 ),
//                                                 TextSpan(
//                                                   text: item.content,
//                                                   style: const TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     fontSize: 14,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                               child: Row(
//                                 children: [
//                                   SvgPicture.asset(
//                                     Assets.icons.features.report,
//                                     width: 20,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 6),
//                                     child: Text(
//                                       'Mục tiêu học tập và tiêu chí đánh giá',
//                                       style: AppTextStyles.normal16(
//                                         fontWeight: FontWeight.w600,
//                                         color: AppColors.brand600,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             ListView.builder(
//                               padding: EdgeInsets.zero,
//                               physics: const NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: content.length,
//                               itemBuilder: (context, index) {
//                                 final item = content[index];
//                                 return Padding(
//                                   padding: EdgeInsets.zero,
//                                   child: ExpansionTile(
//                                     tilePadding: EdgeInsets.zero,
//                                     title: Container(
//                                         padding: const EdgeInsets.all(5),
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5),
//                                             color:
//                                                 AppColors.backgroundBrandRest),
//                                         child: Text(
//                                           item.title,
//                                           style: AppTextStyles.normal12(
//                                             fontWeight: FontWeight.w600,
//                                             color: AppColors.brand600,
//                                           ),
//                                         )),
//                                     children: [
//                                       Column(
//                                         children: item.titleReport.map((items) {
//                                           return Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               color:
//                                                   AppColors.backgroundBrandRest,
//                                             ),
//                                             padding: const EdgeInsets.all(10),
//                                             margin: const EdgeInsets.symmetric(
//                                                 vertical: 5),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Container(
//                                                   padding:
//                                                       const EdgeInsets.all(8),
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               5),
//                                                       color: AppColors.white),
//                                                   child: Text(items.title,
//                                                       style: AppTextStyles
//                                                           .normal14(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                               color: AppColors
//                                                                   .brand600)),
//                                                 ),
//                                                 Column(
//                                                   children: items.contentReport
//                                                       .map((e) {
//                                                     return Container(
//                                                       margin:
//                                                           const EdgeInsets.only(
//                                                               top: 8),
//                                                       constraints:
//                                                           const BoxConstraints(
//                                                               minHeight: 36),
//                                                       child: Row(
//                                                         children: [
//                                                           Container(
//                                                             constraints:
//                                                                 const BoxConstraints(
//                                                                     minHeight:
//                                                                         36),
//                                                             width: 5,
//                                                             decoration: BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             20),
//                                                                 color: AppColors
//                                                                     .brand600),
//                                                           ),
//                                                           Expanded(
//                                                             child: Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .only(
//                                                                       left: 16,
//                                                                       right:
//                                                                           50),
//                                                               child: Text(
//                                                                   e.content,
//                                                                   style: AppTextStyles
//                                                                       .normal12(
//                                                                           color:
//                                                                               AppColors.gray600)),
//                                                             ),
//                                                           ),
//                                                           Text(
//                                                             e.type.toString(),
//                                                             style: AppTextStyles.normal18(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w700,
//                                                                 color:
//                                                                     getTextColor(
//                                                                         e.type)),
//                                                           )
//                                                         ],
//                                                       ),
//                                                     );
//                                                   }).toList(),
//                                                 )
//                                               ],
//                                             ),
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
