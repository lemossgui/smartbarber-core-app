import 'package:core/core.dart';

abstract class SessionStore {
  Future<void> save(SessionModel model);
  Future<SessionModel?> get();
  Future<void> clear();
}
