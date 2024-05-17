import 'package:core/core.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/buttons/rounded_button.dart';
import 'package:iportal2/components/empty_screen.dart';
import 'package:iportal2/components/home_shadow_box.dart';
import 'package:iportal2/screens/gallery/gallery_screen.dart';
import 'package:iportal2/screens/gallery/widget/gallery_detail/gallery_detail.dart';
import 'package:iportal2/screens/home/bloc/home_bloc.dart';

class ImagesLibrary extends StatelessWidget {
  const ImagesLibrary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final albumList = state.albumData.items
            .where((element) => element.galleryImages.isNotEmpty)
            .toList();

        final pinnedIdList = state.pinnedAlbumIdList;

        final pinnedAlbumList = pinnedIdList.isNotEmpty
            ? albumList
                .where((element) => pinnedIdList.contains(element.galleryId))
                .toList()
            : albumList;

        final isLoading = state.statusAlbum == HomeStatus.loading;
        final isEmptyData = pinnedAlbumList.isEmpty && !isLoading;

        return ShaDowBoxContainer(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 13,
                        backgroundColor: AppColors.red,
                        child: SvgPicture.asset(
                          'assets/icons/file.svg',
                          width: 14,
                          height: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Thư viện ảnh hoạt động',
                          style: AppTextStyles.semiBold14(
                            color: AppColors.blueGray800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  isEmptyData
                      ? const SizedBox()
                      : RoundedButton(
                          onTap: () async {
                            final List<int>? listId =
                                await context.push(const GalleryScreen());
                            if (listId != null) {
                              context.read<HomeBloc>().add(
                                    HomeUpdatePinnedAlbum(
                                      listId,
                                      isOnlyUpdateState: true,
                                    ),
                                  );
                            }
                          },
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 6),
                          borderRadius: 12,
                          border: Border.all(
                            color: AppColors.gray300,
                          ),
                          buttonColor: AppColors.white,
                          child: Text(
                            'Xem thêm',
                            style: AppTextStyles.normal12(
                                color: AppColors.gray600),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 180,
                child: AppSkeleton(
                  isLoading: isLoading,
                  child: isEmptyData
                      ? const EmptyScreen(text: 'Thư viện ảnh của bạn trống!')
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: pinnedAlbumList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final album = pinnedAlbumList[index];
                            String imgUrl =
                                album.galleryImages[0].images.mobile;

                            return InkWell(
                              onTap: () {
                                context.push(GalleryDetail(
                                  galleryItem: album,
                                  isFromHomeScreen: true,
                                ));
                              },
                              child: Container(
                                width: 120,
                                padding: const EdgeInsets.only(top: 12),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 105,
                                      width: 105,
                                      decoration: BoxDecoration(
                                        borderRadius: AppRadius.rounded14,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(imgUrl)),
                                        color: AppColors.white,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 4, 2, 4),
                                        child: Text(
                                          album.galleryName,
                                          style: AppTextStyles.normal12(
                                            color: AppColors.gray600,
                                          ),
                                          textAlign: TextAlign.left,
                                          softWrap: true,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// class HomeGallerySkeleton extends StatelessWidget {
//   const HomeGallerySkeleton({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 3,
//       scrollDirection: Axis.horizontal,
//       itemBuilder: (context, index) => Container(
//         padding: const EdgeInsets.only(top: 12),
//         width: 120,
//         height: 200,
//         child: Column(
//           children: [
//             const SkeletonAvatar(
//               style: SkeletonAvatarStyle(
//                   width: 105,
//                   height: 105,
//                   borderRadius: BorderRadius.all(Radius.circular(14))),
//             ),
//             const SizedBox(height: 4),
//             Expanded(
//               child: Column(
//                 children: [
//                   SkeletonParagraph(
//                     style: SkeletonParagraphStyle(
//                         lines: 2,
//                         lineStyle: SkeletonLineStyle(
//                           randomLength: true,
//                           alignment: Alignment.centerLeft,
//                           height: 14,
//                           borderRadius: BorderRadius.circular(8),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
