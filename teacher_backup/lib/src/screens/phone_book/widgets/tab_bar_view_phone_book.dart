import 'package:flutter/material.dart';
import 'package:core/resources/resources.dart';
// import 'package:teacher/src/screens/phone_book/model/example.dart';

class TabBarViewPhoneBook extends StatefulWidget {
  const TabBarViewPhoneBook({super.key, required this.index});
  final int index;
  @override
  State<TabBarViewPhoneBook> createState() => _TabBarViewPhoneBookState();
}

class _TabBarViewPhoneBookState extends State<TabBarViewPhoneBook> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          borderRadius: widget.index == 1
              ? const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )
              : widget.index == 0
                  ? const BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.circular(12),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.zero,
                    ),
          color: AppColors.white,
        ),
        // child: Padding(
        //     padding: const EdgeInsets.all(8),
        //     child: ListView.builder(
        //         padding: EdgeInsets.zero,
        //         itemCount: phoneBook.length,
        //         itemBuilder: (context, index) {
        //           final info = phoneBook[index];
        //           return Padding(
        //             padding: const EdgeInsets.only(bottom: 8),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Row(
        //                   children: [
        //                     Container(
        //                       height: 40,
        //                       width: 40,
        //                       decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             fit: BoxFit.cover,
        //                             image: AssetImage(info.image)),
        //                         shape: BoxShape.circle,
        //                         color: AppColors.white,
        //                         border: Border.all(
        //                           color: AppColors.white,
        //                           width: 2,
        //                         ),
        //                       ),
        //                     ),
        //                     const SizedBox(
        //                       width: 8,
        //                     ),
        //                     Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Text(
        //                           info.name,
        //                           style: AppTextStyles.normal14(
        //                               color: AppColors.brand600),
        //                         ),
        //                         if (widget.index != 2)
        //                           Text(
        //                             info.id,
        //                             style: AppTextStyles.normal12(
        //                                 color: AppColors.secondary),
        //                           ),
        //                         if (widget.index != 0)
        //                           Text(
        //                             info.numberPhone,
        //                             style: AppTextStyles.normal12(
        //                                 color: AppColors.secondary,
        //                                 fontWeight: FontWeight.w600),
        //                           ),
        //                         if (widget.index == 2)
        //                           Container(
        //                             padding: const EdgeInsets.all(8),
        //                             decoration: BoxDecoration(
        //                                 color: AppColors.lightBlue50,
        //                                 borderRadius:
        //                                     BorderRadius.circular(20)),
        //                             child: Row(
        //                               children: [
        //                                 SvgPicture.asset(
        //                                   Assets.icons.schoolCase,
        //                                 ),
        //                                 const SizedBox(
        //                                   width: 6,
        //                                 ),
        //                                 Text(
        //                                   info.subject,
        //                                   style: AppTextStyles.normal12(
        //                                       color: AppColors.brand600),
        //                                 )
        //                               ],
        //                             ),
        //                           )
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //                 Row(
        //                   children: [
        //                     if (widget.index == 0)
        //                       Padding(
        //                         padding: const EdgeInsets.only(right: 8),
        //                         child: GestureDetector(
        //                           onTap: () {},
        //                           child:
        //                               SvgPicture.asset(Assets.icons.document),
        //                         ),
        //                       ),
        //                     GestureDetector(
        //                       onTap: () {
        //                         ShowBottomSheetPhone.show(context,
        //                             index: widget.index,
        //                             phoneBook: info,
        //                             onTap: () {});
        //                       },
        //                       child: SvgPicture.asset(Assets.icons.send),
        //                     )
        //                   ],
        //                 )
        //               ],
        //             ),
        //           );
        //         })),
      
      ),
    );
  }
}
