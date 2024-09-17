import 'package:app/core/shared/widgets/lined_text.dart';
import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/dashboard/logic/dashboard.cubit.dart';
import 'package:app/feature/home/logic/home.cubit.dart';
import 'package:app/feature/quiz/module/quizlist/ui/quiz_list.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/models/statistics.model.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Dashboard();
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard();

  @override
  Widget build(BuildContext context) {
    final statistics = context
        .select((DashboardCubit cubit) => cubit.state.statistics);

    return ConditionalBuilder(
      condition: statistics != null,
      builder: (context) => SingleChildScrollView(
        child: Column(
          children: [
            _Statistics(statistics!),
            height(20),
            SectionBox(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LinedText('Recent Quizes'),
                height(20),
                const QuizListWidget(),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      context.read<HomeCubit>().showMyQuiz();
                    },
                    child: Text(
                      'Voire plus',
                      style: context.theme.textStyles.h5
                          .copyWith(color: context.theme.colors.dark),
                    ),
                  ),
                )
              ],
            )),
            height(20)
          ],
        ),
      ),
      fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
    );
  }
}

class _Statistics extends StatelessWidget {
  const _Statistics(this.statistics);

  final StatisticsModel statistics;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        height(20),
        _StatisticItem(
          title: 'MODULES',
          color: Colors.blue,
          value: statistics.totalMajor.toString(),
        ),
        _StatisticItem(
          title: 'QUESTIONS',
          color: Colors.green,
          value: statistics.totalQuestion.toString(),
        ),
        _StatisticItem(
          title: 'FAITS AUJOURD\'HUI',
          color: Colors.orange,
          value: statistics.doneToday.toString(),
        ),
      ],
    );
  }
}

class _StatisticItem extends StatelessWidget {
  const _StatisticItem({
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: context.theme.textStyles.h2
                .copyWith(color: Colors.white),
          ),
          height(5),
          Text(
            value,
            style: context.theme.textStyles.h2
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
