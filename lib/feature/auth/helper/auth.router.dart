// ignore_for_file: constant_identifier_names

import 'package:app/core/router/abstract_route.dart';
import 'package:app/feature/auth/module/forgetpassword/ui/forget_password.screen.dart';
import 'package:app/feature/auth/module/login/ui/login.screen.dart';
import 'package:app/feature/auth/module/otp/cubit/otp_cubit.dart';
import 'package:app/feature/auth/module/otp/ui/otp.screen.dart';
import 'package:app/feature/auth/module/signup/ui/signup.screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthRoute extends AbstractRoute {
  static const String LOGIN_PATH = '/login';
  static const String FORGOT_PASSWORD_PATH = '/forgot-password';
  static const String SIGN_UP_PATH = '/sign-up';
  static const String OTP_PATH = '/otp';

  AuthRoute.login()
      : super(
          LOGIN_PATH,
          child: const LoginScreen(),
        );

  AuthRoute.signUp()
      : super(
          SIGN_UP_PATH,
          child: const SignupScreen(),
        );

  AuthRoute.forgotPassword()
      : super(
          FORGOT_PASSWORD_PATH,
          child: const ForgetPasswordScreen(),
        );

  AuthRoute.otp(String email)
      : super(
          OTP_PATH,
          child: BlocProvider(
            create: (context) => OtpCubit(email),
            child: const OtpScreen(),
          ),
        );
}
