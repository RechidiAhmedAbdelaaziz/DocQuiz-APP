import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/extension/snackbar.extension.dart';
import 'package:app/core/extension/to_time.extension.dart';
import 'package:app/core/shared/widgets/lined_text.dart';
import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/exam/data/model/exam.model.dart';
import 'package:app/feature/exam/logic/exam.cubit.dart';
import 'package:app/feature/home/logic/home.cubit.dart';
import 'package:app/feature/question/data/model/question.model.dart';
import 'package:app/feature/question/helper/question.route.dart';
import 'package:app/feature/quiz/module/quizlist/ui/quiz_list.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exams = context.watch<ExamCubit>().state.exams;
    return BlocListener<ExamCubit, ExamState>(
      listener: (context, state) {
        state.onError(context.showWarningSnackBar);
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: SectionBox(
          child: Column(
            children: [
              height(10),
              const LinedText('Les examens'),
              height(20),
              AppSearchBar(
                onSearch: (value) =>
                    context.read<ExamCubit>().keyword = value,
              ),
              height(35),
              ...exams.map((exam) => _ExamItem(exam)),
              const _PageIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExamItem extends StatelessWidget {
  final ExamModel exam;

  const _ExamItem(this.exam);

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: BorderRadius.circular(16.r),
        border:
            Border.all(color: context.colors.dark.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // Remove "Exam: " from the title
                child: Text(
                  exam.title!.replaceFirst('Exam: ', ''),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyles.h5,
                ),
              ),
              _buildActionButton(
                color: Colors.green,
                icon: Icons.play_arrow,
                onTap: () async {
                  final questions =
                      await context.to<List<QuestionResultModel?>>(
                          QuestionRoute.exam(exam));
                  if (questions != null) {
                    homeCubit.showQuestionsResult(
                        exam.title!, questions,
                        totalTemps: exam.time);
                  }
                },
              ),
            ],
          ),
          height(15),
          const Divider(),
          height(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.quiz_outlined,
                    color: Colors.blue,
                    size: 30.r,
                  ),
                  width(5),
                  Text(
                    '${exam.questions} questions',
                    style: context.textStyles.body1,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.orange,
                    size: 30.r,
                  ),
                  width(5),
                  Text(
                    exam.time!.toTimeHourMinute,
                    style: context.textStyles.body1,
                  ),
                ],
              ),
            ],
          ),
          height(5),
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
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 25.r,
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator();

  @override
  Widget build(BuildContext context) {
    final page = context.watch<ExamCubit>().page;
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: context.read<ExamCubit>().prevPage,
            icon: Icon(
              Icons.arrow_back_ios,
              color: page <= 1
                  ? context.colors.background
                  : context.colors.dark,
            ),
          ),
          width(23),
          CircleAvatar(
            backgroundColor: Colors.teal,
            child: Text(
              '$page',
              style: context.textStyles.h5.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          width(23),
          IconButton(
            onPressed: context.read<ExamCubit>().nextPage,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: context.colors.dark,
            ),
          ),
        ],
      ),
    );
  }
}
