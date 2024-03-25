enum ButtonStatus { enable, loading, disabled }

extension ButtonStatusX on ButtonStatus {
  bool get isEnable => this == ButtonStatus.enable;
  bool get isDisabled => this == ButtonStatus.disabled;
  bool get isLoading => this == ButtonStatus.loading;
}