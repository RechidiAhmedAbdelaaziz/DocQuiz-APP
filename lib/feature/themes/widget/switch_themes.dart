import 'package:app/core/di/container.dart';
import 'package:app/core/theme/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../logic/themes.cubit.dart';

class SwitchThemesButton extends StatelessWidget {
  const SwitchThemesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemesState>(
      bloc: locator<ThemesCubit>(),
      builder: (context, state) {
        return InkWell(
          onTap: locator<ThemesCubit>().toggleTheme,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              state.isDark ? AppIcons.light : AppIcons.dark,
              height: 30.h,
              colorFilter: ColorFilter.mode(
                  state.isDark ? Colors.yellow : Colors.black,
                  BlendMode.srcIn),
            ),
          ),
        );
      },
    );
  }
}
