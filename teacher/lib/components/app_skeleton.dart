// import 'package:flutter/material.dart';
// import 'package:skeletons/skeletons.dart';

// class AppSkeleton extends StatelessWidget {
//   const AppSkeleton({
//     super.key,
//     required this.skeleton,
//     required this.child,
//     required this.isLoading,
//   });

//   final Widget skeleton;
//   final Widget child;
//   final bool isLoading;

//   @override
//   Widget build(BuildContext context) {
//     return Skeleton(
//       duration: const Duration(milliseconds: 1500),
//       shimmerGradient: const LinearGradient(
//         colors: [
//           Color.fromARGB(152, 245, 245, 245),
//           Color.fromARGB(152, 235, 235, 235),
//           Color.fromARGB(152, 225, 225, 225),
//           Color.fromARGB(152, 235, 235, 235),
//           Color.fromARGB(152, 245, 245, 245),

//           // Color.fromRGBO(242, 244, 247, 0.5),
//           // Color.fromRGBO(242, 244, 247, 1),
//           // Color.fromRGBO(242, 244, 247, 1),
//           // Color.fromRGBO(242, 244, 247, 1),
//           // Color.fromRGBO(242, 244, 247, 0.5),
//         ],
//         stops: [0.0, 0.3, 0.5, 0.7, 1],
//         begin: Alignment(-2.4, -0.2),
//         end: Alignment(2.4, 0.2),
//       ),
//       isLoading: isLoading,
//       skeleton: skeleton,
//       child: child,
//     );
//   }
// }

// // Color.fromRGBO(242, 244, 247, 1),