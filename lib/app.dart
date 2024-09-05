import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/router/router_generator.dart';

class DocQuizAPP extends StatelessWidget {
  const DocQuizAPP(this._router, {super.key});

  final AppRouter _router;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        onGenerateRoute: _router.generateRoute,
      ),
    );
  }
}
