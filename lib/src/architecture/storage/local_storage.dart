import 'package:core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<SharedPreferences> get _box async {
    return SharedPreferences.getInstance();
  }

  Future<void> setString(String value, String key) async {
    final isSuccess = await _box.then((sp) => sp.setString(key, value));
    if (isSuccess) return;
    throw StorageException(message: 'Falha ao adicionar dados [$key]');
  }

  Future<String?> getString(String key) async {
    return _box.then((sp) => sp.getString(key));
  }

  Future<void> remove(String key) async {
    final isSuccess = await _box.then((sp) => sp.remove(key));
    if (isSuccess) return;
    throw StorageException(message: 'Falha ao remover dados [$key]');
  }
}
