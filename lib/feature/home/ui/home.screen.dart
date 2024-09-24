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
    return PopScope(
      onPopInvokedWithResult: (_, __) => {
        context.read<HomeCubit>().back(),
      },
      child: Scaffold(
        appBar: const _AppBar(),
        body: body,
        drawer: const _Drawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r)),
          onPressed: () => context.read<HomeCubit>().refresh(),
          child: const Icon(Icons.refresh, color: Colors.white),
        ),
      ),
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
        _buildProfileButton(context),
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

  Widget _buildProfileButton(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        AppIcons.profile,
        height: 45.h,
      ),
      onPressed: () => context.read<HomeCubit>().showProfile(),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // standard AppBar height
}
