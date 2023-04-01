import 'package:core/core.dart';

class CityInjector extends Injector {
  @override
  void dependencies() {
    /// Mapper
    put(
      CityMapper(),
    );
  }
}
