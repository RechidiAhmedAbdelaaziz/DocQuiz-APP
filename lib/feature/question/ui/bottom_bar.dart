part of 'question.screen.dart';

class _BottomBar extends StatelessWidget {
  const _BottomBar(this.question);

  final QuestionResultModel question;

  @override
  Widget build(BuildContext context) {
    final isAnswered = question.result?.isAnswerd ?? false;
    final cubit = context.read<QuestionCubit>();
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: context.colors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          cubit.previousExist
              ? InkWell(
                  onTap: cubit.previousQuestion,
                  child: CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 20.w,
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              : width(40),
          width(75),
          _buildButton(
            title: isAnswered ? 'Explication' : 'Valider',
            onPressed: () =>
                !isAnswered ? cubit.answerQuestion() : () {},
          ),
          width(75),
          cubit.nextExist
              ? InkWell(
                  onTap: cubit.nextQuestion,
                  child: CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 20.w,
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              : !isAnswered
                  ? width(40)
                  : InkWell(
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 20.w,
                        child: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {},
                    )
        ],
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
