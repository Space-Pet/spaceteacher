import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/message/bloc/message_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ConversationMessage extends StatefulWidget {
  const ConversationMessage({
    super.key,
    this.fullName,
    this.urlImage,
    this.showTime = false,
    required this.messageDetail,
    required this.isSamePeople,
  });

  final ConservationDetail messageDetail;
  final bool isSamePeople;
  final String? fullName;
  final String? urlImage;
  final bool showTime;

  @override
  State<ConversationMessage> createState() => _ConversationMessageState();
}

class _ConversationMessageState extends State<ConversationMessage> {
  void showMessageOptions() {
    final message = widget.messageDetail;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 4.0),
                child: Text(
                  'Đã gửi lúc ${DateFormat('HH:mm').format(DateTime.parse(message.createdAt ?? ''))} ngày ${DateFormat('dd/MM/yyyy').format(DateTime.parse(message.createdAt ?? ''))}',
                ),
              ),
              ListTile(
                leading: const Icon(Icons.push_pin),
                title: const Text('Ghim tin nhắn'),
                onTap: () {
                  context.read<MessageBloc>().add(PinMessage(
                        idMessage: message.id ?? 0,
                        conservationId: message.conversationId.toString(),
                      ));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Xoá tin nhắn'),
                onTap: () async {
                  context.read<MessageBloc>().add(DeleteMessage(
                        content: message.content ?? "",
                        idMessage: message.id ?? 0,
                        recipient: message.recipient.toString(),
                      ));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('Copy tin nhắn'),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: message.content ?? ''));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final profileInfo = state.user;
        final isMe = widget.messageDetail.userId == profileInfo.user_id;
        final isShowUserInfo = !isMe && !widget.isSamePeople;
        final listImage = widget.messageDetail.attachments ?? [];
        final w = SizeUtils.width;
        final isTypeImage =
            listImage.isNotEmpty && listImage[0].fileType!.contains('image');

        final listImageW = List.generate(
          listImage.length,
          (index) {
            final file = listImage[index];
            final url = file.url;
            final nameFile = url!.substring(url.lastIndexOf('/') + 1);

            if (file.fileType!.contains('image')) {
              return InkWell(
                onTap: () {
                  CustomImageWidgetProvider customImageProvider =
                      CustomImageWidgetProvider(
                    imageUrls: [url].toList(),
                    initialIndex: index,
                  );
                  showImageViewerPager(context, customImageProvider);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  height: w / 2,
                  width: w / 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/no_image.jpg',
                      image: url,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/no-image-available.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return InkWell(
                onTap: () {
                  launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.inAppBrowserView,
                  );
                },
                child: SizedBox(
                    width: w * 0.7,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.file_present_rounded,
                          color: AppColors.white,
                          size: 32,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            nameFile,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.normal14(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            }
          },
        );

        DateFormat formatDate = DateFormat("EEEE, dd/MM HH:mm", 'vi_VN');
        final date = formatDate
            .format(DateTime.parse(widget.messageDetail.createdAt ?? ''));

        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              isShowUserInfo
                  ? CircleAvaImage(
                      urlAva: widget.urlImage ??
                          widget.messageDetail.avatarUrl ??
                          '')
                  : const SizedBox(width: 40),
              Expanded(
                child: GestureDetector(
                  onLongPress: () {
                    showMessageOptions();
                  },
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (isShowUserInfo)
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, bottom: 2),
                          child: Text(
                            widget.fullName ?? '',
                            style: AppTextStyles.normal14(
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      if (widget.showTime)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Center(
                            child: Text(
                              date,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.normal12(),
                            ),
                          ),
                        ),
                      Container(
                        margin: EdgeInsets.only(right: isMe ? 4 : 0),
                        padding: isTypeImage
                            ? const EdgeInsets.all(0)
                            : const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: isTypeImage
                              ? Colors.transparent
                              : isMe
                                  ? AppColors.blue600
                                  : AppColors.gray100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: listImage.isNotEmpty
                            ? Column(children: listImageW)
                            : Container(
                                constraints: const BoxConstraints(
                                  minWidth: 5,
                                  maxWidth: 300,
                                ),
                                child: Text(
                                  widget.messageDetail.content ?? "",
                                  style: AppTextStyles.custom(
                                    color: isMe ? Colors.white : Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomImageWidgetProvider extends EasyImageProvider {
  @override
  final int initialIndex;
  final List<String> imageUrls;

  CustomImageWidgetProvider({required this.imageUrls, this.initialIndex = 0})
      : super();

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    return NetworkImage(imageUrls[index]);
  }

  @override
  Widget progressIndicatorWidgetBuilder(BuildContext context, int index,
      {double? value}) {
    final percent = (value ?? 0) * 100;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                    image: DecorationImage(
                      image: Assets.images.logoApp.icLauncher.provider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 60,
                  width: 60,
                ),
              ),
              const Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.brand600),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "${percent.toStringAsFixed(0)}%",
          style: AppTextStyles.semiBold20(color: AppColors.white),
        )
      ],
    );
  }

  @override
  int get imageCount => imageUrls.length;
}
