import 'package:core/core.dart';

class AccessMapper extends AbstractMapper<AccessModel> {
  @override
  AccessModel fromMap(Map<String, dynamic> map) {
    return AccessModel(
      email: map['email'],
      password: map['password'],
    );
  }

  @override
  Map<String, dynamic> toMap(AccessModel model) {
    return <String, dynamic>{
      'email': model.email,
      'password': model.password,
    };
  }
}
