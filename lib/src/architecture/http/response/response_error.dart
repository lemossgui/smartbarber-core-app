class ResponseError {
  final String message;
  final String? key;

  ResponseError({
    required this.message,
    this.key,
  });

  factory ResponseError.fromMap(Map<String, dynamic> map) {
    return ResponseError(
      message: map['message'] ?? '',
      key: map['key'],
    );
  }
}
