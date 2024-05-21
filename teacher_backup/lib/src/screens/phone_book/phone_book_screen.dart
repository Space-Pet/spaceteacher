import 'package:flutter/material.dart';
import 'package:teacher/components/back_ground_container.dart';
// import 'package:teacher/src/screens/phone_book/widgets/screen_app_bar.dart';
import 'package:teacher/src/screens/phone_book/widgets/tab_bar_phone_book.dart';

class PhoneBookScreen extends StatefulWidget {
  const PhoneBookScreen({super.key});
  static const routeName = '/phone_book';
  @override
  State<PhoneBookScreen> createState() => _PhoneBookScreenState();
}

class _PhoneBookScreenState extends State<PhoneBookScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BackGroundContainer(
          child: Column(
        children: [
          // ScreenAppBarPhoneBook(
          //   title: LocaleKeys.contactList.tr(),
          //   onBack: () {
          //     context.pop();
          //   },
          //   showDialog: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           contentPadding: EdgeInsets.zero,
          //           titlePadding: EdgeInsets.zero,
          //           backgroundColor: AppColors.white,
          //           title: Container(
          //               width: double.infinity,
          //               decoration: const BoxDecoration(
          //                   color: AppColors.gray100,
          //                   borderRadius: BorderRadius.only(
          //                       topLeft: Radius.circular(40),
          //                       topRight: Radius.circular(40))),
          //               child: const Center(
          //                   child: Padding(
          //                 padding: EdgeInsets.all(8.0),
          //                 child: Text(
          //                   'Lớp học',
          //                   style: TextStyle(fontWeight: FontWeight.w600),
          //                 ),
          //               ))),
          //           content: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               for (int i = 1; i <= 3; i++)
          //                 ListTile(
          //                   title: Text(
          //                     'Lớp $i (22)',
          //                   ),
          //                   trailing: Radio(
          //                     value: i,
          //                     groupValue: 1,
          //                     onChanged: (_) {},
          //                   ),
          //                 ),
          //             ],
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),
          
          Flexible(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFDFEEFF), Colors.white, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.5, 1.0],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.only(top: 12),
            child: const TabBarPhoneBook(),
          ))
        ],
      )),
    );
  }
}
