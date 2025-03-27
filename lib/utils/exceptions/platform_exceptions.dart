/// Exception class for handling various platform-related errors.
class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'sign-in-failed':
        return 'Sign-in failed. Please check your credentials and try again.';
      case 'verification-code-expired':
        return 'Verification code expired. Please request a new code.';
      case 'verification-code-invalid':
        return 'Invalid verification code. Please enter a valid code.';
      case 'phone-number-invalid':
        return 'Invalid phone number. Please enter a valid phone number.';
      case 'phone-number-unreachable':
        return 'Phone number unreachable. Please check your network connection.';
      case 'otp-request-failed':
        return 'OTP request failed. Please try again later.';
      case 'sign-in-cancelled':
        return 'Sign-in process cancelled.';
      case 'verification-code-retry-later':
        return 'Verification code request failed. Please try again later.';
      case 'phone-number-unverified':
        return 'Phone number unverified. Please verify your phone number.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'sign-in-timeout':
        return 'Sign-in timed out. Please try again later.';
      case 'phone-number-already-verified':
        return 'Phone number already verified.';
      case 'too-many-verification-requests':
        return 'Too many verification requests. Please try again later.';
      case 'invalid-phone-number-format':
        return 'Invalid phone number format. Please enter a valid phone number.';
      case 'verification-code-resend-limit-exceeded':
        return 'Verification code resend limit exceeded. Please try again later.';
      case 'phone-number-change-not-allowed':
        return 'Phone number change not allowed. Please contact support for assistance.';
      case 'too-many-sign-in-attempts':
        return 'Too many sign-in attempts. Please try again later.';
      case 'phone-number-already-in-use':
        return 'Phone number already in use. Please use a different phone number.';
      case 'missing-verification-id':
        return 'Missing verification ID. Please request a new verification code.';
      case 'unexpected-error':
        return 'An unexpected error occurred. Please try again later.';
      default:
        return 'An unexpected Firebase error occurred. Please try again later.';
    }
  }
}
