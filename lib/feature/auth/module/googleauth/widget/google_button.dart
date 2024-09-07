import 'package:app/core/theme/icons.dart';
import 'package:app/feature/auth/module/googleauth/cubit/google_auth_cubit.dart';
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
        return InkWell(
          onTap: () {
            context.read<GoogleAuthCubit>().signIn();
          },
          child: CircleAvatar(
            child: SvgPicture.asset(AppIcons.google, height: 40.h),
          ),
        );
      }),
    );
  }
}
