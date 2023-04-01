import 'package:core/core.dart';

class StateSimpleModel implements AbstractModel {
  @override
  final int id;
  final String name;
  final String uf;

  StateSimpleModel({
    required this.id,
    required this.name,
    required this.uf,
  });
}
