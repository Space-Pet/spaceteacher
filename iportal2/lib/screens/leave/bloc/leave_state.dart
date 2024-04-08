part of 'leave_bloc.dart';

enum LeaveStatus { init, success, error }

class LeaveState extends Equatable {
  const LeaveState(
      {this.leaveData,
      required this.user,
      this.leaveStatus = LeaveStatus.init});
  final List<LeaveData>? leaveData;
  final LeaveStatus leaveStatus;
  final ProfileInfo user;

  @override
  List<Object?> get props => [leaveData, leaveStatus];

  LeaveState copyWith({
    List<LeaveData>? leaveData,
    LeaveStatus? leaveStatus,
    ProfileInfo? user,
  }) {
    return LeaveState(
        user: user ?? this.user,
        leaveData: leaveData ?? this.leaveData,
        leaveStatus: leaveStatus ?? this.leaveStatus);
  }
}
