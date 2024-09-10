// ignore_for_file: constant_identifier_names

import 'package:app/core/router/abstract_route.dart';
import 'package:app/feature/home/logic/home.cubit.dart';
import 'package:app/feature/home/ui/home.screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeRoute extends RouteBase {
  static const PATH = '/home';

  HomeRoute()
      : super(
          PATH,
          child: BlocProvider(
            create: (context) => HomeCubit(),
            child: const HomeScreen(),
          ),
        );
}
