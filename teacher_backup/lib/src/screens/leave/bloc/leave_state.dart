part of 'leave_bloc.dart';

enum LeaveStatus { init, loading, success, error, loadMore, loadMoreSuccess }

class LeaveState extends Equatable {
  const LeaveState(
      {this.leaveData,
      this.user,
      this.message,
      required this.selectedDate,
      this.leaveStatus = LeaveStatus.init});
  final List<LeaveModel>? leaveData;
  final LeaveStatus leaveStatus;
  final UserInfo? user;
  final String? message;
  final DateTime selectedDate;

  @override
  List<Object?> get props => [leaveData, leaveStatus, selectedDate];

  LeaveState copyWith({
    List<LeaveModel>? leaveData,
    LeaveStatus? leaveStatus,
    UserInfo? user,
    String? message,
    DateTime? selectedDate,
  }) {
    return LeaveState(
        selectedDate: selectedDate ?? this.selectedDate,
        message: message ?? this.message,
        user: user ?? this.user,
        leaveData: leaveData ?? this.leaveData,
        leaveStatus: leaveStatus ?? this.leaveStatus);
  }
}
