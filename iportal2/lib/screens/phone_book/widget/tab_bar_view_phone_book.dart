import 'package:core/data/models/models.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iportal2/components/textfield/input_text.dart';

class TabBarViewPhoneBook extends StatefulWidget {
  const TabBarViewPhoneBook({
    super.key,
    this.phoneBookStudent,
    required this.title,
    this.phoneBookTeacher,
  });

  final List<PhoneBookStudent>? phoneBookStudent;
  final List<PhoneBookTeacher>? phoneBookTeacher;
  final String title;

  @override
  State<TabBarViewPhoneBook> createState() => _TabBarViewPhoneBookState();
}

class _TabBarViewPhoneBookState extends State<TabBarViewPhoneBook> {
  late List<PhoneBookStudent>? _filteredPhoneBookStudent;
  late List<PhoneBookTeacher>? _filteredPhoneBookTeacher;
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
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(Assets.icons.phoneBook),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  '${widget.title} (${_filteredPhoneBookTeacher == null ? widget.phoneBookStudent?.length : widget.phoneBookStudent?.length})',
                  style: AppTextStyles.normal16(
                    color: AppColors.brand600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TitleAndInputText(
              obscureText: false,
              hintText: 'Tìm kiếm',
              onChanged: (value) {
                setState(() {
                  _searchKeyword = value;
                });
              },
              prefixIcon: Assets.images.search.image(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _filteredPhoneBookStudent?.length ??
                    _filteredPhoneBookTeacher?.length,
                itemBuilder: (BuildContext context, index) {
                  final info = _filteredPhoneBookStudent?[index];
                  final infoTeacher = _filteredPhoneBookTeacher?[index];
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
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      info?.urlImage.mobile ??
                                          infoTeacher!.urlImageTeacher.mobile,
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
                                      info?.fullName ??
                                          infoTeacher?.fullName ??
                                          '',
                                      style: AppTextStyles.normal14(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      info?.pupilId.toString() ??
                                          infoTeacher?.teacherId.toString() ??
                                          '',
                                      style: AppTextStyles.normal12(),
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
          ),
        ],
      ),
    );
  }
}
