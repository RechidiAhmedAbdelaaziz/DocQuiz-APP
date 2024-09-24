part of 'question.screen.dart';

class _Progress extends StatelessWidget {
  const _Progress({super.key});

  @override
  Widget build(BuildContext context) {
    final max = context.watch<QuestionCubit>().state.max;
    return Drawer(
      backgroundColor: context.colors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height(25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              width(20),
              const LinedText('Progress'),
              const Spacer(),
              IconButton(
                onPressed: () => context.back(),
                icon: Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 35.sp,
                ),
              ),
              width(20),
            ],
          ),
          height(25),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Wrap(
                spacing: 12.w,
                runSpacing: 15.h,
                alignment: WrapAlignment.start,
                children: List.generate(max, (index) {
                  final state = context.watch<QuestionCubit>().state;
                  final color = state.isCorrect(index)
                      ? Colors.green
                      : Colors.red;

                  return InkWell(
                    onTap: () {
                      context.read<QuestionCubit>().toQuestion(index);
                      Navigator.of(context).pop();
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 50.r,
                          height: 50.r,
                          decoration: BoxDecoration(
                            color: state.isAnswered(index)
                                ? color
                                : null,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: state.isAnswered(index)
                                  ? color
                                  : context.colors.dark,
                              width: 2.w,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 1}',
                            style: context.textStyles.h5.copyWith(
                              color: state.isAnswered(index)
                                  ? Colors.white
                                  : context.colors.dark,
                            ),
                          ),
                        ),
                        state.isCurrent(index)
                            ? Container(
                                width: 22.w,
                                height: 3.h,
                                margin: EdgeInsets.only(top: 5.h),
                                color: context.colors.dark,
                              )
                            : height(8),
                      ],
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
