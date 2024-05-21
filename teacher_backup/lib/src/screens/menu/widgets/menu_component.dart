import 'package:core/data/models/menu.dart';
import 'package:flutter/material.dart';
import 'package:teacher/model/menu_in_week_data_model.dart';

class ShowPopupMenu extends StatefulWidget {
  const ShowPopupMenu({super.key, required this.item});
  final MenuInWeekDataModelDetail item;
  @override
  State<ShowPopupMenu> createState() => _ShowPopupMenuState();
}

class _ShowPopupMenuState extends State<ShowPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      surfaceTintColor: Colors.transparent,
      content: IntrinsicHeight(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: NetworkImage(widget.item.thucDonTuanPicture != null
                      ? widget.item.thucDonTuanPicture ?? ''
                      : 'assets/images/breakfast.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                textAlign: TextAlign.left,
                widget.item.thucDonTuanTitle ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
