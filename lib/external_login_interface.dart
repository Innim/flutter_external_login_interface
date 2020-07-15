library external_login_interface;

import 'package:async/async.dart';

/// Implementation of external login for specific service.
abstract class ExternalLogin {
  /// Start log in process.
  Future<Result<ExternalLoginResult>> login();

  /// Logout from service.
  Future<void> logout();
}

/// Log in result.
///
/// Represents result data, when was no errors.
/// If user cancels log in - it's not a error,
/// just create result with [ExternalLoginResult.cancel]
/// constructor.
class ExternalLoginResult {
  final ExternalLoginData data;

  /// Log in complete successfully.
  const ExternalLoginResult.success(ExternalLoginData data)
      : assert(data != null),
        this.data = data;

  /// User cancels log in.
  const ExternalLoginResult.cancel() : this.data = null;

  /// Returns `true` if log in was canceled by user.
  bool get isCanceled => data == null;

  @override
  String toString() =>
      'ExternalLoginResult{data: $data, isCanceled: $isCanceled}';
}

/// Login data from the service.
class ExternalLoginData {
  /// User ID from service, if provided..
  final String userId;

  /// Access token from service.
  final String token;

  /// Full user name, if provided.
  final String fullName;

  /// Client ID, if provided.
  ///
  /// Required by some services, e.g. Apple.
  final String clientId;

  const ExternalLoginData(this.userId, this.token, this.fullName,
      {this.clientId})
      : assert(token != null);

  @override
  String toString() {
    return 'ExternalLoginResult{userId: $userId, token: $token, '
        'fullName: $fullName, clientId: $clientId}';
  }
}
