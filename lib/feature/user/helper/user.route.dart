import 'package:app/core/router/abstract_route.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/domains/logic/names.cubit.dart';
import 'package:app/feature/user/module/selectdomain/logic/set_domain.cubit.dart';
import 'package:app/feature/user/module/selectdomain/ui/set_domain.screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRoute extends RouteBase {
  static const String profileRoute = '/user';
  static const String setDominRoute = '/user/set-domain';

  UserRoute.setDomin()
      : super(
          setDominRoute,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SetDomainCubit()..checkExist(),
              ),
              BlocProvider(
                create: (context) =>
                    NamesCubit<DomainModel, void>()..fetchAll(),
              ),
              BlocProvider(
                create: (context) =>
                    NamesCubit<LevelModel, DomainModel>(),
              ),
            ],
            child: const SetDomainScreen(),
          ),
        );
}
