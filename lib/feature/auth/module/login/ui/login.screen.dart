import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/extension/validator.extension.dart';
import 'package:app/core/shared/widgets/form_field.dart';
import 'package:app/core/shared/widgets/submit_button.dart';
import 'package:app/core/theme/colors.dart';
import 'package:app/core/theme/fonts.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/auth/helper/auth.router.dart';
import 'package:app/feature/auth/module/googleauth/widget/google_button.dart';
import 'package:app/feature/auth/module/login/logic/login.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'scaffold.dart';
part 'form.dart';
part 'dont_have_account.dart';
part 'forgot_password.dart';
part 'login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const _Scaffold(
        form: _Form(),
        submitButton: _LoginButton(),
        googleButton: GoogleAuthButton(),
        dontHaveAccountButton: _DontHaveAccount(),
        forgotPasswordButton: _ForgotPasswordButton(),
      ),
    );
  }
}
