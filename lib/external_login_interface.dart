library external_login_interface;

import 'package:async/async.dart';

export 'package:async/async.dart' show Result;

/// Implementation of external login for specific service.
abstract class ExternalLogin {
  /// Returns `true` if login via service is supported.
  Future<bool> get isSupported;

  /// Start log in process.
  ///
  /// If is't error, than [ErrorResult.error]
  /// should contains [ExternalLoginErrorData].
  ///
  /// If [loadAvatar] is `true` than implemention
  /// should request information about user picture.
  Future<Result<ExternalLoginResult>> login({bool loadAvatar = false});

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
  final ExternalLoginData? data;

  /// Log in complete successfully.
  const ExternalLoginResult.success(ExternalLoginData data) : this.data = data;

  /// User cancels log in.
  const ExternalLoginResult.cancel() : this.data = null;

  /// Log in complete successfully.
  factory ExternalLoginResult.successWith({
    String? userId,
    required String token,
    String? fullName,
    String? avatarUrl,
    String? clientId,
    String? email,
    Map<String, Object?>? data,
  }) {
    return ExternalLoginResult.success(
      ExternalLoginData(
        userId,
        token,
        fullName,
        avatarUrl: avatarUrl,
        clientId: clientId,
        email: email,
        data: data,
      ),
    );
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
  final String? userId;

  /// Access token from service.
  final String token;

  /// Full user name, if provided.
  final String? fullName;

  /// URL for user avatar, if provided.
  final String? avatarUrl;

  /// Email from user, if provided.
  final String? email;

  /// Client ID, if provided.
  ///
  /// Required by some services, e.g. Apple.
  final String? clientId;

  /// Additional data
  final Map<String, Object?>? data;

  const ExternalLoginData(
    this.userId,
    this.token,
    this.fullName, {
    this.clientId,
    this.avatarUrl,
    this.email,
    this.data,
  });

  @override
  String toString() {
    return 'ExternalLoginResult{userId: $userId, token: $token, '
        'fullName: $fullName, clientId: $clientId, avatarUrl: $avatarUrl, '
        'email: $email, data: $data}';
  }
}

/// Error data on log in failure.
class ExternalLoginErrorData {
  /// Error.
  final ExternalLoginError error;

  /// Localized error message. Will be shown to a user.
  ///
  /// Can be `null`.
  final String? localizedMessage;

  /// Error description. It's for developer.
  ///
  /// Can be `null`.
  final String? description;

  const ExternalLoginErrorData(this.error,
      {this.localizedMessage, this.description});

  /// Creates data with [ExternalLoginError.unknown].
  factory ExternalLoginErrorData.unknown(
          {String? localizedMessage, String? description}) =>
      ExternalLoginErrorData(ExternalLoginError.unknown,
          localizedMessage: localizedMessage, description: description);

  /// Creates data with [ExternalLoginError.loginFailed].
  factory ExternalLoginErrorData.loginFailed(
          {String? localizedMessage, String? description}) =>
      ExternalLoginErrorData(ExternalLoginError.loginFailed,
          localizedMessage: localizedMessage, description: description);

  /// Creates data with [ExternalLoginError.cantGetProfile].
  factory ExternalLoginErrorData.cantGetProfile(
          {String? localizedMessage, String? description}) =>
      ExternalLoginErrorData(ExternalLoginError.cantGetProfile,
          localizedMessage: localizedMessage, description: description);

  /// Creates data with [ExternalLoginError.requireRetry].
  factory ExternalLoginErrorData.requireRetry(
          {String? localizedMessage, String? description}) =>
      ExternalLoginErrorData(ExternalLoginError.requireRetry,
          localizedMessage: localizedMessage, description: description);

  /// Creates data with [ExternalLoginError.muted].
  factory ExternalLoginErrorData.muted({String? description}) =>
      ExternalLoginErrorData(ExternalLoginError.muted,
          description: description);

  /// Creates data with [ExternalLoginError.invalidTime].
  factory ExternalLoginErrorData.invalidTime({String? description}) =>
      ExternalLoginErrorData(ExternalLoginError.invalidTime,
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
  muted,

  /// Time validation error.
  ///
  /// Failed due to excessive time difference
  /// between request and server response.
  /// Often caused by incorrect device time.
  invalidTime,
}
