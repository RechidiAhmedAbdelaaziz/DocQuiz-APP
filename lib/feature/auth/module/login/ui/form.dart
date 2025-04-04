part of 'login.screen.dart';

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email', style: context.theme.textStyles.body1),
          height(5),
          AppInputeField(
            controller: cubit.emailController,
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value.isValidEmail,
          ),
          height(20),
          Text('Mot de passe', style: context.theme.textStyles.body1),
          height(5),
          AppInputeField(
            controller: cubit.passwordController,
            hint: 'Mot de passe',
            obscureText: true,
            validator: (value) =>
                value?.isEmpty == true ? 'Champ obligatoire' : null,
          ),
        ],
      ),
    );
  }
}
