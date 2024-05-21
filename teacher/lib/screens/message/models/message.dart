import 'dart:io';

class MessageChatRoom {
  final String image;
  final String idUser;
  final String name;
  final String? unRead;
  final String lastMessage;
  final String lastTime;
  final List<Messages> messages;
  MessageChatRoom(
      {this.unRead,
      required this.idUser,
      required this.image,
      required this.name,
      required this.lastMessage,
      required this.lastTime,
      required this.messages});
}

class Messages {
  final String? message;
  final String id;
  final File? file;
  const Messages({this.message, required this.id, this.file});
}

final List<MessageChatRoom> chatRooms = [
  MessageChatRoom(
    idUser: "1",
    image: "assets/images/default-user.png",
    name: "Tri",
    lastMessage: "Hello there!",
    lastTime: "10:30 AM",
    unRead: '1',
    messages: [
      const Messages(id: "1", message: "How are you?"),
      const Messages(id: "123", message: "I'm fine"),
    ],
  ),
  MessageChatRoom(
    idUser: "2",
    image: "assets/images/default-user.png",
    name: "Ngoc",
    lastMessage: "I'm good, thank you!",
    lastTime: "11:45 AM",
    messages: [
      const Messages(id: "2", message: "Hi Ngoc!"),
      const Messages(id: "123", message: "I'm good, thank you!"),
    ],
  ),
  MessageChatRoom(
    idUser: "3",
    image: "assets/images/default-user.png",
    name: "Son",
    lastMessage: "What",
    lastTime: "11:45 AM",
    messages: [
      const Messages(id: "3", message: "Hey Son!"),
      const Messages(id: "123", message: "What"),
    ],
  ),
  MessageChatRoom(
    idUser: "4",
    image: "assets/images/default-user.png",
    name: "Loc",
    lastMessage: "Hi, how are you?",
    lastTime: "11:45 AM",
        unRead: '1',
    messages: [
      const Messages(id: "4", message: "Hi Loc!"),
      const Messages(id: "123", message: "I'm good, thank you!"),
    ],
  ),
  MessageChatRoom(
    idUser: "5",
    image: "assets/images/default-user.png",
    name: "Huy",
    lastMessage: "Hi, how are you?",
    lastTime: "11:45 AM",
    messages: [
      const Messages(id: "5", message: "Hi, how are you?"),
      const Messages(id: "123", message: "I'm good, thank you!"),
    ],
  ),
  MessageChatRoom(
    idUser: "6",
    image: "assets/images/default-user.png",
    name: "Vi",
    lastMessage: "Hi, how are you?",
    lastTime: "11:45 AM",
    messages: [
      const Messages(id: "6", message: "Hi, how are you?"),
      const Messages(id: "123", message: "I'm good, thank you!"),
    ],
  ),
  MessageChatRoom(
    idUser: "7",
    image: "assets/images/default-user.png",
    name: "Thai",
    lastMessage: "Hi, how are you?",
    lastTime: "11:45 AM",
    messages: [
      const Messages(id: "7", message: "Hi, how are you?"),
      const Messages(id: "123", message: "I'm good, thank you!"),
    ],
  ),
  MessageChatRoom(
    idUser: "8",
    image: "assets/images/default-user.png",
    name: "Tuan",
    lastMessage: "Hi, how are you?",
    lastTime: "11:45 AM",
    messages: [
      const Messages(id: "8", message: "Hi, how are you?"),
      const Messages(id: "123", message: "I'm good, thank you!"),
    ],
  ),
];
