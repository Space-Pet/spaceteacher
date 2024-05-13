part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class GetConversation extends ConversationEvent {
  final int userId;
  final int schoolId;
  final int classId;
  final String schoolBrand;

  const GetConversation({
    required this.userId,
    this.schoolId = 0,
    required this.classId,
    this.schoolBrand = '',
  });

  @override
  List<Object> get props => [userId, schoolId, classId, schoolBrand];
}
