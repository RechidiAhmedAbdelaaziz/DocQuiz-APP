import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/dashboard/logic/dashboard.cubit.dart';
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
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: const _Dashboard(),
    );
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
      builder: (context) => _Statistics(statistics!),
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
          value: statistics.totalUser.toString(),
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
