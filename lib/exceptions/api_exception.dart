class ApiException implements Exception {
  ApiException({
    this.message = 'Something went wrong while getting data',
  });
  final String message;
}
