import 'package:flutter/material.dart';

final lightThemeData = ThemeData(
  fontFamily: 'Ubuntu',
  useMaterial3: true,
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: lightColorScheme.background,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: lightColorScheme.primary,
    ),
    actionsIconTheme: IconThemeData(
      color: lightColorScheme.secondary,
    ),
  ),
);

final darkThemeData = ThemeData(
  fontFamily: 'Ubuntu',
  useMaterial3: true,
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.background,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: darkColorScheme.primary,
    ),
    actionsIconTheme: IconThemeData(
      color: darkColorScheme.secondary,
    ),
  ),
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF7E5700),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFFFDEAB),
  onPrimaryContainer: Color(0xFF271900),
  secondary: Color(0xFF6E5C3F),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFF8DFBB),
  onSecondaryContainer: Color(0xFF261904),
  tertiary: Color(0xFF4E6543),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFD0EABF),
  onTertiaryContainer: Color(0xFF0C2006),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFFFBFF),
  onBackground: Color(0xFF1F1B16),
  surface: Color(0xFFFFFBFF),
  onSurface: Color(0xFF1F1B16),
  surfaceVariant: Color(0xFFEEE0CF),
  onSurfaceVariant: Color(0xFF4E4539),
  outline: Color(0xFF807667),
  onInverseSurface: Color(0xFFF8EFE7),
  inverseSurface: Color(0xFF34302A),
  inversePrimary: Color(0xFFFBBB43),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF7E5700),
  outlineVariant: Color(0xFFD2C5B4),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFFBBB43),
  onPrimary: Color(0xFF422C00),
  primaryContainer: Color(0xFF5F4100),
  onPrimaryContainer: Color(0xFFFFDEAB),
  secondary: Color(0xFFDBC3A1),
  onSecondary: Color(0xFF3C2E16),
  secondaryContainer: Color(0xFF54442A),
  onSecondaryContainer: Color(0xFFF8DFBB),
  tertiary: Color(0xFFB4CEA5),
  onTertiary: Color(0xFF213618),
  tertiaryContainer: Color(0xFF374D2D),
  onTertiaryContainer: Color(0xFFD0EABF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1F1B16),
  onBackground: Color(0xFFEAE1D9),
  surface: Color(0xFF1F1B16),
  onSurface: Color(0xFFEAE1D9),
  surfaceVariant: Color(0xFF4E4539),
  onSurfaceVariant: Color(0xFFD2C5B4),
  outline: Color(0xFF9A8F80),
  onInverseSurface: Color(0xFF1F1B16),
  inverseSurface: Color(0xFFEAE1D9),
  inversePrimary: Color(0xFF7E5700),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFFBBB43),
  outlineVariant: Color(0xFF4E4539),
  scrim: Color(0xFF000000),
);
