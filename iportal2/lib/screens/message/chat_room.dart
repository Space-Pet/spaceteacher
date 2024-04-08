import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/message/models/message.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, required this.messageChatRoom});
  final MessageChatRoom messageChatRoom;

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;
  File? _pickedFile;
  List<Messages> pinnedMessages = [];

  void _pickImage() async {
    final XFile? pickedImageFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
    }
  }

  void _pickAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _pickedFile = File(result.files.single.path!);
      });
    } else {}
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gửi ảnh'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('Gửi tệp đính kèm'),
              onTap: () {
                Navigator.of(context).pop();
                _pickAttachment();
              },
            ),
          ],
        );
      },
    );
  }

  void _showMessageOptions(Messages message) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.push_pin),
              title: const Text('Ghim tin nhắn'),
              onTap: () {
                Navigator.of(context).pop();
                _pinMessage(message);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Xoá tin nhắn'),
              onTap: () {
                Navigator.of(context).pop();
                _deleteMessage(message);
              },
            ),
          ],
        );
      },
    );
  }

  void _pinMessage(Messages message) {
    setState(() {
      pinnedMessages.insert(0, message);
    });
  }

  void _deleteMessage(Messages message) {
    // Implement delete message functionality here
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            ScreenAppBar(
              title: widget.messageChatRoom.name,
              canGoback: true,
              onBack: () {
                Navigator.of(context).pop();
              },
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...pinnedMessages.map((message) {
                              return _buildMessageWidget(message);
                            }),
                            ...widget.messageChatRoom.messages
                                .where((message) =>
                                    !pinnedMessages.contains(message))
                                .map((message) {
                              return _buildMessageWidget(message);
                            }),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      color: AppColors.primarySurface,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                onTap: _showOptions,
                                child:
                                    SvgPicture.asset(Assets.icons.fileMessage),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Nhập tin nhắn',
                                  filled: true,
                                  fillColor: AppColors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                onTap: () {},
                                child:
                                    SvgPicture.asset(Assets.icons.sendMessage),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageWidget(Messages message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: message.id == widget.messageChatRoom.idUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (message.id != widget.messageChatRoom.idUser)
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(widget.messageChatRoom.image),
            ),
          GestureDetector(
            onLongPress: () {
              _showMessageOptions(message);
            },
            child: Column(
              crossAxisAlignment: message.id == widget.messageChatRoom.idUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    message.id != widget.messageChatRoom.idUser
                        ? widget.messageChatRoom.name
                        : '',
                    style: AppTextStyles.normal14(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: message.id == widget.messageChatRoom.idUser
                      ? const EdgeInsets.all(8.0)
                      : const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: message.id == widget.messageChatRoom.idUser
                        ? Colors.blue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: message.file != null
                      ? Image.file(
                          message.file!,
                          width: 150,
                        )
                      : Text(
                          message.message ?? '',
                          style: TextStyle(
                            color: message.id == widget.messageChatRoom.idUser
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
