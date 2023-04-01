import 'package:core/core.dart';

class SessionMapper extends AbstractMapper<SessionModel> {
  @override
  SessionModel fromMap(Map<String, dynamic> map) {
    return SessionModel(
      token: map['token'],
    );
  }

  @override
  Map<String, dynamic> toMap(SessionModel model) {
    return <String, dynamic>{
      'token': model.token,
    };
  }
}
