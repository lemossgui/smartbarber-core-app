class RemoteException implements Exception {
  final String message;
  final String? key;

  RemoteException({
    required this.message,
    this.key,
  });
}
