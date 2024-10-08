part of 'themes.cubit.dart';

abstract class ThemesState {
  final ThemeData theme;
  ThemesState({required this.theme});

  bool get isDark => this is _DarkTheme;
}

class _DarkTheme extends ThemesState {
  _DarkTheme()
      : super(
          theme: ThemeData(
            primaryColor: locator<AppColors>().primary,
            scaffoldBackgroundColor: locator<AppColors>().background,
            fontFamily: 'Varela Round',
          ),
        );
}

class _LightTheme extends ThemesState {
  _LightTheme()
      : super(
          theme: ThemeData(
            primaryColor: locator<AppColors>().primary,
            scaffoldBackgroundColor: locator<AppColors>().background,
            fontFamily: 'Varela Round',
            // increase space between letters
          ),
        );
}
