import 'package:core/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher/screens/phone_book/model/list_phone_book.dart';

class TabBarViewPhoneBook extends StatefulWidget {
  const TabBarViewPhoneBook({
    super.key,
    this.phoneBookStudent,
    required this.title,
    this.phoneBookTeacher,
    this.onStudentTap,
    this.onParentTap,
    required this.index,
  });

  final List<PhoneBook>? phoneBookStudent;
  final List<PhoneBook>? phoneBookTeacher;
  final String title;
  final void Function(PhoneBook)? onStudentTap;
  final void Function(PhoneBook)? onParentTap;
  final int index;

  @override
  State<TabBarViewPhoneBook> createState() => _TabBarViewPhoneBookState();
}

class _TabBarViewPhoneBookState extends State<TabBarViewPhoneBook> {
  late List<PhoneBook>? _filteredPhoneBookStudent;
  late List<PhoneBook>? _filteredPhoneBookTeacher;
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _filteredPhoneBookStudent = widget.phoneBookStudent;
    _filteredPhoneBookTeacher = widget.phoneBookTeacher;

    _filteredPhoneBookStudent = widget.phoneBookStudent
        ?.where((entry) =>
            entry.fullName.toLowerCase().contains(_searchKeyword.toLowerCase()))
        .toList();
    _filteredPhoneBookTeacher = widget.phoneBookTeacher
        ?.where((entry) =>
            entry.fullName.toLowerCase().contains(_searchKeyword.toLowerCase()))
        .toList();

    Widget tabStudent() {
      return _filteredPhoneBookStudent != null &&
              _filteredPhoneBookStudent!.isEmpty
          ? Container()
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _filteredPhoneBookStudent?.length,
              itemBuilder: (BuildContext context, index) {
                final info = _filteredPhoneBookStudent?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
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
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    info?.urlImage.mobile ?? '',
                                  ),
                                ),
                                shape: BoxShape.circle,
                                color: AppColors.white,
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    info?.fullName ?? '',
                                    style: AppTextStyles.normal14(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    info?.userKey.toString() ?? '',
                                    style: AppTextStyles.normal12(),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            if (widget.onStudentTap != null) {
                              widget.onStudentTap!(
                                widget.phoneBookStudent![index],
                              );
                            } else {
                              return;
                            }
                          },
                          child: SvgPicture.asset(Assets.icons.send),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
    }

    Widget tabParent() {
      return _filteredPhoneBookTeacher != null &&
              _filteredPhoneBookTeacher!.isEmpty
          ? Container()
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _filteredPhoneBookTeacher?.length,
              itemBuilder: (BuildContext context, index) {
                final info = _filteredPhoneBookTeacher?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      info?.urlImage.mobile ?? '',
                                    ),
                                  ),
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                  border: Border.all(
                                    color: AppColors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        info?.parentName ?? '',
                                        style: AppTextStyles.normal14(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Text(
                                          'Cha mẹ học sinh: ${info?.fullName.toString()}',
                                          style: AppTextStyles.normal12(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        info?.phoneNumber ?? '',
                                        style: AppTextStyles.semiBold12(
                                          color: AppColors.secondary,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (widget.onParentTap != null) {
                              widget.onParentTap!(
                                widget.phoneBookTeacher![index],
                              );
                            } else {
                              return;
                            }
                          },
                          child: SvgPicture.asset(Assets.icons.send),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
    }

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: (widget.index == 0) ? tabStudent() : tabParent(),
          ),
        ),
      ],
    );
  }
}
