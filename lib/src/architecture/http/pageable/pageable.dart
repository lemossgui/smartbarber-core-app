import 'dart:convert';

class Pageable {
  final int page;
  final int size;

  Pageable({
    required this.page,
    required this.size,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'page': page});
    result.addAll({'size': size});

    return result;
  }

  factory Pageable.fromMap(Map<String, dynamic> map) {
    return Pageable(
      page: map['page']?.toInt() ?? 0,
      size: map['size']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pageable.fromJson(String source) =>
      Pageable.fromMap(json.decode(source));
}
