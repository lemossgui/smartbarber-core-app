import 'dart:async';
import 'package:string_mask/string_mask.dart';

mixin CpfFormater {
  static const String cpfMask = "###.###.###-##";

  StreamTransformer<String?, String?> formatFromCpf({
    bool requiredField = false,
    String? message,
  }) {
    return StreamTransformer.fromHandlers(
      handleData: (input, sink) {
        String format(String cpf) {
          if (cpf.trim().isNotEmpty) {
            final formatter = StringMask(cpfMask);
            final isOnlyNumber = int.tryParse(cpf.trim()) != null;
            if (isOnlyNumber && cpf.trim().length == 11) {
              return formatter.apply(cpf);
            }
          }
          return cpf;
        }

        if (input != null) {
          sink.add(format(input));
        } else if (requiredField) {
          sink.addError(message ?? 'Campo Obrigatório');
        }
      },
    );
  }
}
