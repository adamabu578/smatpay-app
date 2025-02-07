/// Custom exception class to handle various Firebase authentication required errors
class TFirebaseAuthException implements Exception {
  /// The error code associated with the exception
  final String code;

  /// Constructor that takes an error code.
  TFirebaseAuthException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email is already registered. Please use a different email.';
      case 'Invalid-email':
        return 'The email is invalid. Please use a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a strong password.';
      case 'user-disabled':
        return 'Thgis user account has been disabled. Please contact support for assistance';
      case 'user-not-found':
        return 'Invalid login details. User not found';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
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
        return 'This operation is not allowed. Please contact support for assistance.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection and try again.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'session-expired':
        return 'Session expired. Please log in again.';
      case 'invalid-custom-token':
        return 'Invalid custom token. Please try again.';
      case 'invalid-credential':
        return 'Invalid credential. Please check your login details and try again.';
      case 'account-exists-with-different-credential':
        return 'An account with this email already exists but with a different sign-in method. Please sign in with the appropriate method.';
      case 'requires-recent-login':
        return 'This action requires recent authentication. Please log in again.';
      case 'user-mismatch':
        return 'User mismatch. Please try again.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new one.';
      case 'invalid-action-code':
        return 'Invalid action code. Please check your code and try again.';
      case 'app-not-authorized':
        return 'This app is not authorized to use Firebase Authentication. Please check your Firebase project configuration.';
      case 'key-pair-mismatch':
        return 'Key pair mismatch. Please try again.';
      case 'credential-already-in-use':
        return 'The credential is already in use. Please use a different credential.';
      case 'internal-error':
        return 'An internal error occurred. Please try again later.';
      default:
        return 'An  unexpected Firebase error occurred. Please try again';
    }
  }
}
