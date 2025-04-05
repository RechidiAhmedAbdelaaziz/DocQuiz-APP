import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/extension/snackbar.extension.dart';
import 'package:app/core/extension/validator.extension.dart';
import 'package:app/core/shared/widgets/form_field.dart';
import 'package:app/core/shared/widgets/submit_button.dart';
import 'package:app/core/themes/spaces.dart';
import 'package:app/feature/auth/helper/auth.router.dart';
import 'package:app/feature/auth/module/forgetpassword/cubit/forget_password.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'scaffold.dart';
part 'form.dart';
part 'cancel_button.dart';
part 'continue_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: const _Scaffold(
        form: _From(),
        continueButton: _ContinueButton(),
        cancelButton: _CancelButton(),
      ),
    );
  }
}
