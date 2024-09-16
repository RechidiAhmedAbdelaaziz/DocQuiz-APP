import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/quiz/data/models/quiz.model.dart';
import 'package:app/feature/quiz/module/quizlist/logic/quiz_list.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBox(
      child: QuizListWidget(),
    );
  }
}

class QuizListWidget extends StatelessWidget {
  const QuizListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final quizes = context.watch<QuizListCubit>().state.quizes;
    return Column(
      children: [
        ...quizes.map((q) => _QuizItem(q)),
      ],
    );
  }
}

class _QuizItem extends StatelessWidget {
  const _QuizItem(this.quiz, {super.key});

  final QuizModel quiz;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: BorderRadius.circular(12.r),
        border:
            Border.all(color: context.colors.dark.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Text(
            quiz.title!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: context.textStyles.h5,
          ),
          height(15),
          _buildAnswersSlider(context),
          height(15),
          const Divider(),
          height(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(
                color: Colors.green,
                icon: Icons.play_arrow_rounded,
                onTap: () {},
              ),
              _buildActionButton(
                color: Colors.orange,
                icon: Icons.equalizer_outlined,
                onTap: () {},
              ),
              _buildActionButton(
                color: Colors.blue,
                icon: Icons.edit,
                onTap: () {},
              ),
              _buildActionButton(
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildAnswersSlider(BuildContext context) {
    final answered = quiz.result!.answered! as int;
    final total = quiz.totalQuestions! as int;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            '${((answered / total) * 100).toStringAsFixed(2)}%',
            style: context.textStyles.body1,
          ),
        ),
        height(10),
        MultiStageProgressBar(
          answerd: answered,
          correct: 0,
          total: total,
        ),
      ],
    );
  }
}

class MultiStageProgressBar extends StatelessWidget {
  final int correct;
  final int total;
  final int answerd;

  MultiStageProgressBar({
    required this.answerd,
    required this.correct,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final width = 300.w;
    return Container(
      // height: 10.h,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            height: 24.h,
            width: width * (correct / total),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
              ),
            ),
          ),
          Container(
            height: 24.h,
            width: width * ((answerd - correct) / total),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
