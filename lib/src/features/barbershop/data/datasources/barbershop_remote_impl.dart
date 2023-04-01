import 'package:core/core.dart';

class BarbershopRemoteImpl extends ConnectorAuth implements BarbershopStore {
  final BarbershopMapper mapper;

  BarbershopRemoteImpl({
    required this.mapper,
  });

  @override
  Future<BarbershopModel> findById(int id) async {
    final endpoint = '/api/v1/barbershop/$id';
    final responseRaw = await get(endpoint);
    final data = getResponseData(responseRaw);
    return mapper.fromMap(data);
  }
}
