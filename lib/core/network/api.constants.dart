// ignore_for_file: constant_identifier_names

class ApiConstants {
  static const DEV_BASE_URL = 'http://192.168.1.12:3000/';
  static const PROD_BASE_URL = 'https://api.docquizz.top/';

  // * AUTH
  static const LOGIN = 'auth/login';
  static const REGISTER = 'auth/register';
  static const REFRESH_TOKEN = 'auth/refresh-token';
  static const FORGOT_PASSWORD = 'auth/forget-password';
  static const VERIFY_OTP = 'auth/verify-otp';
  static const RESET_PASSWORD = 'auth/reset-password';
  static const GOOGLE_CALLBACK = 'o-auth/google/callback';

  // * DASHBOARD
  static const DASHBOARD = 'statistic';
}
