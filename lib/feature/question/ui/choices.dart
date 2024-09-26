part of 'question.screen.dart';

class _QuestionChoices extends StatelessWidget {
  _QuestionChoices(
    this.question,
  )   : isAnswered = question.result.isAnswerd ?? false,
        isMultiple = question.question.type == 'QCM';

  final QuestionResultModel question;
  final bool isAnswered;
  final bool isMultiple;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: question.choices.map((choice) {
          return _Choice(
            choice: choice,
            prefix:
                Constants.ALPHABET[question.choices.indexOf(choice)],
            isCorrect: context
                .read<QuestionCubit>()
                .state
                .question!
                .question
                .correctAnswers!
                .contains(choice),
            isAnswered: isAnswered,
            onSelect: (choice) =>
                context.read<QuestionCubit>().choseAnswer = choice,
          );
        }).toList(),
      ),
    );
  }
}

class _Choice extends StatelessWidget {
  const _Choice({
    required this.prefix,
    required this.choice,
    required this.isCorrect,
    required this.isAnswered,
    this.onSelect,
  });

  final String choice;
  final bool isCorrect;
  final bool isAnswered;
  final String prefix;
  final void Function(String choice)? onSelect;

  @override
  Widget build(BuildContext context) {
    final myChoices = context.watch<QuestionCubit>().myChoices;

    final isSelected = myChoices.contains(choice);

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
        onSelect?.call(choice);
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
              radius: 18.w,
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
                style: context.textStyles.body1
                    .copyWith(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
