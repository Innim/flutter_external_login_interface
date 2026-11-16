## [0.1.10] - 2026-11-16

* Added `ExternalLoginError.credentialMatchingFailed` error type to handle cases where authorization credentials cannot be matched or validated.
* Added `ExternalLoginErrorData.credentialMatchingFailed` factory.

## [0.1.9] - 2026-08-11

* Added an optional authorization protocol version to `ExternalLoginData` to allow the server to select the appropriate authentication flow while preserving compatibility with older clients.

## [0.1.8] - 2026-02-11

* Added new `invalidTime` error with factory method.

## [0.1.7] - 2024-05-23

* Add field `data` to `ExternalLoginResult` for any additional information.

## [0.1.6+1] - 2021-09-27

* Change `async` constraint.

## [0.1.6] - 2021-09-27

* Null safety.

## [0.1.5+3] - 2021-05-21

* Email from user.

## [0.1.5+2] - 2020-07-30

* Avatar URL.

## [0.1.4] - 2020-07-27

* New errors: `muted` and `requireRetry`.

## [0.1.3] - 2020-07-27

* Added `isSupported` field.

## [0.1.2+1] - 2020-07-16

* Export `Result`.

## [0.1.2] - 2020-07-16

* Error data.

## [0.1.1+1] - 2020-07-15

* Lower `meta` version (for Flutter).

## [0.1.1] - 2020-07-15

* Factory method to shorten data creation.

## [0.1.0] - 2020-07-15

* Interfaces for external login implementation and result data objects.
