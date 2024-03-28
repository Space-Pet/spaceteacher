import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart' as ip;

import '../../presentation/extentions/extention.dart';
import '../../presentation/modules/image_cropper/image_cropper_screen_web.dart';
import '../services/permission_service.dart';
import 'log_utils.dart';

class ImagePicker {
  final picker = ip.ImagePicker();

  final BuildContext context;
  final String title;
  final bool crop;

  ImagePicker(this.context, this.title, {this.crop = false});

  Future<File?> show(
    dynamic trans,
  ) {
    final completer = Completer<File?>();
    showActionDialog(
      context,
      title: title,
      trans: trans,
      actions: {
        trans.takePhoto: () async {
          final file = await _openCamera(trans);
          completer.complete(file);
        },
        trans.selectPhoto: () async {
          final file = await _openGallery(trans);
          completer.complete(file);
        },
      },
    );
    return completer.future;
  }

  Future<File?> _openCamera(
    dynamic trans,
  ) async {
    if (await PermissionService.requestPermission(Permission.camera)) {
      final pickedFile =
          await picker.pickImage(source: ip.ImageSource.camera).catchError(
                (error, stackTrace) => LogUtils.eCatch<ip.XFile>(
                  '_openCamera',
                  error,
                  stackTrace,
                ),
              );
      return _openImageCropper(pickedFile, trans);
    }
    return null;
  }

  Future<File?> _openGallery(
    dynamic trans,
  ) async {
    if (await PermissionService.requestPhotoPermission()) {
      final pickedFile =
          await picker.pickImage(source: ip.ImageSource.gallery).catchError(
                (error, stackTrace) => LogUtils.eCatch<ip.XFile>(
                  '_openGallery',
                  error,
                  stackTrace,
                ),
              );
      return _openImageCropper(pickedFile, trans);
    }
    return null;
  }

  Future<File?> _openImageCropper(
    ip.XFile? pickedFile,
    dynamic trans,
  ) async {
    if (pickedFile == null || pickedFile.path.isEmpty) {
      return null;
    }
    final imageFile = File(pickedFile.path);
    if (!crop) {
      return imageFile;
    }
    final file = await Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) {
        return ImageCropperScreen(
          imagefile: imageFile,
          // trans: trans,
        );
      }),
    );
    return file as File?;
  }
}
