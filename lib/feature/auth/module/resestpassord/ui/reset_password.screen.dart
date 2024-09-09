import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/extension/snackbar.extension.dart';
import 'package:app/core/extension/validator.extension.dart';
import 'package:app/core/shared/widgets/form_field.dart';
import 'package:app/core/shared/widgets/submit_button.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/auth/helper/auth.router.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../logic/reset_password.cubit.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            context.showSuccessSnackBar(
                'Mot de passe réinitialisé avec succès');
            context.to(AuthRoute.login());
          },
          error: (message) => context.showErrorSnackBar(message),
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 22.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: context.theme.colors.primary,
              boxShadow: [
                BoxShadow(
                  color:
                      context.theme.colors.primary.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 20.w, vertical: 30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                height(10),
                Text(
                  'Réinitialiser votre mot de passe',
                  style: context.theme.textStyles.h2,
                ),
                height(20),
                const _Form(),
                height(35),
                const _SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResetPasswordCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          Text(
            'Nouveau mot de passe',
            style: context.theme.textStyles.body1,
          ),
          height(5),
          AppInputeField(
            hint: 'Entrez votre nouveau mot de passe',
            controller: cubit.passwordController,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) => value.isStrongPassword,
          ),
          height(20),
          Text(
            'Confirmez votre mot de passe',
            style: context.theme.textStyles.body1,
          ),
          height(5),
          AppInputeField(
              hint: 'Confirmez votre mot de passe',
              controller: cubit.confirmPasswordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value != cubit.passwordController.text) {
                  return 'Les mots de passe ne correspondent pas';
                }
                return null;
              }),
        ],
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      title: 'Valider',
      onPressed: context.read<ResetPasswordCubit>().resetPassword,
    );
  }
}
