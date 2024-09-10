part of 'login.screen.dart';

class _DontHaveAccount extends StatelessWidget {
  const _DontHaveAccount();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Vous n\'avez pas de compte ?  ',
          style: context.theme.textStyles.body1
              .copyWith(color: Colors.grey),
        ),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () =>
              context.off(AuthRoute.signUp(), canPop: false),
          child: Text(
            'Inscrivez-vous',
            style: context.theme.textStyles.body1.copyWith(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
