import 'package:core/core.dart';

class BarbershopMapper extends AbstractMapper<BarbershopModel> {
  final AddressMapper addressMapper;

  BarbershopMapper({
    required this.addressMapper,
  });

  @override
  BarbershopModel fromMap(Map<String, dynamic> map) {
    return BarbershopModel(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      address: addressMapper.fromMap(map['address']),
      distance: map['distance'],
    );
  }

  @override
  Map<String, dynamic> toMap(BarbershopModel model) {
    return <String, dynamic>{
      'id': model.id,
      'name': model.name,
      'phone': model.phone,
      'address': addressMapper.toMap(model.address),
      'distance': model.distance,
    };
  }
}
