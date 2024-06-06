part of 'leave_bloc.dart';

enum LeaveTeacherStatus {
  init,
  loading,
  success,
  error,
  loadMore,
  approveSuccess,
  loadMoreSuccess,
  approveAllSuccess,
}

class LeaveState extends Equatable {
  const LeaveState({
    required this.leaveData,
    required this.leaveApproved,
    required this.datePicked,
    this.message,
    this.leaveStatus = LeaveTeacherStatus.init,
    this.status = LeaveStatusValue.pending,
  });

  final List<LeaveTeacher> leaveData;
  final List<LeaveTeacher> leaveApproved;
  final LeaveStatusValue status;
  final DateTime datePicked;

  final String? message;
  final LeaveTeacherStatus leaveStatus;

  @override
  List<Object?> get props => [
        leaveData,
        leaveApproved,
        leaveStatus,
        status,
        datePicked,
        message,
      ];

  LeaveState copyWith({
    List<LeaveTeacher>? leaveData,
    List<LeaveTeacher>? leaveApproved,
    LeaveTeacherStatus? leaveStatus,
    LeaveStatusValue? status,
    DateTime? datePicked,
    String? message,
  }) {
    return LeaveState(
      message: message ?? this.message,
      leaveApproved: leaveApproved ?? this.leaveApproved,
      leaveData: leaveData ?? this.leaveData,
      datePicked: datePicked ?? this.datePicked,
      status: status ?? this.status,
      leaveStatus: leaveStatus ?? this.leaveStatus,
    );
  }
}
