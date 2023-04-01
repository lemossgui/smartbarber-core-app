import 'dart:developer';
import 'package:core/core.dart';
import 'package:get/get.dart';

abstract class BaseConnector extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://localhost:8082';
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 30);

    httpClient.addRequestModifier<void>((request) async {
      log('[${request.method}] => [${request.url}]');
      return request;
    });

    super.onInit();
  }

  T getResponseData<T>(Response responseRaw) {
    final response = mapResponseModel(responseRaw.body);

    if (responseRaw.status.isForbidden) {
      handleForbidden();
      throw RemoteException(
        message: response?.message ?? 'Usuário deslogado',
      );
    } else if (response == null || !response.isSuccess) {
      throw RemoteException(
        message: response?.message ?? 'Problema de comunicação com o servidor',
      );
    }

    return response.data;
  }

  ResponseModel<T>? mapResponseModel<T>(Map<String, dynamic>? map) {
    if (map == null) return null;

    return ResponseModel<T>(
      data: map['data'] as T,
      message: map['message'] as String?,
      status: ResponseStatus.fromMap(map['status']),
      errors: List.from(map['errors'] ?? List.empty()),
      totalPages: map['totalPages'] as int?,
      totalElements: map['totalElements'] as int?,
    );
  }

  void handleForbidden() {}
}
