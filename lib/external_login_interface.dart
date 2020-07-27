library external_login_interface;

import 'package:async/async.dart';
import 'package:meta/meta.dart';

export 'package:async/async.dart' show Result;

/// Implementation of external login for specific service.
abstract class ExternalLogin {
  /// Returns `true` if login via service is supported.
  Future<bool> get isSupported;

  /// Start log in process.
  ///
  /// If is't error, than [ErrorResult.error]
  /// should contains [ExternalLoginErrorData].
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

  /// Log in complete successfully.
  factory ExternalLoginResult.successWith(
      {String userId,
      @required String token,
      String fullName,
      String clientId}) {
    return ExternalLoginResult.success(
        ExternalLoginData(userId, token, fullName, clientId: clientId));
  }

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

/// Error data on log in failure.
class ExternalLoginErrorData {
  /// Error.
  final ExternalLoginError error;

  /// Localized error message. Will be shown to a user.
  ///
  /// Can be `null`.
  final String localizedMessage;

  /// Error description. It's for developer.
  ///
  /// Can be `null`.
  final String description;

  const ExternalLoginErrorData(this.error,
      {this.localizedMessage, this.description})
      : assert(error != null);

  /// Creates data with [ExternalLoginError.unknown].
  factory ExternalLoginErrorData.unknown(
          {String localizedMessage, String description}) =>
      ExternalLoginErrorData(ExternalLoginError.unknown,
          localizedMessage: localizedMessage, description: description);

  /// Creates data with [ExternalLoginError.loginFailed].
  factory ExternalLoginErrorData.loginFailed(
          {String localizedMessage, String description}) =>
      ExternalLoginErrorData(ExternalLoginError.loginFailed,
          localizedMessage: localizedMessage, description: description);

  /// Creates data with [ExternalLoginError.cantGetProfile].
  factory ExternalLoginErrorData.cantGetProfile(
          {String localizedMessage, String description}) =>
      ExternalLoginErrorData(ExternalLoginError.cantGetProfile,
          localizedMessage: localizedMessage, description: description);

  /// Creates data with [ExternalLoginError.requireRetry].
  factory ExternalLoginErrorData.requireRetry(
          {String localizedMessage, String description}) =>
      ExternalLoginErrorData(ExternalLoginError.requireRetry,
          localizedMessage: localizedMessage, description: description);

  /// Creates data with [ExternalLoginError.muted].
  factory ExternalLoginErrorData.muted(
          {String description}) =>
      ExternalLoginErrorData(ExternalLoginError.muted,
          description: description);

  @override
  String toString() => 'ExternalLoginErrorData{error: $error, '
      'localizedMessage: $localizedMessage, description: $description}';
}

/// External login errors.
enum ExternalLoginError {
  /// Some unhandled error.
  unknown,

  /// Error during log in process.
  loginFailed,

  /// Get  profile data failed.
  cantGetProfile,

  /// Error that require to retry log in attempt.
  requireRetry,

  /// Error that shouldn'tbe shown to the user.
  muted
}
