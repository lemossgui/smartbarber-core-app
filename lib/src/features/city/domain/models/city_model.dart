import 'package:core/core.dart';

class CityModel implements AbstractModel {
  @override
  final int id;
  final String name;

  CityModel({
    required this.id,
    required this.name,
  });
}
