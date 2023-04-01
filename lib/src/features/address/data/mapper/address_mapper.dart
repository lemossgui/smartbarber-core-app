import 'package:core/core.dart';

class AddressMapper extends AbstractMapper<AddressModel> {
  final StateSimpleMapper stateMapper;
  final CityMapper cityMapper;

  AddressMapper({
    required this.stateMapper,
    required this.cityMapper,
  });

  @override
  AddressModel fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'],
      zipCode: map['zipCode'],
      state: stateMapper.fromMap(map['state']),
      city: cityMapper.fromMap(map['city']),
      street: map['street'],
      number: map['number'],
      neighborhood: map['neighborhood'],
      complete: map['complete'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  @override
  Map<String, dynamic> toMap(AddressModel model) {
    return <String, dynamic>{
      'id': model.id,
      'zipCode': model.zipCode,
      'state': stateMapper.toMap(model.state),
      'city': cityMapper.toMap(model.city),
      'street': model.street,
      'number': model.number,
      'neighborhood': model.neighborhood,
      'complete': model.complete,
      'latitude': model.latitude,
      'longitude': model.longitude,
    };
  }
}
