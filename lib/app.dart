import 'package:app/core/di/container.dart';
import 'package:app/feature/firstpage/ui/first.screen.dart';
import 'package:app/feature/themes/logic/themes.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/router/router_generator.dart';

class DocQuizAPP extends StatelessWidget {
  const DocQuizAPP(this._router, {super.key});

  final AppRouter _router;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) =>
          BlocBuilder<ThemesCubit, ThemesState>(
        bloc: locator<ThemesCubit>(),
        builder: (context, state) {
          return MaterialApp(
            theme: state.theme,
            home: const FirstScreen(),
            onGenerateRoute: _router.generateRoute,
          );
        },
      ),
    );
  }
}
