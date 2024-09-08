part of 'signup.screen.dart';

class _HaveAccount extends StatelessWidget {
  const _HaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText.body('Vous avez déjà un compte?',
            color: AppColors.grey),
        TextButton(
          onPressed: () => context.off(AuthRoute.login()),
          child: AppText.body('Se connecter', color: AppColors.blue),
        ),
      ],
    );
  }
}
