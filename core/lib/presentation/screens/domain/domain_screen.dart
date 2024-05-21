import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../resources/assets.gen.dart';
import '../../../resources/resources.dart';
import 'domain_saver.dart';

class CDomainScreen extends StatefulWidget {
  const CDomainScreen({
    super.key,
    this.hintText,
    this.contactMessage,
    this.onDomainSaved,
  });

  static const routeName = '/domain';

  final void Function(bool isSaved, String domain)? onDomainSaved;

  final String? hintText;
  final String? contactMessage;

  @override
  State<CDomainScreen> createState() => _CDomainScreenState();
}

class _CDomainScreenState extends State<CDomainScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  bool isDomainEntered = false;
  bool isDomainValid = false;
  bool isDomainSaved = false;

  final _domainSaver = DomainSaver();

  String get hintText =>
      widget.hintText ?? 'Nhập đường dẫn website iPortal của đơn vị';

  String get contactMessage =>
      widget.contactMessage ??
      'Vui lòng liên hệ IT trường nếu như bạn quên đường dẫn website iPortal';

  void Function(bool isSaved, String domain)? get onDomainSaved =>
      widget.onDomainSaved;

  @override
  void initState() {
    super.initState();
    unawaited(onInitialized());
  }

  Future<void> onInitialized() async {
    final domain = await _domainSaver.getDomain();

    _textFieldController.text = domain;

    if (domain.isNotEmpty) {
      isDomainEntered = true;
      isDomainValid = true;
      isDomainSaved = true;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Assets.images.image4.provider(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 6,
                  bottom: 24,
                  left: 14,
                  right: 14,
                ),
                height: screenHeight / 2.3,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: InkWell(
                            onTap: () {
                              // TODO: remove this one before release
                              setState(() {
                                _textFieldController.text =
                                    'test-iportal.nhg.vn';
                                isDomainEntered = true;
                              });
                            },
                            child: Text(
                              'Nhập đường dẫn',
                              style: AppTextStyles.normal16(
                                fontWeight: FontWeight.w700,
                                color: AppColors.brand600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 18,
                            left: 10,
                            right: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.gray300)),
                            child: TextField(
                              controller: _textFieldController,
                              onChanged: (value) {
                                isDomainEntered = value.isNotEmpty;
                                setState(() {});
                              },
                              maxLines: 1,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8),
                                filled: true,
                                fillColor: AppColors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: AppColors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: AppColors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintStyle: AppTextStyles.normal14(
                                  color: AppColors.gray79,
                                ),
                                hintText: hintText,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 4, 10, 0),
                          child: Text(contactMessage,
                              style: AppTextStyles.normal12()),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: GestureDetector(
                              onTap: () async {
                                if (isDomainEntered) {
                                  try {
                                    isDomainSaved =
                                        await _domainSaver.saveDomain(
                                      domain: _textFieldController.text,
                                    );

                                    setState(() {});

                                    if (isDomainSaved) {
                                      onDomainSaved?.call(
                                        isDomainSaved,
                                        _textFieldController.text,
                                      );
                                    } else {
                                      await Fluttertoast.showToast(
                                          msg: 'Đường dẫn không hợp lệ',
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: AppColors.black,
                                          textColor: AppColors.white);
                                    }
                                  } catch (_) {}
                                } else {
                                  await Fluttertoast.showToast(
                                      msg: 'Hãy nhập đường dẫn website iPortal',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: AppColors.black,
                                      textColor: AppColors.white);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: AppColors.primaryRedColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16,
                                    bottom: 16,
                                  ),
                                  child: Text(
                                    'Tiếp tục',
                                    style: AppTextStyles.semiBold16(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
