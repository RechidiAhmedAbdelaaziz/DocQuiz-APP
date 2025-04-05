import 'package:app/core/shared/widgets/lined_text.dart';
import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/themes/spaces.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/domains/logic/names.cubit.dart';
import 'package:app/feature/exam/logic/exam-record.cubit.dart';
import 'package:app/feature/home/logic/home.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamFilterScreen extends StatelessWidget {
  const ExamFilterScreen(
      {super.key, this.level, this.major, this.type});

  final LevelModel? level;
  final MajorModel? major;
  final String? type;

  @override
  Widget build(BuildContext context) {
    if (type != null || major != null) {
      return _build(BlocProvider(
        create: (context) => ExamRecordCubit()
          ..getExamRecords(major: major, type: type),
        child: _YearFilter(type: type, major: major),
      ));
    }

    if (level == null) {
      return _build(const _LevelsFilter());
    }
    return _build(_MajorFilter(level: level!));
  }

  Widget _build(Widget x) {
    return SingleChildScrollView(
      child: Column(
        children: [
          height(25),
          x,
        ],
      ),
    );
  }
}

class _YearFilter extends StatelessWidget {
  const _YearFilter({
    super.key,
    this.major,
    this.type,
  });

  final MajorModel? major;
  final String? type;

  @override
  Widget build(BuildContext context) {
    final years = context.watch<ExamRecordCubit>().state.years;
    return SectionBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  context.read<HomeCubit>().back();
                },
              ),
              const LinedText("Les Années"),
            ],
          ),
          height(22),
          for (final year in years)
            _FilterItem(
              title: year.toString(),
              onTap: () {
                context
                    .read<HomeCubit>()
                    .showExam(year: year, major: major, type: type);
              },
            ),
        ],
      ),
    );
  }
}

class _LevelsFilter extends StatelessWidget {
  const _LevelsFilter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NamesCubit<LevelModel, void>()..fetchAll(),
      child: Builder(builder: (context) {
        final levels =
            context.watch<NamesCubit<LevelModel, void>>().state.items;
        return SectionBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinedText("Les Niveaux"),
              height(22),
              ...levels.map(
                (level) {
                  return _FilterItem(
                    title: level.name,
                    onTap: () {
                      context
                          .read<HomeCubit>()
                          .showExamFilter(level: level);
                    },
                  );
                },
              ),
              const Divider(),
              ...["Résidanat", "Résidanat blanc"].map(
                (title) {
                  return _FilterItem(
                    title: title,
                    onTap: () {
                      context
                          .read<HomeCubit>()
                          .showExamFilter(type: title);
                    },
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _MajorFilter extends StatelessWidget {
  const _MajorFilter({super.key, required this.level});

  final LevelModel level;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NamesCubit<MajorModel, LevelModel>()..setParent = level,
      child: Builder(builder: (context) {
        final majors = context
            .watch<NamesCubit<MajorModel, LevelModel>>()
            .state
            .items;
        return SectionBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      context.read<HomeCubit>().showExamFilter();
                    },
                  ),
                  LinedText(level.name),
                ],
              ),
              height(22),
              ...majors.map(
                (major) {
                  return _FilterItem(
                    title: major.name,
                    onTap: () {
                      context
                          .read<HomeCubit>()
                          .showExamFilter(major: major);
                    },
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _FilterItem extends StatelessWidget {
  const _FilterItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding:
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          color: context.colors.background,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textStyles.h4,
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
