import 'package:app/core/di/container.dart';
import 'package:app/core/theme/icons.dart';
import 'package:app/feature/auth/logic/auth.cubit.dart';
import 'package:app/feature/auth/module/googleauth/cubit/google_auth_cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoogleAuthCubit(),
      child: Builder(builder: (context) {
        return BlocListener<GoogleAuthCubit, GoogleAuthState>(
          listener: (context, state) {
            state.whenOrNull(
                success: (user) => locator<AuthCubit>().onAuthinit(user));
          },
          child: InkWell(
            onTap: () {
              context.read<GoogleAuthCubit>().signIn();
            },
            child: CircleAvatar(
              backgroundColor: context.colors.background,
              radius: 26.r,
              child: SvgPicture.asset(
                AppIcons.google,
                height: 70.h,
              ),
            ),
          ),
        );
      }),
    );
  }


  
}
