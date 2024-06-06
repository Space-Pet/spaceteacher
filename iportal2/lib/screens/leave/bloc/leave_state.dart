part of 'leave_bloc.dart';

enum LeaveStatusEnum { init, success, error, loadMore, loadMoreSuccess }

class LeaveState extends Equatable {
  const LeaveState(
      {this.leaveData,
      // required this.user,
      this.message,
      this.leaveStatus = LeaveStatusEnum.init});
  final List<LeaveData>? leaveData;
  final LeaveStatusEnum leaveStatus;
  // final ProfileInfo user;
  final String? message;

  @override
  List<Object?> get props => [leaveData, leaveStatus];

  LeaveState copyWith({
    List<LeaveData>? leaveData,
    LeaveStatusEnum? leaveStatus,
    // ProfileInfo? user,
    String? message,
  }) {
    return LeaveState(
        message: message ?? this.message,
        // user: user ?? this.user,
        leaveData: leaveData ?? this.leaveData,
        leaveStatus: leaveStatus ?? this.leaveStatus);
  }
}
