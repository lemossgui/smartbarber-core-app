import 'package:core/core.dart';

class StateInjetor extends Injector {
  @override
  void dependencies() {
    /// Mapper
    put(
      StateSimpleMapper(),
    );
  }
}
