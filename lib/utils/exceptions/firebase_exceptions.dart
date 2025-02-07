/// Custom exception class to handle various Firebase authentication required errors
class TFirebaseException implements Exception {
  /// The error code associated with the exception
  final String code;

  /// Constructor that takes an error code.
  TFirebaseException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occured. Please try again';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check your custom token';
      case 'custom-token-mismatch':
        return 'The custom token corresponds to a different audience.';
      case 'user-disabled':
        return 'Thgis user account has been disabled.';
      case 'user-not-found':
        return 'No user not found for the given email or UID';
      case 'invalid-email':
        return 'The email address provided is invalid. please enter a valid email';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code';
      case 'qouta-exceeded':
        return 'Qouta exceeded. Please try again later.';
      case 'email-already-exist':
        return 'The email  already exist. Please use a different email.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Contact support for assistance';
      case 'app-not-authorized':
        return 'The app is not authorized to use Firebase Authentication with the API key.';
      case 'keychain-error':
        return 'A keychain error occurred. Please check the keychain and try again';
      case 'internal-error':
        return 'An internal authentication error occurred. Please try again later';
      default:
        return 'An  unexpected Firebase error occurred. Please try again';
    }
  }
}
