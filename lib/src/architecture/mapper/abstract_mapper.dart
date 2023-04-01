import 'dart:convert';

abstract class AbstractMapper<T> {
  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T model);

  T? fromMapNullable(Map<String, dynamic>? map) {
    if (map == null) return null;
    return fromMap(map);
  }

  Map<String, dynamic>? mapToNullable(T? model) {
    if (model == null) return null;
    return toMap(model);
  }

  List<T> listFromMap(List<dynamic>? list) {
    if (list == null) return <T>[];
    return list.map((dynamic v) {
      return fromMap(v as Map<String, dynamic>);
    }).toList();
  }

  List<Map<String, dynamic>> listToMap(List<T>? list) {
    if (list == null) return List.empty();
    return list.map(toMap).toList();
  }

  String toJson(T model) => json.encode(toMap(model));
  T fromJson(String source) => fromMap(json.decode(source));

  T? fromJsonNullable(String? source) {
    if (source == null) return null;
    return fromMap(json.decode(source));
  }
}
