import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/extension/snackbar.extension.dart';
import 'package:app/core/shared/widgets/submit_button.dart';
import 'package:app/core/themes/spaces.dart';
import 'package:app/feature/auth/helper/auth.router.dart';
import 'package:app/feature/auth/module/otp/logic/otp_cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (email, otp) {
            context.showSuccessSnackBar('Code vérifié avec succès');
            context.to(AuthRoute.resetPassword(email, otp));
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
                  'Saisissez le code reçu par Email',
                  style: context.theme.textStyles.h2,
                ),
                height(20),
                const _OtpField(),
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

class _OtpField extends StatelessWidget {
  const _OtpField();

  @override
  Widget build(BuildContext context) {
    final otpController = context.read<OtpCubit>().otpController;
    return OtpTextField(
      numberOfFields: 6,
      borderColor: context.theme.colors.primary,
      showFieldAsBox: true,
      onSubmit: (String code) {
        otpController.text = code;
      }, // end onSubmit
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      title: 'Valider',
      onPressed: context.read<OtpCubit>().submitOtp,
    );
  }
}
