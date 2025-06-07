import 'package:consumer/config/theme/palette.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Define primary color scheme
  static final FlexSchemeColor _flexColors = FlexSchemeColor.from(
    primary: Palette.primary,
    secondary: Palette.secondary,
    tertiary: Palette.tertiary,
  );

  static final FlexSubThemesData commonTheme = FlexSubThemesData(
    blendOnLevel: 2,
    useMaterial3Typography: true,
    outlinedButtonRadius: 7.5,
    textButtonRadius: 7.5,
    filledButtonRadius: 7.5,
    appBarBackgroundSchemeColor: SchemeColor.primary,
    elevatedButtonRadius: 7.5,
    outlinedButtonOutlineSchemeColor: SchemeColor.primary,
    inputDecoratorBorderSchemeColor: SchemeColor.secondary,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    inputDecoratorBorderWidth: 1,
    inputDecoratorContentPadding: EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 18,
    ),
    inputDecoratorFocusedBorderWidth: 1.25,
    inputDecoratorFocusedHasBorder: true,
    inputDecoratorIsDense: true,
    inputDecoratorIsFilled: true,
    inputDecoratorPrefixIconSchemeColor: SchemeColor.secondary,
    inputDecoratorRadius: 7.5,
    inputDecoratorRadiusAdaptive: 6,
    inputDecoratorSuffixIconSchemeColor: SchemeColor.secondary,
    inputDecoratorUnfocusedBorderIsColored: true,
    inputDecoratorUnfocusedHasBorder: true,
    appBarCenterTitle: true,
  );

  // Define common text theme
  static TextTheme getTextTheme(Color textColor) {
    return ThemeData().textTheme.copyWith(
      displayLarge: TextStyle(color: textColor),
      displayMedium: TextStyle(color: textColor),
      displaySmall: TextStyle(color: textColor),
      headlineLarge: TextStyle(color: textColor),
      headlineMedium: TextStyle(color: textColor),
      headlineSmall: TextStyle(color: textColor),
      titleLarge: TextStyle(color: textColor),
      titleMedium: TextStyle(color: textColor),
      titleSmall: TextStyle(color: textColor),
      bodyLarge: TextStyle(color: textColor),
      bodyMedium: TextStyle(color: textColor),
      bodySmall: TextStyle(color: textColor),
      labelLarge: TextStyle(color: textColor),
      labelMedium: TextStyle(color: textColor),
      labelSmall: TextStyle(color: textColor),
    );
  }

  static ThemeData lightTheme = FlexColorScheme.light(
    colors: _flexColors,
    useMaterial3: true,
    appBarStyle: FlexAppBarStyle.surface,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    subThemesData: commonTheme,
    scaffoldBackground: Palette.backgroundLight,
    textTheme: getTextTheme(Palette.textLight),
    error: Palette.error,
    visualDensity: VisualDensity.comfortable,
    fontFamily: 'Inter',
  ).toTheme.copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {TargetPlatform.android: FadeForwardsPageTransitionsBuilder()},
    ),
    iconTheme: IconThemeData(size: 30),
  );

  static ThemeData darkTheme = FlexColorScheme.dark(
    colors: _flexColors.toDark(),
    useMaterial3: true,
    appBarStyle: FlexAppBarStyle.background,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    subThemesData: commonTheme,
    scaffoldBackground: Palette.backgroundDark,
    textTheme: getTextTheme(Palette.textDark),
    error: Palette.error,
    visualDensity: VisualDensity.comfortable,
    fontFamily: 'Inter',
  ).toTheme.copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {TargetPlatform.android: FadeForwardsPageTransitionsBuilder()},
    ),
    iconTheme: IconThemeData(size: 30),
  );
}
