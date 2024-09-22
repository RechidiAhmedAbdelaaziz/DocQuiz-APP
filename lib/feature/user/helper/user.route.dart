import 'package:app/core/router/abstract_route.dart';
import 'package:app/core/router/routebase.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/domains/logic/names.cubit.dart';
import 'package:app/feature/user/module/profile/logic/profile.cubit.dart';
import 'package:app/feature/user/module/profile/ui/profile.screen.dart';
import 'package:app/feature/user/module/selectdomain/logic/set_domain.cubit.dart';
import 'package:app/feature/user/module/selectdomain/ui/set_domain.screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DomainRoute extends RouteBase {
  static const String setDominRoute = '/user/set-domain';

  DomainRoute.setDomin()
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

class ProfileRoute extends DrawerRoute {
  ProfileRoute()
      : super(
            child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProfileCubit()..fetchProfile(),
            ),
            BlocProvider(
              create: (context) =>
                  NamesCubit<DomainModel, void>()..fetchAll(),
            ),
            BlocProvider(
              create: (context) =>
                  NamesCubit<LevelModel, DomainModel>()
                    ..setParent = context.read<ProfileCubit>().domain,
            ),
          ],
          child: const ProfileScreen(),
        ));
}
