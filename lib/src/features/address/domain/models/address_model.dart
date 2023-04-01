import 'package:core/core.dart';

class AddressModel implements AbstractModel {
  @override
  final int id;
  final String zipCode;
  final StateSimpleModel state;
  final CityModel city;
  final String street;
  final int number;
  final String neighborhood;
  final String? description;
  final String complete;
  final double latitude;
  final double longitude;

  AddressModel({
    required this.id,
    required this.zipCode,
    required this.state,
    required this.city,
    required this.street,
    required this.number,
    required this.neighborhood,
    this.description,
    required this.complete,
    required this.latitude,
    required this.longitude,
  });
}
