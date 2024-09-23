part of 'question.screen.dart';

class _Header extends StatelessWidget {
  const _Header(this.question, this.title);

  final QuestionResultModel question;
  final String title;

  @override
  Widget build(BuildContext context) {
    bool isPaused = false;

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
          _buildPauseButton(isPaused),
          width(12),
          _buildSaveButton(),
          width(10),
          _Timer(),
        ],
      ),
    );
  }

  Widget _buildPauseButton(bool isPaused) => _buildButton(
        icon: isPaused ? Icons.play_arrow : Icons.pause,
        onPressed: () {},
      );

  Widget _buildSaveButton() =>
      _buildButton(icon: Icons.save, onPressed: () {});

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

class _Timer extends StatelessWidget {
  const _Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      color: Colors.amber,
      alignment: Alignment.center,
      child: Text(
        '00:00',
        style: context.textStyles.h3.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
