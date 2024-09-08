part of 'login.screen.dart';

class _Form extends StatelessWidget {
  const _Form({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.label('Email'),
          height(5),
          AppInputeField(
            controller: cubit.emailController,
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value.isValidEmail,
          ),
          height(20),
          AppText.label('Mot de passe'),
          height(5),
          AppInputeField(
            controller: cubit.passwordController,
            hint: 'Mot de passe',
            obscureText: true,
            validator: (value) => value.isStrongPassword,
          ),
        ],
      ),
    );
  }
}
