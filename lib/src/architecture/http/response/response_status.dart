class ResponseStatus {
  final int code;
  final String message;

  ResponseStatus({
    required this.code,
    required this.message,
  });

  factory ResponseStatus.fromMap(Map<String, dynamic> map) {
    return ResponseStatus(
      code: map['code']?.toInt() ?? 0,
      message: map['message'] ?? '',
    );
  }
}
