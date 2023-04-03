import 'package:core/core.dart';
import 'package:core/src/features/barbershop/injector/barbershop_injector.dart';

class CoreInjector extends Injector {
  @override
  void dependencies() {
    SessionInjector().dependencies();
    StateInjetor().dependencies();
    CityInjector().dependencies();
    AddressInjector().dependencies();
    BarbershopInjector().dependencies();
    RegistrationInjector().dependencies();
  }
}
