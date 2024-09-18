part of 'signup.screen.dart';

class _HaveAccount extends StatelessWidget {
  const _HaveAccount();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Vous avez déjà un compte?',
          style: context.theme.textStyles.body2
              .copyWith(color: Colors.grey),
        ),
        TextButton(
          onPressed: () =>
              context.off(AuthRoute.login(), canPop: false),
          child: Text(
            'Se connecter',
            style: context.theme.textStyles.body1
                .copyWith(color: Colors.teal),
          ),
        ),
      ],
    );
  }
}
