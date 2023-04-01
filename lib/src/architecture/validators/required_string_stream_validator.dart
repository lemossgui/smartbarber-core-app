import 'dart:async';

mixin RequiredStringStreamValidator {
  StreamTransformer<String?, String?> requiredStringStreamValidator({
    String? message,
  }) {
    return StreamTransformer.fromHandlers(
      handleData: (input, sink) {
        if (input != null && input.isNotEmpty) {
          sink.add(input);
        } else {
          sink.addError(message ?? 'Campo Obrigatório');
        }
      },
    );
  }
}
