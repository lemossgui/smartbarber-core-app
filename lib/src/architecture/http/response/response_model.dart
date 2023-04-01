import 'package:core/core.dart';

class ResponseModel<T> {
  final T? data;
  final String? message;
  final ResponseStatus status;
  final List<String>? errors;
  final int? totalPages;
  final int? totalElements;

  ResponseModel({
    this.data,
    this.message,
    required this.status,
    this.errors,
    this.totalPages,
    this.totalElements,
  });

  bool get isSuccess => status.message == 'success';
}
