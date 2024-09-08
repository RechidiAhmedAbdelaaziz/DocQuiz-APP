part of 'signup.screen.dart';

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SubmitButton(
      title: 'S\'inscrire',
      onPressed: () async {
        final cubit = context.read<SignupCubit>();
        if (cubit.formKey.currentState!.validate()) {
          await cubit.signUp();
        }
      },
    );
  }
}
