// // ignore_for_file: invalid_use_of_protected_member

// import 'dart:io';
// import 'dart:typed_data';

// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart' as ip;
// import 'package:mime/mime.dart';
// import 'package:pedantic/pedantic.dart';
// import 'package:sprintf/sprintf.dart';
// import 'package:uuid/uuid.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';

// import '../../common/constants.dart';
// import '../../common/services/firebase_storage_service.dart';
// import '../../common/services/permission_service.dart';
// import '../../common/utils.dart';
// import '../../data/data_source/local/local_data_manager.dart';
// import '../../di/di.dart';
// import '../extentions/extention.dart';
// import '../theme/theme_color.dart';
// import 'export.dart';

// enum ImagePickerMode {
//   video,
//   photo,
//   photoAndVideo,
//   viewOnly,
// }

// class ImagePicked {
//   final Key? key;
//   final File? imageFile;
//   final String? url;
//   final String? mimetype;
//   final bool isLoading;
//   final ImagePickerMode mode;

//   ImagePicked({
//     required this.key,
//     this.imageFile,
//     this.url,
//     this.mode = ImagePickerMode.photo,
//     this.mimetype,
//     this.isLoading = false,
//   });

//   ImagePicked copyWith({
//     Key? key,
//     File? imageFile,
//     String? url,
//     ImagePickerMode? mode,
//     bool? isLoading,
//     String? mimetype,
//   }) {
//     return ImagePicked(
//       key: key ?? this.key,
//       imageFile: imageFile ?? this.imageFile,
//       url: url ?? this.url,
//       mode: mode ?? this.mode,
//       isLoading: isLoading ?? this.isLoading,
//       mimetype: mimetype ?? this.mimetype,
//     );
//   }
// }

// class ImagePickerWidget extends StatefulWidget {
//   final ImagePicked imagePicked;
//   final void Function(ImagePicked?)? onImageUploadSucceed;
//   final void Function(ImagePicked?)? onImageUploadFailed;
//   final void Function(ImagePicked)? onImagePicked;
//   final void Function(ImagePicked?)? onRemove;
//   final void Function(ImagePicked?)? onTap;
//   final String? uploadFolder;
//   final List<ip.ImageSource> sources;
//   final String? title;
//   final String? message;
//   final bool? canBeDelete;
//   final dynamic trans;

//   const ImagePickerWidget({
//     Key? key,
//     required this.imagePicked,
//     this.onImageUploadSucceed,
//     this.onImageUploadFailed,
//     this.onRemove,
//     this.onTap,
//     this.onImagePicked,
//     this.uploadFolder,
//     this.sources = ip.ImageSource.values,
//     this.title,
//     this.message,
//     this.canBeDelete = true,
//     required this.trans,
//   }) : super(key: key);

//   @override
//   _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
// }

// class _ImagePickerWidgetState extends State<ImagePickerWidget> {
//   ImagePicked? _image;

//   Uint8List? videoThumnail;

//   LocalDataManager get localDataManager => injector.get();

//   final defaultMaximunUploadSize = 60 * 1024 * 1024;

//   final picker = ip.ImagePicker();

//   @override
//   void initState() {
//     _image = widget.imagePicked;

//     super.initState();
//   }

//   @override
//   void didUpdateWidget(covariant ImagePickerWidget oldWidget) {
//     _image = widget.imagePicked;
//     super.didUpdateWidget(oldWidget);
// }

//   double get borderRadius => 8;

//   @override
//   Widget build(BuildContext context) {
//     if (_image == null ||
//         (_image!.imageFile == null && _image!.url?.isNotEmpty != true)) {
//       return _buildEmptyState();
//     }

//     if (_image!.url?.isNotEmpty != true) {
//       return _buildImage(_image, true);
//     }
//     return _buildImage(_image, false);
//   }

//   Widget _buildEmptyState() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 6, right: 6),
//       child: Material(
//         color: themeColor.white,
//         borderRadius: BorderRadius.circular(borderRadius),
//         child: InkWell(
//           onTap: () => _showImagePickerActionDialog(_image),
//           borderRadius: BorderRadius.circular(borderRadius),
//           child: DottedBorder(
//             color: themeColor.primaryColor,
//             strokeWidth: 1,
//             dashPattern: const [5, 3],
//             strokeCap: StrokeCap.round,
//             borderType: BorderType.RRect,
//             radius: const Radius.circular(8),
//             child: Align(
//               child: Icon(
//                 Icons.add_rounded,
//                 size: 24,
//                 color: themeColor.primaryColor,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildImage(ImagePicked? image, bool isLoading) {
//     final mimeStr = lookupMimeType(image?.imageFile?.path ?? '') ?? '';

