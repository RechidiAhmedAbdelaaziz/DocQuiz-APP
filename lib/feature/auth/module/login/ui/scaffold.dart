part of 'login.screen.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    required Widget form,
    required Widget submitButton,
    required Widget googleButton,
    required Widget dontHaveAccountButton,
    required Widget forgotPasswordButton,
  })  : _form = form,
        _submitButton = submitButton,
        _googleButton = googleButton,
        _dontHaveAccountButton = dontHaveAccountButton,
        _forgotPasswordButton = forgotPasswordButton;

  final Widget _form;
  final Widget _submitButton;
  final Widget _googleButton;
  final Widget _dontHaveAccountButton;
  final Widget _forgotPasswordButton;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) => context.showDialogBox(
            title: 'Erreur',
            body: message,
            // retry in french
            cancelText: 'Réessayer',
            onCancel: (back) => back(),
          ),
          loaded: (user) => locator<AuthCubit>().onAuthinit(user),
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
                const SwitchThemesButton(),
                height(10),
                Text(
                  'Connectez-vous à FenneQCM',
                  style: context.theme.textStyles.h2,
                ),
                height(20),
                _googleButton,
                height(10),
                _form,
                height(35),
                _submitButton,
                height(15),
                _dontHaveAccountButton,
                _forgotPasswordButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
