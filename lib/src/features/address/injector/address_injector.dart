import 'package:core/core.dart';

class AddressInjector extends Injector {
  @override
  void dependencies() {
    /// Mapper
    put(
      AddressMapper(
        stateMapper: find(),
        cityMapper: find(),
      ),
    );
  }
}
