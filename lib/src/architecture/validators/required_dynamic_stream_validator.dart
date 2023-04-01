import 'dart:async';

mixin RequiredDynamicStreamValidator {
  StreamTransformer<T?, T?> requiredDynamicStreamValidator<T>({
    String? message,
  }) {
    return StreamTransformer.fromHandlers(
      handleData: (input, sink) {
        if (input != null) {
          sink.add(input);
        } else {
          sink.addError(message ?? 'Campo Obrigatório');
        }
      },
    );
  }
}
