// import 'dart:io';
// import 'dart:typed_data';

// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/material.dart';
// import 'package:image_editor/image_editor.dart';
// import 'package:path_provider/path_provider.dart';

// import '../../base/base.dart';
// import '../../common_widget/export.dart';

// part 'image_cropper.action.dart';

// class ImageCropperScreen extends StatefulWidget {
//   final File imagefile;
//   final dynamic trans;

//   const ImageCropperScreen({
//     Key? key,
//     required this.imagefile,
//     required this.trans,
//   }) : super(key: key);

//   @override
//   _ImageCropperScreenState createState() => _ImageCropperScreenState();
// }

// class _ImageCropperScreenState extends StateBase<ImageCropperScreen> {
//   final GlobalKey<ExtendedImageEditorState> editorKey =
//       GlobalKey<ExtendedImageEditorState>();

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         _close();
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: Builder(
//           builder: (_) {
//             final textTheme = Theme.of(context).textTheme;
//             return Stack(
//               children: [
//                 ExtendedImage.file(
//                   widget.imagefile,
//                   cacheRawData: true,
//                   fit: BoxFit.contain,
//                   mode: ExtendedImageMode.editor,
//                   enableLoadState: true,
//                   loadStateChanged: (state) {
//                     if (state.extendedImageLoadState == LoadState.loading) {
//                       return const Center(child: Loading());
//                     } else {
//                       return state.completedWidget;
//                     }
//                   },
//                   extendedImageEditorKey: editorKey,
//                   initEditorConfigHandler: (ExtendedImageState? state) {
//                     return EditorConfig(
//                       maxScale: 8.0,
//                       cropRectPadding: const EdgeInsets.all(20.0),
//                       hitTestSize: 20.0,
//                       cropLayerPainter: const CustomEditorCropLayerPainter(),
//                       initCropRectType: InitCropRectType.imageRect,
//                       cropAspectRatio: CropAspectRatios.ratio1_1,
//                     );
//                   },
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     padding: EdgeInsets.only(
//                       right: 16,
//                       left: 16,
//                       bottom: MediaQuery.of(context).padding.bottom,
//                     ),
//                     color: Colors.white12,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton(
//                           onPressed: _close,
//                           child: Text(
//                             trans.cancel,
//                             style: textTheme.bodyMedium?.copyWith(
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: _cropImage,
//                           child: Text(
//                             trans.confirm,
//                             style: textTheme.bodyMedium?.copyWith(
//                               color: Colors.white,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   AppBlocBase? get bloc => null;

//   @override
//   dynamic get trans => widget.trans;
// }

// class CustomEditorCropLayerPainter extends EditorCropLayerPainter {
//   const CustomEditorCropLayerPainter();

//   @override
//   void paintMask(
//       Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
//     final rect = Offset.zero & size;
//     final cropRect = painter.cropRect;
//     const maskColor = Colors.black12;

//     canvas
//       ..drawRect(
//         Offset.zero & Size(cropRect.left, rect.height),
//         Paint()
//           ..style = PaintingStyle.fill
//           ..color = maskColor,
//       )
//       ..drawRect(
//         Offset(cropRect.left, 0.0) & Size(cropRect.width, cropRect.top),
//         Paint()
//           ..style = PaintingStyle.fill
//           ..color = maskColor,
//       )
//       ..drawRect(
//         Offset(cropRect.right, 0.0) &
//             Size(rect.width - cropRect.right, rect.height),
//         Paint()
//           ..style = PaintingStyle.fill
//           ..color = maskColor,
//       )
//       ..drawRect(
//         Offset(cropRect.left, cropRect.bottom) &
//             Size(cropRect.width, rect.height - cropRect.bottom),
//         Paint()
//           ..style = PaintingStyle.fill
//           ..color = maskColor,
//       );
//   }
// }
