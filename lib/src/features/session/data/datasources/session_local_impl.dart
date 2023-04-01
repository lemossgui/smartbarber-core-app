import 'package:core/core.dart';

class SessionLocalImpl extends LocalStorage implements SessionStore {
  final SessionMapper mapper;

  SessionLocalImpl({
    required this.mapper,
  });

  final String _key = 'barbershop-session';

  @override
  Future<void> save(SessionModel model) async {
    final json = mapper.toJson(model);
    return setString(json, _key);
  }

  @override
  Future<SessionModel?> get() async {
    final json = await getString(_key);
    return mapper.fromJsonNullable(json);
  }

  @override
  Future<void> clear() async {
    return remove(_key);
  }
}
