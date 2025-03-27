/// Custom exception class to handle various Firebase authentication required errors
class TFormatException implements Exception {
  /// The associated error message
  final String message;

  /// The Constructor with a generic error message.
  TFormatException(
      [this.message =
          "An unexpected format error occurred. Please check you input."]);

  /// Create a format exception from a specific error message
  factory TFormatException.fromMessage(String message) {
    return TFormatException(message);
  }

  /// Get the corresponding error message.
  String get formattedMessage => message;
  factory TFormatException.fromCode(String code) {
    switch (code) {
      case 'invalide-email-format':
        return TFormatException(
            'The email address format is invalid. Please enter a valid email.');
      case 'invalide-phone-number-format':
        return TFormatException(
            'The provided phone number format is invalid. Please enter a valid number.');
      case 'invalide-date-format':
        return TFormatException(
            'The provided date format is invalid. Please enter a valid date.');
      case 'invalide-url-format':
        return TFormatException(
            'The provided URL format is invalid. Please enter a valid URL.');
      case 'invalide-credit -card-format':
        return TFormatException(
            'The provided credit card format is invalid. Please enter a valid credit card number.');
      case 'invalide-numeric-format':
        return TFormatException('The input should be a valid numeric format');

      /// Add more cases as needed
      default:
        return TFormatException(
            'An unexpected format error occurred. Please check your input.');
    }
  }
}
