part of 'forget_password.screen.dart';

class _From extends StatelessWidget {
  const _From({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.label('Email'),
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
