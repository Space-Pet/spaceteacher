import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/components/empty_screen.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/gallery/bloc/gallery_bloc.dart';
import 'package:iportal2/screens/gallery/widget/gallery_card/card_gallery.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});
  static const routeName = '/gallery';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryBloc(
        context.read<AppFetchApiRepository>(),
        userRepository: context.read<UserRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          final galleryBloc = context.read<GalleryBloc>();
          final albumList = state.albumData.items
              .where((element) => element.galleryImages.isNotEmpty)
              .toList();

          final pinnedAlbumIdList = state.pinnedAlbumIdList;

          final isLoading = state.status == GalleryStatus.loading;
          final isEmptyData = albumList.isEmpty && !isLoading;

          return BackGroundContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenAppBar(
                  title: 'Thư viện ảnh (${albumList.length})',
                  canGoback: true,
                  onBack: () {
                    context.pop(pinnedAlbumIdList);
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: AppRadius.roundedTop28,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          Expanded(
                            child: CustomRefresh(
                              onRefresh: () async {
                                galleryBloc.add(GalleryFetchData());
                                galleryBloc.add(GalleryGetPinnedAlbumIdList());
                              },
                              child: Stack(
                                children: [
                                  ListView(),
                                  AppSkeleton(
                                    isLoading: isLoading,
                                    skeleton: const GallerySkeleton(),
                                    child: isEmptyData
                                        ? const Center(
                                            child: EmptyScreen(
                                                text:
                                                    'Thư viện ảnh của bạn trống!'),
                                          )
                                        : GalleryListView(
                                            itemCount: albumList.length,
                                            itemBuilder: (context, index) {
                                              final isPinned = pinnedAlbumIdList
                                                  .contains(albumList[index]
                                                      .galleryId);

                                              return CardGallery(
                                                galleryItem: albumList[index],
                                                isPinned: isPinned,
                                                onUpdatePinAlbum: () {
                                                  final albumId =
                                                      albumList[index]
                                                          .galleryId;

                                                  if (pinnedAlbumIdList
                                                      .contains(albumId)) {
                                                    final newList =
                                                        pinnedAlbumIdList
                                                            .where((element) =>
                                                                element !=
                                                                albumId)
                                                            .toList();

                                                    galleryBloc.add(
                                                        GalleryUpdatePinnedAlbum(
                                                            newList));
                                                  } else {
                                                    final newList = [
                                                      ...pinnedAlbumIdList,
                                                      albumId
                                                    ];

                                                    galleryBloc.add(
                                                        GalleryUpdatePinnedAlbum(
                                                            newList));
                                                  }
                                                },
                                              );
                                            }),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GallerySkeleton extends StatelessWidget {
  const GallerySkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GalleryListView(
      itemCount: 6,
      itemBuilder: (context, index) => Column(
        children: [
          const SkeletonAvatar(
            style: SkeletonAvatarStyle(
                width: 160,
                height: 160,
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                )),
          ),
          const SizedBox(height: 4),
          SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 2,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  alignment: Alignment.centerLeft,
                  height: 12,
                  borderRadius: BorderRadius.circular(8),
                )),
          ),
        ],
      ),
    );
  }
}

class GalleryListView extends StatelessWidget {
  const GalleryListView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
  });

  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemW = (screenWidth - 40) / 2;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisExtent: itemW + 64,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
