part of 'login.screen.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    required Widget form,
    required Widget submitButton,
    required Widget googleButton,
    required Widget dontHaveAccountButton,
    required Widget forgotPasswordButton,
  })  : _form = form,
        _submitButton = submitButton,
        _googleButton = googleButton,
        _dontHaveAccountButton = dontHaveAccountButton,
        _forgotPasswordButton = forgotPasswordButton;

  final Widget _form;
  final Widget _submitButton;
  final Widget _googleButton;
  final Widget _dontHaveAccountButton;
  final Widget _forgotPasswordButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 22.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.dark.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              height(10),
              AppText.h2('Connectez-vous à DocQuizz'),
              height(20),
              _googleButton,
              height(10),
              _form,
              height(35),
              _submitButton,
              height(15),
              _dontHaveAccountButton,
              _forgotPasswordButton,
            ],
          ),
        ),
      ),
    );
  }
}
