import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';

import 'package:teacher/components/back_ground_container.dart';

import 'package:core/resources/resources.dart';

import 'package:teacher/src/utils/extension_context.dart';

class GalleryAddAlbum extends StatefulWidget {
  const GalleryAddAlbum({super.key});
  static const routeName = '/gallery_add_album';

  @override
  State<GalleryAddAlbum> createState() => GalleryAddAlbumState();
}

class GalleryAddAlbumState extends State<GalleryAddAlbum> {
  final TextEditingController _albumNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<XFile> _images = [];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> selectedImages = await picker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      setState(() {
        _images.addAll(selectedImages);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundContainer(
        child: Column(
          children: [
            ScreensAppBar(
              'Tạo thư viện ảnh mới',
              canGoBack: true,
              onBack: () {
                context.pop();
              },
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Tên Thư viện ảnh mới',
                              style: AppTextStyles.bold16(),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _albumNameController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8.0),
                                hintText: 'Nhập tên thư viện ảnh mới',
                                hintStyle: AppTextStyles.normal16(
                                    color: AppColors.gray400),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.gray300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.gray300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.gray300,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Thêm mô tả',
                              style: AppTextStyles.bold16(),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8.0),
                                hintText: 'Thêm mô tả (Không bắt buộc)',
                                hintStyle: AppTextStyles.normal16(
                                    color: AppColors.gray400),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.gray300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.gray300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.gray300,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Ảnh',
                              style: AppTextStyles.bold16(),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        color: AppColors.white,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: _images.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return GestureDetector(
                                onTap: _pickImage,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  dashPattern: const [3, 3],
                                  color: AppColors.gray400,
                                  radius: const Radius.circular(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          radius: const Radius.circular(30),
                                          dashPattern: const [3, 3],
                                          color: AppColors.gray400,
                                          child: const Icon(
                                            Icons.add,
                                            color: AppColors.gray400,
                                            size: 20,
                                          ),
                                        )),
                                  ),
                                ),
                              );
                            }
                            final imageIndex = index - 1;
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.file(
                                  File(_images[imageIndex].path),
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.cancel,
                                        color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        _images.removeAt(imageIndex);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.observationStatusMyObsBG,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text('Đăng',
                              style:
                                  AppTextStyles.bold16(color: AppColors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
