part of 'signup.screen.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    required this.form,
    required this.signUpButton,
    required this.haveAccountButton,
  });

  final Widget form;
  final Widget signUpButton;
  final Widget haveAccountButton;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) => context.showDialogBox(
            title: 'Error',
            body: message,
            cancelText: 'Retry',
            onCancel: (back) => back(),
          ),
          success: () => locator<AuthCubit>().onAuthinit(),
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
                  'Créer un compte',
                  style: context.theme.textStyles.h2,
                ),
                height(20),
                form,
                height(35),
                signUpButton,
                height(15),
                haveAccountButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
