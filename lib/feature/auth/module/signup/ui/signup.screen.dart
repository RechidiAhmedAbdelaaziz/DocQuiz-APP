import 'package:app/core/di/container.dart';
import 'package:app/core/extension/alertdialog.extenstion.dart';
import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/extension/validator.extension.dart';
import 'package:app/core/shared/widgets/form_field.dart';
import 'package:app/core/shared/widgets/submit_button.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/auth/helper/auth.router.dart';
import 'package:app/feature/auth/logic/auth.cubit.dart';
import 'package:app/feature/auth/module/signup/cubit/signup.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'scaffold.dart';
part 'form.dart';
part 'signup_button.dart';
part 'have_account.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: const _Scaffold(
        form: _Form(),
        signUpButton: _SignUpButton(),
        haveAccountButton: _HaveAccount(),
      ),
    );
  }
}
