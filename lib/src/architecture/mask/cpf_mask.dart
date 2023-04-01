import 'package:core/core.dart';

class CpfMask extends DelegateMask {
  CpfMask() : super(mask: CpfFormater.cpfMask);
}
