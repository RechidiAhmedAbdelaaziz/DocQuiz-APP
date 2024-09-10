import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/theme/icons.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:app/feature/themes/widget/switch_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../logic/home.cubit.dart';

part 'drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final body = context.watch<HomeCubit>().state.child;
    return Scaffold(
      appBar: const _AppBar(),
      body: body,
      drawer: const _Drawer(),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.primary,
      leading: _buildDrawerButton(context),
      actions: [
        const SwitchThemesButton(),
        width(20),
      ],
    );
  }

  Widget _buildDrawerButton(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        AppIcons.menu,
        colorFilter:
            ColorFilter.mode(context.colors.dark, BlendMode.srcIn),
        height: 30.h,
      ),
      onPressed: Scaffold.of(context).openDrawer,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // standard AppBar height
}
