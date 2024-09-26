import 'package:app/core/extension/to_time.extension.dart';
import 'package:app/core/shared/widgets/lined_text.dart';
import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/quiz/module/quizlist/ui/quiz_list.dart';
import 'package:app/feature/quizresult/data/model/quiz_result.model.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen(this.result, {super.key});

  final QuizResultModel result;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: SectionBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const LinedText('Récapitulatif'),
            height(20),
            Text(
              result.title,
              style: context.textStyles.h3,
            ),
            const Divider(),
            height(20),
            Text(
              'Temps consommé: ${result.time.toTimeMinuteSecond} ',
              style: context.textStyles.h5,
            ),
            height(5),
            Text(
              'Temps correct: ${result.correctTime.toTimeMinuteSecond} ',
              style: context.textStyles.h5,
            ),
            height(5),
            // question reste
            Text(
              'Questions restantes: ${result.unAnswered} questions',
              style: context.textStyles.h5,
            ),
            height(45),
            Center(
              child: MultiStageProgressBar(
                answerd: result.totalQuestions - result.unAnswered,
                correct: result.correctAnswers,
                total: result.totalQuestions,
              ),
            ),
            height(40),
            _buildInfo(
              context,
              title: 'Questions',
              color: context.colors.dark,
              value: result.totalQuestions,
              percent: 100,
            ),
            height(10),
            _buildInfo(
              context,
              title: 'Réponses correctes',
              color: Colors.green,
              value: result.correctAnswers,
              percent: (result.correctAnswers /
                  result.totalQuestions *
                  100),
            ),
            height(10),
            _buildInfo(
              context,
              title: 'Réponses incorrectes',
              color: Colors.red,
              value: result.wrongAnswers,
              percent:
                  (result.wrongAnswers / result.totalQuestions * 100),
            ),
            height(10),
            _buildInfo(
              context,
              title: 'Non répondues',
              color: Colors.grey,
              value: result.unAnswered,
              percent:
                  (result.unAnswered / result.totalQuestions * 100),
            ),
            height(40),
          ],
        ),
      ),
    );
  }

  Row _buildInfo(
    BuildContext context, {
    required String title,
    required Color color,
    required int value,
    required double percent,
  }) {
    return Row(
      children: [
        Icon(Icons.square_rounded, color: color),
        width(10),
        Text(
          '$title: $value ( ${percent.toStringAsFixed(0)} % )',
          style: context.textStyles.h4,
        ),
      ],
    );
  }
}
