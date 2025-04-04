part of 'question.screen.dart';

class _Questions extends StatelessWidget {
  _Questions(this.question)
      : questions = question.question.questions!,
        result = question.result;

  final QuestionResultModel question;
  final Result result;
  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuestionCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (questions.length > 1) ...[
          _buildIndicator(
            context,
            currentIndex:
                context.watch<QuestionCubit>().state.subIndex,
            isCorrect: (index) => state.isSubCorrect(question, index),
            isAnswered: question.result.isAnswerd,
          ),
          height(12),
        ],

        Builder(builder: (context) {
          final e = questions[state.subIndex];
          final difficulty = e.difficulty;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (questions.length > 1)
                Row(
                  children: [
                    width(12),
                    _buildInfo(
                        difficulty == 'easy'
                            ? "Facile"
                            : difficulty == 'medium'
                                ? "Moyenne"
                                : "Difficile",
                        difficulty == 'easy'
                            ? Colors.green
                            : difficulty == 'medium'
                                ? Colors.deepOrange
                                : Colors.red),
                  ],
                ),
              _Question(
                e,
                index: questions.indexOf(e),
                isAnswered: result.isAnswerd,
                result: result,
              ),
            ],
          );
        }),
        // const Spacer(),
      ],
    );
  }

  Widget _buildInfo(String? value, Color color,
      {bool isSource = false}) {
    if (value == null) return const SizedBox.shrink();
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isSource ? color : null,
        borderRadius: BorderRadius.circular(14.r),
        border:
            isSource ? null : Border.all(color: color, width: 1.4),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: isSource ? Colors.white : color,
          fontSize: 14.spMin,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIndicator(BuildContext context,
      {int currentIndex = 0,
      required bool Function(int) isCorrect,
      required bool isAnswered}) {
    final length = questions.length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          length,
          (index) {
            final color =
                isCorrect(index) ? Colors.green : Colors.red;

            return Row(
              children: [
                width(14),
                InkWell(
                  onTap: () {
                    context
                        .read<QuestionCubit>()
                        .toSubQuestion(index);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 50.r,
                        height: 50.r,
                        decoration: BoxDecoration(
                          color: isAnswered ? color : null,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isAnswered
                                ? color
                                : context.colors.dark,
                            width: 2.w,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: context.textStyles.h5.copyWith(
                            color: isAnswered
                                ? Colors.white
                                : context.colors.dark,
                          ),
                        ),
                      ),
                      index == currentIndex
                          ? AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 100),
                              curve: Curves.bounceInOut,
                              width: 22.w,
                              height: 3.h,
                              margin: EdgeInsets.only(top: 5.h),
                              color: context.colors.dark,
                            )
                          : height(8),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Question extends StatelessWidget {
  const _Question(
    this.question, {
    required this.result,
    required this.index,
    required this.isAnswered,
  });

  final Result result;
  final Question question;
  final int index;
  final bool isAnswered;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Text(question.text),
        _QuestionChoices(
          question,
          index: index,
          isAnswered: isAnswered,
          myChoices: result.choices.isEmpty ? [] : result.choices,
        ),
      ],
    );
  }
}
