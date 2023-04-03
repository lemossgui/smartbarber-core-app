import 'package:core/core.dart';

class Failure {
  final String message;
  final String? key;

  Failure({
    required this.message,
    this.key,
  });

  factory Failure.fromRemote(RemoteException exception) {
    return Failure(message: exception.message, key: exception.key);
  }

  factory Failure.fromStorage(StorageException exception) {
    return Failure(message: exception.message, key: null);
  }
}
