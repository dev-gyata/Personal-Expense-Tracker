enum ApiStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == ApiStatus.initial;
  bool get isLoading => this == ApiStatus.loading;
  bool get isSuccess => this == ApiStatus.success;
  bool get isFailure => this == ApiStatus.failure;
}
