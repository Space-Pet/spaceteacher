part of 'leave_bloc.dart';

enum LeaveStatus { init, success, error, loadMore, loadMoreSuccess }

class LeaveState extends Equatable {
  const LeaveState(
      {this.leaveData,
      required this.user,
      this.message,
      this.leaveStatus = LeaveStatus.init});
  final List<LeaveData>? leaveData;
  final LeaveStatus leaveStatus;
  final ProfileInfo user;
  final String? message;

  @override
  List<Object?> get props => [leaveData, leaveStatus];

  LeaveState copyWith({
    List<LeaveData>? leaveData,
    LeaveStatus? leaveStatus,
    ProfileInfo? user,
    String? message,
  }) {
    return LeaveState(
        message: message ?? this.message,
        user: user ?? this.user,
        leaveData: leaveData ?? this.leaveData,
        leaveStatus: leaveStatus ?? this.leaveStatus);
  }
}
