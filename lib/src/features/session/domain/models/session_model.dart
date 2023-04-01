import 'dart:convert';

class SessionModel {
  final String token;

  SessionModel({
    required this.token,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'token': token});
    return result;
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionModel.fromJson(String source) =>
      SessionModel.fromMap(json.decode(source));
}
