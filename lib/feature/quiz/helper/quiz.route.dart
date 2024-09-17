import 'package:app/core/router/abstract_route.dart';
import 'package:app/core/router/routebase.dart';
import 'package:app/feature/quiz/module/createquiz/logic/create_quiz.cubit.dart';
import 'package:app/feature/quiz/module/createquiz/ui/create_quiz.screen.dart';
import 'package:app/feature/quiz/module/quizlist/logic/quiz_list.cubit.dart';
import 'package:app/feature/quiz/module/quizlist/ui/quiz_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyQuizRoute extends DrawerRoute {
  MyQuizRoute()
      : super(
          child: BlocProvider(
            create: (context) => QuizListCubit()..fetchQuizes(),
            child: const QuizListScreen(),
          ),
        );
}

class CreateQuizRoute extends RouteBase {
  static const route = '/create-quiz';
  CreateQuizRoute()
      : super(route,
            child: BlocProvider(
              create: (context) => CreateQuizCubit(),
              child: const CreateQuizScreen(),
            ));
}
