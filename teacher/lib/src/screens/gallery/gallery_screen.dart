import 'package:core/core.dart';
import 'package:core/presentation/common_widget/export.dart';

import 'package:flutter/material.dart';

import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/model/gallery_model.dart';

import 'package:teacher/repository/gallery_repository/gallery_repositories.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/gallery/bloc/gallery_bloc.dart';
import 'package:teacher/src/screens/gallery/widget/gallery_card/card_gallery.dart';

import 'package:teacher/src/utils/extension_context.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({required this.teacherId, super.key});
  static const routeName = '/gallery';
  final int teacherId;
  @override
  State<GalleryScreen> createState() => GalleryScreenState();
}

class GalleryScreenState extends State<GalleryScreen> {
  final bloc =
      GalleryBloc(galleryRepository: Injection.get<GalleryRepository>());
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    bloc.add(GalleryGetListAlbum(teacherId: widget.teacherId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        children: [
          ScreenAppBar(
            title: 'Thư viện ảnh',
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          Expanded(
            child: BlocBuilder<GalleryBloc, GalleryState>(
              bloc: bloc,
              builder: (context, state) {
                if (state.status == GalleryStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == GalleryStatus.error) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else if (isNullOrEmpty(
                    state.galleryAlbumModel.galleryAlbum)) {
                  return Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: const Center(
                      child: Text('No data'),
                    ),
                  );
                } else {
                  final galleryAlbum = state.galleryAlbumModel.galleryAlbum;
                  return Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: AppRadius.roundedTop28,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text(
                                  "Thư viện ảnh ",
                                  style: AppTextStyles.semiBold16(
                                      color: AppColors.brand600),
                                ),
                                Text(
                                  "(${galleryAlbum?.length})",
                                  style: AppTextStyles.normal14(
                                      color:
                                          AppColors.gray600.withOpacity(0.4)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: SmartRefresher(
                              controller: _refreshController,
                              onRefresh: () async {
                                bloc.add(GalleryGetListAlbum(
                                    teacherId: widget.teacherId));
                              },
                              child: GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 16,
                                          crossAxisSpacing: 8,
                                          childAspectRatio: 3 / 4),
                                  itemCount: galleryAlbum?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return CardGallery(
                                      galleryItem: galleryAlbum?[index] ??
                                          GalleryModel(),
                                    );
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
