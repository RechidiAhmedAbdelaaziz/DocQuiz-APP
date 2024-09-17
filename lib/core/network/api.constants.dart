// ignore_for_file: constant_identifier_names

abstract class ApiConstants {
  static const DEV_BASE_URL = 'http://192.168.1.2:3000/';
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

  // * QUIZ
  static const QUIZ = 'quiz';
  static const QUIZ_ID = 'quiz/{id}';
  static const QUESTION_NUMBER = 'quiz/number';
}
