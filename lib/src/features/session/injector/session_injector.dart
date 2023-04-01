import 'package:core/core.dart';

class SessionInjector extends Injector {
  @override
  void dependencies() {
    put(
      SessionMapper(),
    );

    put<SessionStore>(
      SessionLocalImpl(
        mapper: find(),
      ),
    );

    put<SessionRepository>(
      SessionRepositoryImpl(
        local: find(),
      ),
    );
  }
}
