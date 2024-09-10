part of 'forget_password.screen.dart';

class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.background,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      // width: double.infinity,
      child: IconButton(
          onPressed: () => context.back(),
          icon: Icon(
            Icons.arrow_back,
            color: context.theme.colors.primaryText,
          )),
    );
  }
}
