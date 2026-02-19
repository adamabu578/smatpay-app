/* -- LIST OF Constants used in APIs -- */

class APIConstants {
  // Base URL
  static const String baseUrl = 'https://api.smatpay.com.ng';

  // Authentication Endpoints
  static const String loginEndpoint = '$baseUrl/login';
  static const String signupEndpoint = '$baseUrl/signup';
  static const String verifyTokenEndpoint = '$baseUrl/verify-token';
  static const String forgotPasswordEndpoint = '$baseUrl/forgot-password';
  static const String resetPasswordEndpoint = '$baseUrl/reset-password';
  static const String profileEndpoint = '$baseUrl/profile';

  // Virtual Account Endpoints
  static const String virtualAccountEndpoint = '$baseUrl/virtual-account';

  // Wallet Endpoints
  static const String balanceEndpoint = '$baseUrl/balance';

  // Transaction Endpoints
  static const String historyEndpoint = '$baseUrl/history';

  // Airtime Endpoints
  static const String airtimeEndpoint = '$baseUrl/airtime';

  // Data Endpoints
  static const String dataEndpoint = '$baseUrl/data';
  static const String dataBundleEndpoint = '$baseUrl/data/bundle';

  // Electricity Endpoints
  static const String electricityVerifyEndpoint = '$baseUrl/electricity/recipient/verify';
  static const String electricityPurchaseEndpoint = '$baseUrl/electricity/electricity/purchase';

  // Cable TV Endpoints
  static const String cableTvVerifyEndpoint = '$baseUrl/tv/verify-smart-card';
  static const String cableTvPlansEndpoint = '$baseUrl/tv/plans';

  // Secret API Key
  static const String tSecretAPIKey = '';
}