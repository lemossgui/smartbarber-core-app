import 'package:core/core.dart';
import 'package:get/get.dart';
import 'dart:developer';

class ConnectorAuth extends BaseConnector with NavigatorMixin {
  @override
  void onInit() async {
    httpClient.addRequestModifier<void>((request) async {
      final sessionRepository = Get.find<SessionRepository>();
      final result = await sessionRepository.get();

      result.map((session) {
        if (session != null) {
          var headers = {'Authorization': "Bearer ${session.token}"};
          request.headers.addAll(headers);
          log('[${request.method}] => [${request.url}]');
          return request;
        }
      });

      return request;
    });

    super.onInit();
  }

  @override
  void handleForbidden() async {
    final sessionRepository = Get.find<SessionRepository>();
    await sessionRepository.clear();
    offAllNamed('/');
  }
}
