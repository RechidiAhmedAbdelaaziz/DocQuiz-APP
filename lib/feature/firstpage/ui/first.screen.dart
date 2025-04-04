import 'package:app/core/di/container.dart';
import 'package:app/core/extension/alertdialog.extenstion.dart';
import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/feature/auth/data/source/auth.cache.dart';
import 'package:app/feature/auth/helper/auth.router.dart';
import 'package:app/feature/auth/logic/auth.cubit.dart';
import 'package:app/feature/home/helper/home.route.dart';
import 'package:app/feature/user/helper/user.route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: locator<AuthCubit>()..onAppStarted(),
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (user) async {
            context.backToRoot();
            (user?.domain == null &&
                    await locator<AuthCache>().domain == null)
                ? context.to(DomainRoute.setDomin(user),
                    canPop: false)
                : context.to(HomeRoute(), canPop: false);
          },
          unauthenticated: () {
            context.backToRoot();
            context.to(AuthRoute.login(), canPop: false);
          },
          sessionExpired: () {
            context.showDialogBox(
              // in french
              title: 'Session expirée',
              body:
                  'Votre session a expirée, veuillez vous reconnecter',
              confirmText: 'Se reconnecter',
              onConfirm: (back) => back(),
            );
          },
        );
      },
      child: const Scaffold(),
    );
  }
}
