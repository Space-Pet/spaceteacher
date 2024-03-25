part of '../base.dart';

enum BlocStatusState { initial, loading, success, failure }

extension BlocStatusStateExt on BlocStatusState? {
  bool get isLoading {
    return this == BlocStatusState.loading;
  }

  bool get isSuccess {
    return this == BlocStatusState.success;
  }
}
