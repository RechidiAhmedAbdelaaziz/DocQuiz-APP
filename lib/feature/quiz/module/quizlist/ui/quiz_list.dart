import 'package:app/core/extension/alertdialog.extenstion.dart';
import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/extension/snackbar.extension.dart';
import 'package:app/core/shared/widgets/lined_text.dart';
import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/home/logic/home.cubit.dart';
import 'package:app/feature/question/data/model/question.model.dart';
import 'package:app/feature/question/helper/question.route.dart';
import 'package:app/feature/quiz/data/models/quiz.model.dart';
import 'package:app/feature/quiz/module/quizlist/logic/quiz.cubit.dart';
import 'package:app/feature/quiz/module/quizlist/logic/quiz_list.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizListCubit, QuizListState>(
      listener: (context, state) {
        state.onError(context.showWarningSnackBar);
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: SectionBox(
            child: Column(
              children: [
                height(10),
                Row(
                  children: [
                    const LinedText('Mes Quiz'),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        context.read<HomeCubit>().showCreateQuiz();
                      },
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundColor: Colors.teal,
                        child: Icon(
                          Icons.add,
                          color: context.colors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                height(20),
                AppSearchBar(
                  onSearch: (value) {
                    context.read<QuizListCubit>().keyword = value;
                  },
                ),
                height(45),
                const QuizListWidget(),
                const _PageIndicator(),
              ],
            ),
          ),
        ),
      ),
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
        ...quizes.map(
          (q) {
            return BlocProvider.value(
              value: QuizCubit(q),
              child: const _QuizItem(),
            );
          },
        ),
      ],
    );
  }
}

class _QuizItem extends StatelessWidget {
  const _QuizItem();

  @override //create: (context) => QuizCubit(_quiz),
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final quiz = context.watch<QuizCubit>().state.quiz;
      final homeCubit = context.read<HomeCubit>();
      return Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding:
            EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
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
            _buildAnswersSlider(context, quiz),
            height(15),
            const Divider(),
            height(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  color: Colors.green,
                  icon: Icons.play_arrow_rounded,
                  onTap: () async {
                    final questions =
                        await context.to<List<QuestionResultModel?>>(
                            QuestionRoute.quiz(quiz));
                    if (questions != null) {
                      homeCubit.showQuestionsResult(
                          quiz.title!, questions);
                    }
                  },
                ),
                _buildActionButton(
                  color: Colors.orange,
                  icon: Icons.equalizer_outlined,
                  onTap: () =>
                      context.read<HomeCubit>().showQuizResult(quiz),
                ),
                _buildActionButton(
                  color: Colors.teal,
                  icon: Icons.edit,
                  onTap: () {
                    context.showPopUp(
                      content: _EditQuiz(
                        quiz,
                        onEdit: context.read<QuizCubit>().updateTitle,
                      ),
                    );
                  },
                ),
                _buildActionButton(
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    context.showDialogBox(
                      title: 'Supprimer le quiz',
                      body: 'Voulez-vous vraiment supprimer ce quiz?',
                      confirmText: 'Supprimer',
                      onConfirm: (back) {
                        context
                            .read<QuizListCubit>()
                            .removeQuiz(quiz);
                        back();
                      },
                      cancelText: 'Annuler',
                      onCancel: (back) => back(),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      );
    });
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

  Widget _buildAnswersSlider(BuildContext context, QuizModel quiz) {
    final answered = quiz.result!.answered! as int;
    final total = quiz.totalQuestions!;
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

class _EditQuiz extends StatelessWidget {
  _EditQuiz(this.quiz, {required this.onEdit})
      : controller = TextEditingController(
          text: quiz.title,
        );

  final QuizModel quiz;
  final TextEditingController controller;
  final void Function(String) onEdit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            width: 350.w,
            padding: EdgeInsets.symmetric(
                horizontal: 20.w, vertical: 22.h),
            decoration: BoxDecoration(
              color: context.colors.background,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: context.colors.dark.withOpacity(0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: context.colors.dark.withOpacity(0.3),
                  blurRadius: 7.r,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '  Nom du quiz',
                  style: context.textStyles.h4,
                ),
                height(10),
                TextField(
                  controller: controller,
                  style: context.textStyles.body1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(14.r)),
                    ),
                  ),
                ),
                height(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        onEdit(controller.text);
                        context.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colors.dark,
                        foregroundColor: context.colors.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        textStyle: context.textStyles.body1,
                      ),
                      child: const Text('Modifier'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MultiStageProgressBar extends StatelessWidget {
  final int correct;
  final int total;
  final int answerd;

  const MultiStageProgressBar({
    super.key,
    required this.answerd,
    required this.correct,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final width = 285.w;

    

    return Container(
      // height: 10.h,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Container(
            height: 20.h,
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
            height: 20.h,
            width: width * ((answerd - correct) / total),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key, this.onSearch});

  final ValueChanged<String>? onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: BorderRadius.circular(20.r),
        border:
            Border.all(color: context.colors.dark.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: context.colors.dark),
          width(10),
          Expanded(
            child: TextField(
              onSubmitted: onSearch,
              style: context.textStyles.body1.copyWith(
                color: context.colors.dark,
              ),
              decoration: InputDecoration(
                hintText: 'Rechercher un quiz',
                hintStyle: context.textStyles.body1.copyWith(
                  color: context.colors.dark.withOpacity(0.5),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator();

  @override
  Widget build(BuildContext context) {
    final page = context.watch<QuizListCubit>().page;
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: context.read<QuizListCubit>().prePage,
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
            onPressed: context.read<QuizListCubit>().nextPage,
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
