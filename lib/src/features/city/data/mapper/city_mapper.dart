import 'package:core/core.dart';

class CityMapper extends AbstractMapper<CityModel> {
  @override
  CityModel fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'],
      name: map['name'],
    );
  }

  @override
  Map<String, dynamic> toMap(CityModel model) {
    return <String, dynamic>{
      'id': model.id,
      'name': model.name,
    };
  }
}
