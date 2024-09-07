// ignore_for_file: constant_identifier_names

import 'package:app/core/router/abstract_route.dart';
import 'package:app/feature/auth/module/login/ui/login.screen.dart';
import 'package:app/feature/auth/module/signup/ui/signup.screen.dart';

class AuthRoute extends AbstractRoute {
  static const String LOGIN_PATH = '/login';
  static const String FORGOT_PASSWORD_PATH = '/forgot-password';
  static const String SIGN_UP_PATH = '/sign-up';

  AuthRoute.login() : super(LOGIN_PATH, child: const LoginScreen());

  AuthRoute.forgotPassword()
      : super(FORGOT_PASSWORD_PATH,
            child:
                const LoginScreen()); // TODO : add forgot password screen

  AuthRoute.signUp()
      : super(SIGN_UP_PATH, child: const SignupScreen());
}
