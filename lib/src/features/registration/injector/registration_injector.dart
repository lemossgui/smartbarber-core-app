import 'package:core/core.dart';

class RegistrationInjector extends Injector {
  @override
  void dependencies() {
    /// Mapper
    put(
      EmailVerificationCheckMapper(),
    );

    /// Datasources
    put<EmailVerificationStore>(
      EmailVerificationRemoteImpl(
        mapper: find(),
      ),
    );

    /// Repositories
    put<EmailVerificationRepository>(
      EmailVerificationRepositoryImpl(
        remote: find(),
      ),
    );
  }
}
