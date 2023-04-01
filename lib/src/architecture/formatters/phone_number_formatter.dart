import 'dart:async';
import 'package:string_mask/string_mask.dart';

mixin PhoneNumberFormater {
  static const String phoneNumberMask = "(##) #####-####";

  StreamTransformer<String?, String?> formatFromPhoneNumber({
    bool requiredField = false,
    String? message,
  }) {
    return StreamTransformer.fromHandlers(
      handleData: (input, sink) {
        String format(String phoneNumber) {
          if (phoneNumber.trim().isNotEmpty) {
            final formatter = StringMask(phoneNumberMask);
            final isOnlyNumber = int.tryParse(phoneNumber.trim()) != null;
            if (isOnlyNumber && phoneNumber.trim().length == 15) {
              return formatter.apply(phoneNumber);
            }
          }

          return phoneNumber;
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
