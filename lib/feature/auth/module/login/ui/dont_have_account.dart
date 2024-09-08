part of 'login.screen.dart';

class _DontHaveAccount extends StatelessWidget {
  const _DontHaveAccount();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText.body('Vous n\'avez pas de compte ?  ',
            color: AppColors.grey),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () => context.off(AuthRoute.signUp()),
          child:
              AppText.body('Inscrivez-vous', color: AppColors.blue),
        ),
      ],
    );
  }
}
