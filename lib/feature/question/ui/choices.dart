part of 'question.screen.dart';

class _QuestionChoices extends StatelessWidget {
  _QuestionChoices(
    this.question, {
    required this.isAnswered,
    required this.index,
    this.myChoices = const [],
  })  : answers = question.answers,
        isMultiple = question.isMultiple;

  final int index;
  final Question question;
  final List<Answer> answers;
  final List<List<int>> myChoices;
  final bool isAnswered;
  final bool isMultiple;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<QuestionCubit>();

    return Column(
      children: [
        ...answers.map((answer) {
          return _Choice(
            choice: answer.text!,
            prefix: Constants.ALPHABET[answers.indexOf(answer)],
            isCorrect: answer.isCorrect == true,
            isAnswered: isAnswered,
            isSelected: myChoices.isEmpty
                ? cubit.myChoices[index]
                    .contains(answers.indexOf(answer))
                : myChoices[index].contains(answers.indexOf(answer)),
            onSelect: () =>
                cubit.choseAnswer(question, answers.indexOf(answer)),
          );
        }),
        height(12.h)
      ],
    );
  }
}

class _Choice extends StatelessWidget {
  const _Choice({
    required this.prefix,
    required this.choice,
    required this.isCorrect,
    required this.isAnswered,
    required this.isSelected,
    this.onSelect,
  });

  final bool isSelected;
  final String choice;
  final bool isCorrect;
  final bool isAnswered;
  final String prefix;
  final void Function()? onSelect;

  @override
  Widget build(BuildContext context) {
    final boxColor = isAnswered
        ? isSelected
            ? isCorrect
                ? Colors.green
                : Colors.red
            : context.colors.primary
        : isSelected
            ? Colors.blue
            : context.colors.primary;

    final textColor = isAnswered
        ? isSelected
            ? Colors.white
            : isCorrect
                ? Colors.green
                : Colors.red
        : isSelected
            ? Colors.white
            : context.colors.dark;

    final prefixColor = isAnswered
        ? isCorrect
            ? Colors.green[800]
            : Colors.red[800]
        : isSelected
            ? Colors.orange
            : Colors.grey;

    return GestureDetector(
      onTap: () {
        onSelect?.call();
      },
      child: Container(
        width: double.infinity,
        padding:
            EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
        margin:
            EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: prefixColor,
              radius: 18.spMin,
              child: Text(
                prefix,
                style: context.textStyles.h5.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            width(15),
            Expanded(
              child: Text(
                choice,
                maxLines: 25,
                style: context.textStyles.body2.copyWith(
                  color: textColor,
                  fontSize: 20.spMin,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
