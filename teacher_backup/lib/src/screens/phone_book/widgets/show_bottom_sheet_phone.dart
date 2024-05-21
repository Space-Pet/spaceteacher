// class ShowBottomSheetPhone {
//   static Future<void> show(BuildContext context,
//       {required Function() onTap,
//       required PhoneBook phoneBook,
//       required int index}) async {
//     showBottomSheet(
//         context: context,
//         backgroundColor: Colors.white,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadiusDirectional.only(
//             topEnd: Radius.circular(25),
//             topStart: Radius.circular(25),
//           ),
//         ),
//         builder: (context) {
//           double screenHeight = MediaQuery.of(context).size.height;

//           double thirdOfScreenHeight = screenHeight / 2.1;
//           switch (index) {
//             case 0:
//               thirdOfScreenHeight = screenHeight / 2.1;
//             case 1:
//               thirdOfScreenHeight = screenHeight / 2.5;
//           }
//           return SizedBox(
//             height: thirdOfScreenHeight,
//             width: double.infinity,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           SvgPicture.asset(Assets.icons.filled),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 6),
//                             child: Text(
//                               'ssssss',
//                               style: AppTextStyles.normal18(
//                                   color: AppColors.brand600,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           )
//                         ],
//                       ),
//                       IconButton(
//                           padding: EdgeInsets.zero,
//                           onPressed: () {
//                             context.pop();
//                           },
//                           icon: const Icon(
//                             Icons.close,
//                             color: AppColors.red900,
//                           ))
//                     ],
//                   ),
//                 ),
//                 if (index == 1) infoParent(phoneBook, context),
//                 if (index == 0) infoStudent(context, phoneBook)
//               ],
//             ),
//           );
//         });
//   }

//   static Column infoParent(PhoneBook phoneBook, BuildContext context) {
//     return Column(
//       children: [
//         TabContent(
//           content: phoneBook.lop,
//           title: 'Cha mẹ học sinh lớp',
//           isShowIcon: false,
//           isShowDottedLine: false,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(color: AppColors.gray300),
//             ),
//             child: Column(
//               children: [
//                 TabContent(
//                   titleColor: true,
//                   content: phoneBook.name,
//                   title: 'Họ & tên học sinh',
//                   isShowIcon: false,
//                   isShowDottedLine: false,
//                   contentColor: AppColors.blue600,
//                 ),
//                 TabContent(
//                   content: phoneBook.id,
//                   title: 'Mã học sinh',
//                   isShowIcon: false,
//                   isShowDottedLine: false,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         TabContent(
//           content: phoneBook.numberPhone,
//           title: 'Số điện thoại',
//           isShowIcon: false,
//         ),
//         TabContent(
//           content: phoneBook.email,
//           title: 'Email',
//           isShowIcon: false,
//           isShowDottedLine: false,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
//           child: ElevatedButton(
//             style: ButtonStyle(
//               backgroundColor:
//                   MaterialStateProperty.all<Color?>(AppColors.red900),
//               side: MaterialStateProperty.all<BorderSide>(
//                 const BorderSide(color: AppColors.gray400),
//               ),
//             ),
//             onPressed: () => Navigator.pop(context),
//             child: const SizedBox(
//                 width: double.infinity,
//                 child: Text(
//                   style: TextStyle(color: AppColors.white),
//                   'Xem điểm',
//                   textAlign: TextAlign.center,
//                 )),
//           ),
//         ),
//       ],
//     );
//   }

//   static Column infoStudent(BuildContext context, PhoneBook phoneBook) {
//     return Column(
//       children: [
//         TabContent(
//           content: phoneBook.lop,
//           title: 'Lớp',
//           isShowIcon: false,
//         ),
//         TabContent(
//           content: phoneBook.id,
//           title: 'Mã học sinh',
//           isShowIcon: false,
//         ),
//         TabContent(
//           content: phoneBook.email,
//           title: 'Email',
//           isShowIcon: false,
//         ),
//         TabContent(
//           content: phoneBook.numberPhone,
//           title: 'Số điện thoại',
//           isShowIcon: false,
//         ),
//         TabContent(
//           content: phoneBook.nameParent,
//           title: 'Họ & tên mẹ',
//           isShowIcon: false,
//         ),
//         TabContent(
//           content: phoneBook.phoneParent,
//           title: 'Số điện thoại mẹ',
//           isShowIcon: false,
//           isShowDottedLine: false,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 12),
//           child: ElevatedButton(
//             style: ButtonStyle(
//               backgroundColor:
//                   MaterialStateProperty.all<Color?>(AppColors.white),
//               side: MaterialStateProperty.all<BorderSide>(
//                 const BorderSide(color: AppColors.gray400),
//               ),
//             ),
//             onPressed: () => Navigator.pop(context),
//             child: const SizedBox(
//                 width: double.infinity,
//                 child: Text(
//                   style: TextStyle(color: AppColors.black),
//                   'Xem điểm',
//                   textAlign: TextAlign.center,
//                 )),
//           ),
//         ),
//         const SizedBox(height: 4),
//         ElevatedButton(
//           style: ButtonStyle(
//             backgroundColor:
//                 MaterialStateProperty.all<Color?>(AppColors.red900),
//           ),
//           onPressed: () {},
//           child: const SizedBox(
//               width: double.infinity,
//               child: Text(
//                 style: TextStyle(color: AppColors.white),
//                 'Gửi SMS',
//                 textAlign: TextAlign.center,
//               )),
//         ),
//       ],
//     );
//   }
// }
