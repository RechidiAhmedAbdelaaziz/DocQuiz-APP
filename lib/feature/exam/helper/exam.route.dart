import 'package:app/core/router/routebase.dart';
import 'package:app/feature/exam/logic/exam.cubit.dart';
import 'package:app/feature/exam/ui/exams.screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamRoute extends DrawerRoute {
  ExamRoute()
      : super(
          child: BlocProvider(
            create: (context) => ExamCubit()..fetchExams(),
            child: const ExamsScreen(),
          ),
        );
}
