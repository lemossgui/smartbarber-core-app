abstract class AuthenticationStore<T> {
  Future<String> authenticate(T model);
}
