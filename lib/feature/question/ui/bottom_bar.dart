part of 'question.screen.dart';

class _BottomBar extends StatelessWidget {
  const _BottomBar(
    this.question,
  );

  final QuestionResultModel question;

  @override
  Widget build(BuildContext context) {
    final isAnswered = question.result.isAnswerd;
    final current = (question.question.questions?.length ?? 0) > 1
        ? context.read<QuestionCubit>().state.subIndex + 1
        : null;
    final cubit = context.read<QuestionCubit>();
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(10.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
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
          width(40),
          _buildButton(context,
              title: isAnswered
                  ? 'Explication${current == null ? '' : '( Q$current )'}'
                  : 'Valider', onPressed: () {
            if (isAnswered) {
              context.showBottomSheet(
                  child:
                      _ExplanationAndNotes(question, current ?? 1));
            } else {
              cubit.answerQuestion();
            }
          }),
          width(40),
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
                      onTap: () => context.back(
                        context.read<QuestionCubit>().state.questions,
                      ),
                    ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String title,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Text(
          title,
          style: context.textStyles.h5.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ExplanationAndNotes extends StatefulWidget {
  const _ExplanationAndNotes(this.question, this.index);

  final QuestionResultModel question;
  final int index;

  @override
  State<_ExplanationAndNotes> createState() =>
      _ExplanationAndNotesState();
}

class _ExplanationAndNotesState extends State<_ExplanationAndNotes> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        height(20),
        Row(
          children: [
            _buildTab('Explication', index: 0),
            _buildTab('Notes', index: 1),
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10.r)),
              border: const Border(
                // bottom: BorderSide(color: Colors.g),
                left: BorderSide(color: Colors.teal),
                right: BorderSide(color: Colors.teal),
              ),
            ),
            child: [
              _Explination(widget.question.question
                  .questions![widget.index - 1].explanation),
              _Notes(widget.question.question.id!)
            ][selected],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String title, {required int index}) {
    final isSelected = selected == index;
    return InkWell(
      onTap: () => setState(() => selected = index),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: !isSelected ? Colors.teal : context.colors.primary,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(10.r)),
            border: isSelected
                ? const Border(
                    top: BorderSide(color: Colors.teal),
                    left: BorderSide(color: Colors.teal),
                    right: BorderSide(color: Colors.teal),
                  )
                : null),
        child: Text(
          title,
          style: context.textStyles.body1.copyWith(
            color: !isSelected ? context.colors.primary : Colors.teal,
          ),
        ),
      ),
    );
  }
}

class _Explination extends StatelessWidget {
  const _Explination(this.explication);

  final String? explication;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LinedText('Explication : '),
          height(12),
          const Divider(),
          height(5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Text(
              explication ?? 'Il n\'y a pas d\'explication',
              style: context.textStyles.h5.copyWith(
                color: context.colors.dark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Notes extends StatelessWidget {
  const _Notes(this.id);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Notes(questionId: id);
  }
}
