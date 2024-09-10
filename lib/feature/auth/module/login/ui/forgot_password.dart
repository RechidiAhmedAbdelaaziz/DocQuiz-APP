part of 'login.screen.dart';

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () => context.to(AuthRoute.forgotPassword()),
      child: Text(
        'Mot de passe oublié ?',
        style: context.theme.textStyles.body1
            .copyWith(color: Colors.blue),
      ),
    );
  }
}
