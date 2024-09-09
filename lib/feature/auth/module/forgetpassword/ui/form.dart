part of 'forget_password.screen.dart';

class _From extends StatelessWidget {
  const _From();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email', style: context.theme.textStyles.body1),
          height(10),
          AppInputeField(
            controller: cubit.emailController,
            validator: (value) => value.isValidString,
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
