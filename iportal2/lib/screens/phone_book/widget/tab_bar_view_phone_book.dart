import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iportal2/components/textfield/input_text.dart';
import 'package:iportal2/screens/phone_book/model/list_phone_book.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/resources/assets.gen.dart';

class TabBarViewPhoneBook extends StatefulWidget {
  TabBarViewPhoneBook({Key? key, required this.phoneBook});

  final List<PhoneBook> phoneBook;

  @override
  State<TabBarViewPhoneBook> createState() => _TabBarViewPhoneBookState();
}

class _TabBarViewPhoneBookState extends State<TabBarViewPhoneBook> {
  late List<PhoneBook> _filteredPhoneBook;

  @override
  void initState() {
    super.initState();
    _filteredPhoneBook = widget.phoneBook;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          colors: [
            AppColors.lightBlue,
            AppColors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(Assets.icons.phoneBook),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  'Bạn cùng lớp của Lan (${widget.phoneBook.length})',
                  style: AppTextStyles.normal16(
                      color: AppColors.brand600, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TitleAndInputText(
              hintText: 'Tìm kiếm',
              onChanged: (value) {
                _filteredPhoneBook = widget.phoneBook.where((entry) {
                  return entry.name.toLowerCase().contains(value.toLowerCase());
                }).toList();

                _updateList(_filteredPhoneBook);
              },
              prefixIcon: Assets.images.search.image(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: _filteredPhoneBook.length,
              itemBuilder: (BuildContext context, index) {
                final info = _filteredPhoneBook[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              child: Image.asset(info.image),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    info.name,
                                    style: AppTextStyles.normal14(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    info.id,
                                    style: AppTextStyles.normal12(
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(Assets.icons.send),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _updateList(List<PhoneBook> filteredList) {
    // Cập nhật giao diện người dùng với danh sách đã lọc
    setState(() {
      _filteredPhoneBook = filteredList;
    });
  }
}
