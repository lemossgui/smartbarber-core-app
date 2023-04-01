import 'package:core/core.dart';

class PhoneNumberMask extends DelegateMask {
  PhoneNumberMask() : super(mask: PhoneNumberFormater.phoneNumberMask);
}
