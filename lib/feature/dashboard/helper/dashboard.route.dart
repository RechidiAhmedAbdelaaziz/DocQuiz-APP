import 'package:app/core/router/routebase.dart';
import 'package:app/feature/dashboard/logic/dashboard.cubit.dart';
import 'package:app/feature/dashboard/widget/dashboard.widget.dart';
import 'package:app/feature/quiz/module/quizlist/logic/quiz_list.cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardRoute extends DrawerRoute {
  DashboardRoute()
      : super(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: DashboardCubit()..getDashboard(),
              ),
              BlocProvider.value(
                value: QuizListCubit()..fetchQuizes(limit: 4),
              ),
            ],
            child: const Dashboard(),
          ),
        );
}
