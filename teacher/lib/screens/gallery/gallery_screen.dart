import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/custom_refresh.dart';
import 'package:teacher/screens/gallery/bloc/gallery_bloc.dart';
import 'package:teacher/screens/gallery/widget/gallery_card/card_gallery.dart';
import 'package:teacher/screens/gallery/widget/gallery_create/gallery_create.dart';

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
                    context.pop();
                  },
                  iconRight: Assets.icons.addMessage,
                  onRight: () async {
                    final bool? shouldRefresh =
                        await context.push(const GalleryCreateNew());

                    if (shouldRefresh ?? false) {
                      galleryBloc.add(GalleryFetchData());
                    }
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
                              },
                              child: Stack(
                                children: [
                                  ListView(),
                                  AppSkeleton(
                                    isLoading: isLoading,
                                    child: isEmptyData
                                        ? const Center(
                                            child: EmptyScreen(
                                                text:
                                                    'Thư viện ảnh của bạn trống!'),
                                          )
                                        : BlocBuilder<CurrentUserBloc,
                                            CurrentUserState>(
                                            builder: (context, state) {
                                              final pinnedAlbumIdList =
                                                  state.user.pinnedAlbumIdList;

                                              return GalleryListView(
                                                  itemCount: albumList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final isPinned =
                                                        pinnedAlbumIdList
                                                            .contains(
                                                                albumList[index]
                                                                    .galleryId);

                                                    return CardGallery(
                                                      galleryItem:
                                                          albumList[index],
                                                      isPinned: isPinned,
                                                      onUpdatePinAlbum: () {
                                                        final albumId =
                                                            albumList[index]
                                                                .galleryId;

                                                        galleryBloc.add(
                                                            GalleryUpdatePinnedAlbum(
                                                          albumId: albumId,
                                                        ));
                                                      },
                                                    );
                                                  });
                                            },
                                          ),
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
