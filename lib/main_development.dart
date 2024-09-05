import 'package:app/core/network/api.constants.dart';
import 'package:app/core/router/router_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';
import 'core/di/container.dart';

void main() async {
  // ensure flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // ensure screen size is initialized
  await ScreenUtil.ensureScreenSize();

  // dependency injection
  await setupLocator(baseUrl: ApiConstiants.DEV_BASE_URL);

  runApp(const DocQuizAPP(AppRouter()));
}
