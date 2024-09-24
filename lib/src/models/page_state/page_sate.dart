enum AsyncOperationType {
  fetch,
  upload,
}

class ComplexState {
  final bool? isFetching;
  final bool? isUploading;
  final String? error;
  final dynamic data;
  final AsyncOperationType? operationType;

  ComplexState({
    this.isUploading = false,
    this.isFetching = false,
    this.error,
    this.data,
    this.operationType,
  });

  ComplexState copyWith({
    bool? isLoading,
    String? error,
    dynamic data,
    AsyncOperationType? operationType,
  }) {
    return ComplexState(
      isFetching: isFetching ?? isFetching,
      isUploading: isUploading ?? isUploading,
      error: error ?? this.error,
      data: data ?? this.data,
      operationType: operationType ?? this.operationType,
    );
  }

  // Initial state
  static ComplexState initial() => ComplexState();
}
