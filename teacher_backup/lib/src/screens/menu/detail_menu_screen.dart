import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:core/resources/app_colors.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/src/utils/extension_context.dart';

class DetailMenuScreen extends StatelessWidget {
  const DetailMenuScreen({super.key, required this.item});
  final DataInWeek item;
  static const routeName = '/detailMenu';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackGroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenAppBar(
              canGoback: true,
              title: item.category,
              onBack: () {
                context.pop();
              },
            ),
            Flexible(
                child: Container(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                    ),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: NetworkImage(item.picture.isNotEmpty
                                  ? item.picture
                                  : 'assets/images/breakfast.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            textAlign: TextAlign.left,
                            item.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
