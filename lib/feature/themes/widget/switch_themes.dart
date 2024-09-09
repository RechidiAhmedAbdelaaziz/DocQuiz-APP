import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/themes.cubit.dart';

class SwitchThemesButton extends StatelessWidget {
  const SwitchThemesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.brightness_4,
        color:
            context.read<ThemesCubit>().state.theme.iconTheme.color,
      ),
      onPressed: () {
        context.read<ThemesCubit>().toggleTheme();
      },
    );
  }
}
