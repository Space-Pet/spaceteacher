part of 'leave_bloc.dart';

abstract class LeaveEvent extends Equatable{
  const LeaveEvent();
  @override 
  List<Object> get props => [];
}
class GetLeaves extends LeaveEvent{}
class CurrentUserUpdated extends LeaveEvent {
  CurrentUserUpdated({required this.user});
  final ProfileInfo user;
}