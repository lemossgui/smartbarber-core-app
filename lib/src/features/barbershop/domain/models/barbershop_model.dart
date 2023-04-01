import 'package:core/core.dart';

class BarbershopModel implements AbstractModel {
  @override
  final int id;
  final String name;
  final String phone;
  final AddressModel address;
  final String? distance;

  BarbershopModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    this.distance,
  });
}
