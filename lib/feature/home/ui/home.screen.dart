import 'dart:math';

import 'package:app/core/di/container.dart';
import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/themes/icons.dart';
import 'package:app/core/themes/spaces.dart';
import 'package:app/feature/auth/logic/auth.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:app/feature/themes/widget/switch_themes.dart';
import 'package:app/feature/updates/logic/updtes.cubit.dart';
import 'package:app/feature/updates/ui/updates.dart';
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
          onPressed: () => context.read<HomeCubit>().refresh(),
          child: const Icon(Icons.refresh, color: Colors.white),
        ),
        endDrawer: BlocProvider(
          create: (context) => UpdatesCubit()..fetchUpdates(),
          child: const NotificationBox(),
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
        width(12),
        _buildUpdatesButton(context),
        width(12),
        _buildProfileButton(context),
        width(10)
      ],
    );
  }

  Widget _buildUpdatesButton(BuildContext context) {
    return Stack(
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: IconButton(
            icon: Image.asset(
              'assets/png/new.png',
              height: 40.h,
              color: context.colors.dark,
             
            ),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ),
        // CircleAvatar(
        //   radius: 10.r,
        //   backgroundColor: context.colors.dark,
        // ),
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

  // Widget _buildProfileButton(BuildContext context) {
  //   return IconButton(
  //     icon: SvgPicture.asset(
  //       AppIcons.profile,
  //       height: 45.h,
  //     ),
  //     onPressed: () => context.read<HomeCubit>().showProfile(),
  //   );
  // }

  Widget _buildProfileButton(BuildContext context) {
    return PopupMenuButton(
      color: context.colors.background,
      itemBuilder: (_) {
        return [
          _buildPopupItem(
            context,
            title: 'Profile',
            icon: Icons.person,
            color: context.colors.dark,
            onTap: () => context.read<HomeCubit>().showProfile(),
            withDivider: true,
          ),
          _buildPopupItem(
            context,
            title: 'Logout',
            icon: Icons.logout,
            color: Colors.red,
            onTap: () => locator<AuthCubit>().onLogOut(),
          ),
        ];
      },
      child: SvgPicture.asset(
        AppIcons.profile,
        height: 45.h,
      ),
    );
  }

  PopupMenuItem _buildPopupItem(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
    IconData? icon,
    Color? color,
    bool withDivider = false,
  }) {
    return PopupMenuItem(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onTap();
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(icon, color: color),
                width(10),
                Text(title,
                    style: context.textStyles.body1
                        .copyWith(color: color)),
              ],
            ),
          ),
          // if (withDivider) ...[
          //   height(10),
          //   const Divider(),
          // ],
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // standard AppBar height
}
