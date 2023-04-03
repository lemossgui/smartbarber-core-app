import 'package:core/core.dart';

abstract class AccessStore {
  Future<String> authenticate(AccessModel model);
}
