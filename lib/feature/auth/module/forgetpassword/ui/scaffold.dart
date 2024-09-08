part of 'forget_password.screen.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    super.key,
    required this.form,
    required this.continueButton,
    required this.cancelButton,
  });

  final Widget form;
  final Widget continueButton;
  final Widget cancelButton;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (message) {
            final email = context.read<ForgetPasswordCubit>().email;
            context.to(AuthRoute.otp(email));
            context.showSuccessSnackBar(message);
          },
          error: (message) => context.showErrorSnackBar(message),
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 22.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.dark.withOpacity(0.1),
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
                AppText.h2('Veuillez entrer votre email'),
                height(20),
                form,
                height(35),
                Row(
                  children: [
                    cancelButton,
                    width(10),
                    Expanded(child: continueButton),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
