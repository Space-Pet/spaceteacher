import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/constants.dart';
import '../../common/utils.dart';
import '../../data/models/post.dart';
import '../theme/theme_color.dart';
import 'cache_network_image_wrapper.dart';

class NewsWidget extends StatelessWidget {
  final Post news;
  final Function(Post)? onTap;
  final ThemeData theme;
  final String languageCode;

  const NewsWidget({
    Key? key,
    required this.news,
    required this.theme,
    required this.languageCode,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(news),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: themeColor.white,
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImageWrapper.item(
                  url: news.featuredImageUrl ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    languageCode == 'vi'
                        ? news.name ?? '-'
                        : news.nameEn ?? news.name ?? '-',
                    style: theme.textTheme.bodyText2?.copyWith(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        coreImageConstant.icTime,
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        news.publishedAt?.serverToNormalFullFormat() ?? '--',
                        style: theme.textTheme.subtitle1?.copyWith(
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
