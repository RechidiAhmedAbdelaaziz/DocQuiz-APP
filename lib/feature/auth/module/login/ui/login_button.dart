part of 'login.screen.dart';

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      title: 'Se connecter',
      onPressed: () async {
        final cubit = context.read<LoginCubit>();
        if (cubit.formKey.currentState!.validate()) {
          await cubit.login();
        }
      },
    );
  }
}
