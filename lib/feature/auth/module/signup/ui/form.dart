part of 'signup.screen.dart';

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nom',
            style: context.theme.textStyles.body1,
          ),
          height(5),
          AppInputeField(
            controller: cubit.nameController,
            hint: 'Nom',
            keyboardType: TextInputType.name,
            validator: (value) => value.isValidString,
          ),
          height(20),
          Text(
            'Email',
            style: context.theme.textStyles.body1,
          ),
          height(5),
          AppInputeField(
            controller: cubit.emailController,
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value.isValidEmail,
          ),
          height(20),
          Text(
            'Mot de passe',
            style: context.theme.textStyles.body1,
          ),
          height(5),
          AppInputeField(
            controller: cubit.passwordController,
            hint: 'Mot de passe',
            obscureText: true,
            validator: (value) => value.isStrongPassword,
          ),
          height(20),
          Text(
            'Confirmer le mot de passe',
            style: context.theme.textStyles.body1,
          ),
          height(5),
          AppInputeField(
              controller: cubit.confirmPasswordController,
              hint: 'Confirmer le mot de passe',
              obscureText: true,
              validator: (value) {
                if (value != cubit.passwordController.text) {
                  return 'Les mots de passe ne correspondent pas';
                }
                return null;
              }),
        ],
      ),
    );
  }
}