//     final isVideo =
//         mimeStr.contains('video') || image?.mimetype?.contains('video') == true;

//     return FutureBuilder(
//         future: isVideo
//             ? _generateThumbnail(image?.imageFile?.path.isNotEmpty == true
//                 ? image?.imageFile?.path ?? ''
//                 : image?.url?.isNotEmpty == true
//                     ? image?.url ?? ''
//                     : '')
//             : null,
//         builder: (context, snapshot) {
//           return LayoutBuilder(builder: (context, constraints) {
//             return Stack(
//               fit: StackFit.expand,
//               children: [
//                 GestureDetector(
//                   onTap:
//                       widget.onTap != null ? () => widget.onTap!(image) : null,
//                   child: Align(
//                     alignment: Alignment.bottomLeft,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(borderRadius),
//                       child: snapshot.connectionState != ConnectionState.done &&
//                               isVideo
//                           ? Center(
//                               child: GestureDetector(
//                                 onTap: () => widget.onTap!(image),
//                                 child: Container(
//                                   width: constraints.maxWidth - 6,
//                                   height: constraints.maxHeight - 6,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white38,
//                                     borderRadius:
//                                         BorderRadius.circular(borderRadius),
//                                   ),
//                                   child: const Loading(
//                                     brightness: Brightness.light,
//                                     radius: 12,
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : SizedBox(
//                               width: constraints.maxWidth - 6,
//                               height: constraints.maxHeight - 6,
//                               child: Stack(
//                                 children: [
//                                   Hero(
//                                     tag: image!.key.toString(),
//                                     child: image.imageFile != null || isVideo
//                                         ? isVideo
//                                             ? Image.memory(
//                                                 videoThumnail ?? Uint8List(0),
//                                                 fit: BoxFit.cover,
//                                                 width: constraints.maxWidth - 6,
//                                                 height:
//                                                     constraints.maxHeight - 6,
//                                               )
//                                             : Image.file(
//                                                 image.imageFile!,
//                                                 fit: BoxFit.cover,
//                                                 width: constraints.maxWidth - 6,
//                                                 height:
//                                                     constraints.maxHeight - 6,
//                                               )
//                                         : image.url?.isNotEmpty == true
//                                             ? CachedNetworkImageWrapper.item(
//                                                 url: image.url ?? '',
//                                                 fit: BoxFit.cover,
//                                                 width: constraints.maxWidth - 6,
//                                                 height:
//                                                     constraints.maxHeight - 6,
//                                               )
//                                             : const SizedBox(),
//                                   ),
//                                   if (isVideo)
//                                     Center(
//                                       child: GestureDetector(
//                                         onTap: () => widget.onTap!(image),
//                                         child: SvgPicture.asset(
//                                           injector
//                                               .get<CoreImageConstant>()
//                                               .icPlay,
//                                           height: 32,
//                                           width: 32,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                   if (isLoading)
//                                     Center(
//                                       child: GestureDetector(
//                                         onTap: () => widget.onTap!(image),
//                                         child: Container(
//                                           width: constraints.maxWidth - 6,
//                                           height: constraints.maxHeight - 6,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white38,
//                                             borderRadius: BorderRadius.circular(
//                                                 borderRadius),
//                                           ),
//                                           child: const Loading(
//                                             brightness: Brightness.light,
//                                             radius: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//                 if (widget.canBeDelete == true)
//                   Positioned(
//                     right: -13,
//                     top: -13,
//                     child: IconButton(
//                       iconSize: 20,
//                       padding: EdgeInsets.zero,
//                       icon: Container(
//                         width: 20,
//                         height: 20,
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFFB4B53),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Icon(
//                           Icons.close,
//                           size: 10,
//                           color: Colors.white,
//                         ),
//                       ),
//                       onPressed: widget.onRemove != null
//                           ? () => widget.onRemove!(image)
//                           : null,
//                     ),
//                   ),
//               ],
//             );
//           });
//         });
//   }

//   void updateState(ImagePicked image) {
//     if (mounted) {
//       setState(() {
//         _image = image;
//       });
//     }
//   }
// }

// extension ImagePickerWidgetAction on _ImagePickerWidgetState {
//   Future<void> _showImagePickerActionDialog(ImagePicked? imagePicked) async {
//     if (!await PermissionService.requestPhotoPermission()) {
//       return;
//     }

//     if (widget.sources.length == ip.ImageSource.values.length) {
//       var mode = imagePicked?.mode;

//       if (mode == ImagePickerMode.photoAndVideo) {
//         // Close dialog if user do not choose any option
//         mode = null;

//         await showActionDialog(
//           context,
//           trans: widget.trans,
//           title: widget.title ?? _getDialogTitle(widget.imagePicked.mode),
//           subTitle: widget.message ?? '',
//           actions: {
//             widget.trans.choosePhoto: () => mode = ImagePickerMode.photo,
//             widget.trans.chooseVideo: () => mode = ImagePickerMode.video,
//           },
//         );
//       }

//       if (mode == null) {
//         return;
//       }

//       return showActionDialog(
//         context,
//         trans: widget.trans,
//         title: widget.title ?? _getDialogTitle(mode!),
//         subTitle: widget.message ?? '',
//         actions: {
//           widget.trans.camera: () => _openCamera(mode),
//           widget.trans.gallery: () => _openGallery(mode),
//         },
//       );
//     } else {
//       ImagePickerMode? mode;
//       await showActionDialog(
//         context,
//         trans: widget.trans,
//         title: widget.title ?? _getDialogTitle(widget.imagePicked.mode),
//         subTitle: widget.message ?? '',
//         actions: {
//           widget.trans.choosePhoto: () => mode = ImagePickerMode.photo,
//           widget.trans.chooseVideo: () => mode = ImagePickerMode.video,
//         },
//       );

//       if (mode == null) {
//         return;
//       }

//       if (widget.sources.contains(ip.ImageSource.camera)) {
//         return _openCamera(mode);
//       } else if (widget.sources.contains(ip.ImageSource.gallery)) {
//         return _openGallery(mode);
//       }
//     }
//   }

//   void cleanImageCache() {
//     imageCache.clear();
//   }

//   Future<void> _openGallery(ImagePickerMode? mode) async {
//     if (await PermissionService.requestPhotoPermission()) {
//       final pickedFile = mode == ImagePickerMode.photo
//           ? await picker
//               .pickImage(source: ip.ImageSource.gallery)
//               .then(Future<ip.XFile?>.value)
//               .catchError(
//                 (error, stackTrace) => LogUtils.eCatch<ip.XFile>(
//                   '_openGalleryToChoosePhoto',
//                   error,
//                   stackTrace,
//                 ),
//               )
//           : await picker
//               .pickVideo(source: ip.ImageSource.gallery)
//               .then(Future<ip.XFile?>.value)
//               .catchError(
//                 (error, stackTrace) => LogUtils.eCatch<ip.XFile>(
//                   '_openGalleryToChooseVideo',
//                   error,
//                   stackTrace,
//                 ),
//               );
//       if (pickedFile != null && pickedFile.path.isNotEmpty == true) {
//         final file = File(pickedFile.path);
//         cleanImageCache();

//         final isPicked = await _onImagePicked(file);

//         if (isPicked == true) {
//           unawaited(_uploadImage(file));
//         }
//       }
//     }
//   }

//   Future<void> _openCamera(ImagePickerMode? mode) async {
//     if (await PermissionService.requestPermission(Permission.camera)) {
//       var pickedFile = mode == ImagePickerMode.photo
//           ? await picker
//               .pickImage(source: ip.ImageSource.camera)
//               .then(Future<ip.XFile?>.value)
//               .catchError(
//                 (error, stackTrace) => LogUtils.eCatch<ip.XFile>(
//                   '_openCameraToCapturePhoto',
//                   error,
//                   stackTrace,
//                 ),
//               )
//           : await picker
//               .pickVideo(
//                 source: ip.ImageSource.camera,
//               )
//               .then(Future<ip.XFile?>.value)
//               .catchError(
//                 (error, stackTrace) => LogUtils.eCatch<ip.XFile>(
//                   '_openCameraToRecordVideo',
//                   error,
//                   stackTrace,
//                 ),
//               );

//       if (pickedFile == null) {
//         final response = await picker.retrieveLostData();
//         if (response.isEmpty) {
//           return;
//         }
//         if (response.files != null) {
//           pickedFile = response.files?.first;
//         }
//       }

//       if (pickedFile != null && pickedFile.path.isNotEmpty == true) {
//         final file = File(pickedFile.path);
//         cleanImageCache();

//         final isPicked = await _onImagePicked(file);

//         if (isPicked == true) {
//           unawaited(_uploadImage(file));
//         }
//       }
//     }
//   }

//   Future<bool?> _onImagePicked(File imageFile) async {
//     final isAccepted = await _checkFileSizeInMb(imageFile);

//     if (isAccepted == true) {
//       final newImage = _image!.copyWith(
//         imageFile: imageFile,
//         isLoading: true,
//       );
//       updateState(
//         newImage.copyWith(),
//       );

//       widget.onImagePicked?.call(newImage);

//       return true;
//     }

//     return false;
//   }

//   Future<void> _uploadImage(File imageFile) async {
//     final result = await FirebaseStorageService.uploadFile(imageFile,
//             fileName: _generateFileName(),
//             folder: 'uploads/${widget.uploadFolder}')
//         .then(Future<CloudStorageResult?>.value)
//         .catchError(
//           (error, stackTrace) => LogUtils.eCatch(
//             '_uploadImage',
//             error,
//             stackTrace,
//           ),
//         );

//     if (result?.url?.isNotEmpty == true) {
//       widget.onImageUploadSucceed?.call(
//         _image!.copyWith(
//           imageFile: imageFile,
//           url: result!.url,
//           isLoading: false,
//         ),
//       );

//       updateState(_image!.copyWith(
//         imageFile: imageFile,
//         url: result!.url,
//         isLoading: false,
//       ));
//     } else {
//       widget.onImageUploadFailed?.call(_image);
//     }
//   }

//   String _getDialogTitle(ImagePickerMode mode) {
//     switch (mode) {
//       case ImagePickerMode.photo:
//         return widget.trans.choosePhoto;
//       case ImagePickerMode.video:
//         return widget.trans.chooseVideo;
//       case ImagePickerMode.photoAndVideo:
//         return widget.trans.choosePhotoOrVideo;
//       default:
//         return '';
//     }
//   }

//   Future<void> _generateThumbnail(String videoPath) async {
//     cleanImageCache();

//     imageCache.clearLiveImages();

//     final data = await VideoThumbnail.thumbnailData(
//       video: videoPath,
//       maxHeight: 100,
//       quality: 100,
//     );

//     if (videoThumnail == null) {
//       setState(() {
//         videoThumnail = data;
//       });
//     }
//     // == null ? null : File.fromRawPath(_path);
//   }

//   Future<void> retrieveLostData() async {
//     final response = await picker.retrieveLostData();
//     if (response.isEmpty) {
//       return;
//     }
//     if (response.file != null) {
//       if (response.type == ip.RetrieveType.video) {
//         setState(() {
//           _image = _image?.copyWith(imageFile: File(response.file!.path));
//         });
//       } else {
//         setState(() {
//           _image = _image?.copyWith(imageFile: File(response.file!.path));
//         });
//       }
//     }
//   }

//   String _generateFileName() {
//     return '''${const Uuid().v4()}_${DateTime.now().toUtc()}''';
//   }

//   Future<bool?> _checkFileSizeInMb(File imageFile) async {
//     final sizeInBytes = imageFile.lengthSync();
//     final sizeInMb = sizeInBytes / (1024 * 1024);
//     final maximumSizeInMb = (localDataManager.appSettings?.maxUploadSize ??
//             defaultMaximunUploadSize) /
//         (1024 * 1024);

//     if (sizeInMb > maximumSizeInMb) {
//       await showNoticeDialog(
//         context: context,
//         message: sprintf(
//           widget.trans.maximumUploadSize,
//           [
//             maximumSizeInMb.toInt(),
//           ],
//         ),
//         trans: widget.trans,
//       );

//       return false;
//     }
//     return true;
//   }
// }
