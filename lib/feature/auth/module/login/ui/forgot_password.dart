part of 'login.screen.dart';

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () => context.to(AuthRoute.forgotPassword()),
      child: AppText.body(
        'Mot de passe oublié ?',
        color: AppColors.blue,
      ),
    );
  }
}
