import 'package:core/core.dart';

class BarbershopInjector extends Injector {
  @override
  void dependencies() {
    /// Mapper
    put(
      BarbershopMapper(
        addressMapper: find(),
      ),
    );

    /// Datasources
    put<BarbershopStore>(
      BarbershopRemoteImpl(
        mapper: find(),
      ),
    );

    /// Repositories
    put<BarbershopRepository>(
      BarbershopRepositoryImpl(
        remote: find(),
      ),
    );
  }
}
