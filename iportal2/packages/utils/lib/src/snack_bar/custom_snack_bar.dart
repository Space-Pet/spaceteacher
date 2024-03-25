// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class CustomSnackBar {
//   static SnackBar customSnackBar(
//       {required BuildContext context,
//       required String message,
//       required VoidCallback onActionTap,
//       required Color backgroundColor,
//       required IconData icon,
//       required Color iconColor,
//       required Color borderColor,
//       int duration = 3000}) {
//     return SnackBar(
//       duration: Duration(milliseconds: duration),
//       backgroundColor: backgroundColor,
//       behavior: SnackBarBehavior.floating,
//       width: MediaQuery.of(context).size.width - 32,
//       content: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 Icon(
//                   icon,
//                   color: iconColor,
//                   size: 24,
//                 ),
//                 const SizedBox(
//                   width: 16,
//                 ),
//                 Expanded(
//                   child: Text(
//                     message,
//                     style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           InkWell(
//             onTap: onActionTap,
//             child: const Icon(FontAwesomeIcons.xmark),
//           )
//         ],
//       ),
//       shape: RoundedRectangleBorder(
//           side: BorderSide(color: borderColor),
//           borderRadius: BorderRadius.circular(16)),
//     );
//   }

//   static Color errorBackgroundColor = const Color.fromRGBO(251, 238, 235, 1);
//   static Color errorIconColor = const Color.fromRGBO(218, 90, 58, 1);
//   static Color errorBorderColor = const Color.fromRGBO(238, 201, 192, 1);
//   static IconData errorIcon = FontAwesomeIcons.triangleExclamation;

//   static SnackBar errorSnackBar(
//       {required BuildContext context,
//       required String message,
//       required VoidCallback onActionTap,
//       int duration = 3000}) {
//     return customSnackBar(
//         context: context,
//         message: message,
//         duration: duration,
//         onActionTap: onActionTap,
//         backgroundColor: errorBackgroundColor,
//         icon: errorIcon,
//         iconColor: errorIconColor,
//         borderColor: errorBorderColor);
//   }

//   static showErrorSnackBar(
//       {required BuildContext context, required String message}) {
//     ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
//       context: context,
//       message: message,
//       onActionTap: () {
//         ScaffoldMessenger.of(context).hideCurrentSnackBar();
//       },
//     ));
//   }

//   static Color successBackgroundColor = const Color.fromRGBO(237, 247, 239, 1);
//   static Color successIconColor = const Color.fromRGBO(101, 186, 107, 1);
//   static Color successBorderColor = const Color.fromRGBO(198, 228, 202, 1);
//   static IconData successIcon = FontAwesomeIcons.circleCheck;

//   static SnackBar successSnackBar(
//       {required BuildContext context,
//       required String message,
//       required VoidCallback onActionTap,
//       int duration = 3000}) {
//     return customSnackBar(
//         context: context,
//         message: message,
//         duration: duration,
//         onActionTap: onActionTap,
//         backgroundColor: successBackgroundColor,
//         icon: successIcon,
//         iconColor: successIconColor,
//         borderColor: successBorderColor);
//   }

//   static showSuccessSnackBar(
//       {required BuildContext context, required String message}) {
//     ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
//       context: context,
//       message: message,
//       onActionTap: () {
//         ScaffoldMessenger.of(context).hideCurrentSnackBar();
//       },
//     ));
//   }
// }
