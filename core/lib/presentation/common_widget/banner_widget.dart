import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/banner.dart';
import '../theme/theme_color.dart';
import 'cache_network_image_wrapper.dart';

class BannerWidget extends StatefulWidget {
  final List<BannerModel>? banners;
  final void Function(BannerModel)? onTap;
  final double ratio;

  const BannerWidget({
    Key? key,
    this.banners,
    this.onTap,
    this.ratio = 1,
  }) : super(key: key);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final pageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const viewportFraction = 1.0;
    final imageWidth = width * viewportFraction - (16 * 2);
    final imageHeight = imageWidth / widget.ratio;

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            initialPage: pageNotifier.value,
            autoPlay: true,
            autoPlayInterval: const Duration(
              seconds: 5,
            ),
            autoPlayAnimationDuration: const Duration(
              milliseconds: 450,
            ),
            aspectRatio: (width / viewportFraction) / imageHeight,
            enlargeCenterPage: true,
            viewportFraction: viewportFraction,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              pageNotifier.value = index;
            },
          ),
          items: [
            ...widget.banners!.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BannerItem(
                  item: e,
                  onTap: () => widget.onTap?.call(e),
                  width: imageWidth,
                  height: imageHeight,
                ),
              ),
            ),
          ],
        ),
        _buildBannerIndicator(),
      ],
    );
  }

  Widget _buildBannerIndicator() {
    final numPages = widget.banners?.length ?? 0;
    if (numPages == 0) {
      return const SizedBox();
    }
    return Align(
      alignment: Alignment.center,
      child: ValueListenableBuilder(
        valueListenable: pageNotifier,
        builder: (context, dynamic idx, snapshot) {
          return DotsIndicator(
            dotsCount: numPages,
            position: (idx as int) < numPages ? idx : (numPages - 1),
            decorator: DotsDecorator(
              size: numPages < 10 ? const Size.square(6) : const Size.square(4),
              activeSize:
                  numPages < 10 ? const Size.square(6) : const Size.square(4),
              color: Colors.black12,
              activeColor: themeColor.activeColor,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              spacing: numPages < 10
                  ? const EdgeInsets.only(left: 4, top: 7, right: 4)
                  : const EdgeInsets.only(left: 2, top: 7, right: 2),
            ),
          );
        },
      ),
    );
  }
}

class BannerItem extends StatelessWidget {
  final BannerModel? item;
  final Function? onTap;
  final double width;
  final double height;
  final double scale;
  const BannerItem({
    Key? key,
    this.item,
    this.onTap,
    required this.width,
    required this.height,
    this.scale = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      borderRadius: BorderRadius.circular(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: themeColor.white,
          child: CachedNetworkImageWrapper.banner(
            key: ValueKey('${item?.mediaUrl}_banner'),
            url: item?.mediaUrl ?? '',
            fit: BoxFit.cover,
            width: double.infinity,
            maxWidthDiskCache: (width * scale).toInt(),
            maxHeightDiskCache: (height * scale).toInt(),
          ),
        ),
      ),
    );
  }
}
