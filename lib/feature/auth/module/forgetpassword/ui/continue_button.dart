part of 'forget_password.screen.dart';

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      title: 'Envoyer',
      onPressed: context.read<ForgetPasswordCubit>().forgetPassword,
    );
  }
}
