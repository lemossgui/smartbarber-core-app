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
    final error = response?.error;

    if (responseRaw.status.isForbidden) {
      handleForbidden();
      throw RemoteException(
        message: error?.message ?? 'Usuário deslogado',
        key: error?.key,
      );
    } else if (response == null || !response.isSuccess) {
      throw RemoteException(
        message: error?.message ?? 'Problema de comunicação com o servidor',
        key: error?.key,
      );
    }

    return response.data;
  }

  ResponseModel<T>? mapResponseModel<T>(Map<String, dynamic>? map) {
    if (map == null) return null;
    try {
      final errorMap = map['error'];
      return ResponseModel<T>(
        data: map['data'] as T,
        error: errorMap != null ? ResponseError.fromMap(errorMap) : null,
        status: ResponseStatus.fromMap(map['status']),
        errors: List.from(map['errors'] ?? List.empty()),
        totalPages: map['totalPages'] as int?,
        totalElements: map['totalElements'] as int?,
      );
    } catch (e) {
      throw RemoteException(message: 'Falha na comunicação com o servidor');
    }
  }

  void handleForbidden() {}
}
