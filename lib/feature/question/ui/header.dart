part of 'question.screen.dart';

class _Header extends StatelessWidget {
  const _Header(this.question, this.title);

  final QuestionResultModel question;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[800],
      child: Row(
        children: [
          width(5),
          Expanded(
            child: TextScroll(
              '$title   ',
              pauseBetween: const Duration(seconds: 2),
              fadeBorderSide: FadeBorderSide.left,
              style: context.textStyles.body1.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          width(10),
          // _buildPauseButton(),
          _buildButton(
              icon: Icons.pause,
              onPressed: () {
                context.read<TimeCubit>().pause();
                context.showDialogBox(
                  title: 'Pause',
                  // body: 'Voulez-vous vraiment mettre en pause le test ?',
                  confirmText: 'Continuer',
                  onConfirm: (back) {
                    context.read<TimeCubit>().start();
                    back();
                  },
                  cancelText: 'Quitter',
                  onCancel: (_) {},
                );
              }),
          width(12),
          _buildButton(
            icon: Icons.save,
            onPressed: () {},
          ),
        
          width(10),
          const AppTimer(),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 20.h,
      child: InkWell(
        onTap: onPressed,
        child: Icon(icon, color: Colors.redAccent),
      ),
    );
  }
}
