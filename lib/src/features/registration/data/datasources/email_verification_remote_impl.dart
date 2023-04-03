import 'package:core/core.dart';

class EmailVerificationRemoteImpl extends ConnectorAuth
    implements EmailVerificationStore {
  final EmailVerificationCheckMapper mapper;

  static const _endpoint = '/api/v1/public/email-verification';

  EmailVerificationRemoteImpl({
    required this.mapper,
  });

  @override
  Future<EmailVerificationCheckModel> check({
    required String email,
    required String userType,
  }) async {
    const path = '$_endpoint/check';
    final query = {
      'email': email,
      'userType': userType,
    };
    final responseRaw = await get(path, query: query);
    final data = getResponseData(responseRaw);
    return mapper.fromMap(data);
  }

  @override
  Future<void> resend(String email) async {
    const path = '$_endpoint/resend';
    final body = {
      'email': email,
    };
    final responseRaw = await patch(path, body);
    return getResponseData(responseRaw);
  }

  @override
  Future<void> validate({
    required String email,
    required String verificationCode,
  }) async {
    const path = '$_endpoint/validate';
    final query = {
      'email': email,
      'verificationCode': verificationCode,
    };
    final responseRaw = await get(path, query: query);
    return getResponseData(responseRaw);
  }
}
