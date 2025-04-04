import 'package:app/core/router/routebase.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/exam/logic/exam.cubit.dart';
import 'package:app/feature/exam/ui/exam_filter.screen.dart';
import 'package:app/feature/exam/ui/exams.screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamRoute extends DrawerRoute {
  ExamRoute({
    MajorModel? major,
    String? type,
    required int year,
  }) : super(
          child: BlocProvider(
            create: (context) => ExamCubit(
              majorId: major?.id,
              type: type,
              year: year,
            )..fetchExams(),
            child: const ExamsScreen(),
          ),
        );

  ExamRoute.filter(
    LevelModel? level,
    MajorModel? major,
    String? type,
  ) : super(
          child: ExamFilterScreen(
            level: level,
            major: major,
            type: type,
          ),
        );
}
