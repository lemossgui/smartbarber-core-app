import 'package:core/core.dart';

class StateSimpleMapper extends AbstractMapper<StateSimpleModel> {
  @override
  StateSimpleModel fromMap(Map<String, dynamic> map) {
    return StateSimpleModel(
      id: map['id'],
      name: map['name'],
      uf: map['uf'],
    );
  }

  @override
  Map<String, dynamic> toMap(StateSimpleModel model) {
    return <String, dynamic>{
      'id': model.id,
      'name': model.name,
      'uf': model.uf,
    };
  }
}
