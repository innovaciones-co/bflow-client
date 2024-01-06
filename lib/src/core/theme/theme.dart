import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;
  bool isLight = true;

  MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff004da5),
      surfaceTint: Color(0xff005bc0),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1171e7),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3e5f90),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffb3cfff),
      onSecondaryContainer: Color(0xff153b6a),
      tertiary: Color(0xff73594e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffe0d4),
      onTertiaryContainer: Color(0xff5d453b),
      error: Color(0xffa40025),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffdd2d42),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xffffffff),
      onBackground: Color(0xff191c23),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff191c23),
      surfaceVariant: Color(0xffdee2f2),
      onSurfaceVariant: Color(0xff414754),
      outline: Color(0xff727785),
      outlineVariant: Color(0xffc1c6d6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3038),
      inverseOnSurface: Color(0xffeff0fa),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff004493),
      secondaryFixed: Color(0xffd5e3ff),
      onSecondaryFixed: Color(0xff001b3b),
      secondaryFixedDim: Color(0xffa7c8ff),
      onSecondaryFixedVariant: Color(0xff244776),
      tertiaryFixed: Color(0xffffdbcd),
      onTertiaryFixed: Color(0xff2a170f),
      tertiaryFixedDim: Color(0xffe2bfb2),
      onTertiaryFixedVariant: Color(0xff594137),
      surfaceDim: Color(0xffd8d9e4),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f3fd),
      surfaceContainer: Color(0xffecedf8),
      surfaceContainerHigh: Color(0xffe6e8f2),
      surfaceContainerHighest: Color(0xffe0e2ec),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00408b),
      surfaceTint: Color(0xff005bc0),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1171e7),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1f4372),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5576a8),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff553d34),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff8b6e63),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8b001e),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffdd2d42),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff9f9ff),
      onBackground: Color(0xff191c23),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff191c23),
      surfaceVariant: Color(0xffdee2f2),
      onSurfaceVariant: Color(0xff3d4350),
      outline: Color(0xff5a5f6d),
      outlineVariant: Color(0xff757a89),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3038),
      inverseOnSurface: Color(0xffeff0fa),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xff1171e7),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff0058bb),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5576a8),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3b5d8d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff8b6e63),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff70564b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd8d9e4),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f3fd),
      surfaceContainer: Color(0xffecedf8),
      surfaceContainerHigh: Color(0xffe6e8f2),
      surfaceContainerHighest: Color(0xffe0e2ec),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00214d),
      surfaceTint: Color(0xff005bc0),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00408b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff002247),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff1f4372),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff311d15),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff553d34),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4d000c),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8b001e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff9f9ff),
      onBackground: Color(0xff191c23),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdee2f2),
      onSurfaceVariant: Color(0xff1f2430),
      outline: Color(0xff3d4350),
      outlineVariant: Color(0xff3d4350),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3038),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffe6ecff),
      primaryFixed: Color(0xff00408b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff002b61),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff1f4372),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff002d5a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff553d34),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3d281f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd8d9e4),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f3fd),
      surfaceContainer: Color(0xffecedf8),
      surfaceContainerHigh: Color(0xffe6e8f2),
      surfaceContainerHighest: Color(0xffe0e2ec),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffadc6ff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff002e68),
      primaryContainer: Color(0xff1171e7),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xffe4ecff),
      onSecondary: Color(0xff04305f),
      secondaryContainer: Color(0xffa2c3fa),
      onSecondaryContainer: Color(0xff083361),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff412b22),
      tertiaryContainer: Color(0xfff0cdbf),
      onTertiaryContainer: Color(0xff513a30),
      error: Color(0xffffb3b2),
      onError: Color(0xff680014),
      errorContainer: Color(0xffdd2d42),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xff10131a),
      onBackground: Color(0xffe0e2ec),
      surface: Color(0xff10131a),
      onSurface: Color(0xffe0e2ec),
      surfaceVariant: Color(0xff414754),
      onSurfaceVariant: Color(0xffc1c6d6),
      outline: Color(0xff8b909f),
      outlineVariant: Color(0xff414754),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2ec),
      inverseOnSurface: Color(0xff2d3038),
      inversePrimary: Color(0xff005bc0),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff004493),
      secondaryFixed: Color(0xffd5e3ff),
      onSecondaryFixed: Color(0xff001b3b),
      secondaryFixedDim: Color(0xffa7c8ff),
      onSecondaryFixedVariant: Color(0xff244776),
      tertiaryFixed: Color(0xffffdbcd),
      onTertiaryFixed: Color(0xff2a170f),
      tertiaryFixedDim: Color(0xffe2bfb2),
      onTertiaryFixedVariant: Color(0xff594137),
      surfaceDim: Color(0xff10131a),
      surfaceBright: Color(0xff363941),
      surfaceContainerLowest: Color(0xff0b0e15),
      surfaceContainerLow: Color(0xff191c23),
      surfaceContainer: Color(0xff1d2027),
      surfaceContainerHigh: Color(0xff272a31),
      surfaceContainerHighest: Color(0xff32353c),
    );
  }

  ThemeData dark() {
    isLight = false;
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb3cbff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff001537),
      primaryContainer: Color(0xff4a8eff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe4ecff),
      onSecondary: Color(0xff04305f),
      secondaryContainer: Color(0xffa2c3fa),
      onSecondaryContainer: Color(0xff000a1c),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff412b22),
      tertiaryContainer: Color(0xfff0cdbf),
      onTertiaryContainer: Color(0xff2e1b12),
      error: Color(0xffffb9b8),
      onError: Color(0xff370006),
      errorContainer: Color(0xffff525f),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff10131a),
      onBackground: Color(0xffe0e2ec),
      surface: Color(0xff10131a),
      onSurface: Color(0xfffbfaff),
      surfaceVariant: Color(0xff414754),
      onSurfaceVariant: Color(0xffc6cada),
      outline: Color(0xff9ea3b2),
      outlineVariant: Color(0xff7e8392),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2ec),
      inverseOnSurface: Color(0xff272a31),
      inversePrimary: Color(0xff004595),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff00102d),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff003473),
      secondaryFixed: Color(0xffd5e3ff),
      onSecondaryFixed: Color(0xff001129),
      secondaryFixedDim: Color(0xffa7c8ff),
      onSecondaryFixedVariant: Color(0xff0e3665),
      tertiaryFixed: Color(0xffffdbcd),
      onTertiaryFixed: Color(0xff1e0d06),
      tertiaryFixedDim: Color(0xffe2bfb2),
      onTertiaryFixedVariant: Color(0xff473128),
      surfaceDim: Color(0xff10131a),
      surfaceBright: Color(0xff363941),
      surfaceContainerLowest: Color(0xff0b0e15),
      surfaceContainerLow: Color(0xff191c23),
      surfaceContainer: Color(0xff1d2027),
      surfaceContainerHigh: Color(0xff272a31),
      surfaceContainerHighest: Color(0xff32353c),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffbfaff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb3cbff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffbfaff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffaeccff),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfff0cdbf),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffb9b8),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff10131a),
      onBackground: Color(0xffe0e2ec),
      surface: Color(0xff10131a),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff414754),
      onSurfaceVariant: Color(0xfffbfaff),
      outline: Color(0xffc6cada),
      outlineVariant: Color(0xffc6cada),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2ec),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff00285c),
      primaryFixed: Color(0xffdee7ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb3cbff),
      onPrimaryFixedVariant: Color(0xff001537),
      secondaryFixed: Color(0xffdce7ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffaeccff),
      onSecondaryFixedVariant: Color(0xff001632),
      tertiaryFixed: Color(0xffffe1d5),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffe6c3b6),
      onTertiaryFixedVariant: Color(0xff23120a),
      surfaceDim: Color(0xff10131a),
      surfaceBright: Color(0xff363941),
      surfaceContainerLowest: Color(0xff0b0e15),
      surfaceContainerLow: Color(0xff191c23),
      surfaceContainer: Color(0xff1d2027),
      surfaceContainerHigh: Color(0xff272a31),
      surfaceContainerHighest: Color(0xff32353c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
        appBarTheme: _abbBarTheme(),
      );

  AppBarTheme _abbBarTheme() {
    return AppBarTheme(
      color: isLight
          ? MaterialTheme.black.light.colorContainer
          : MaterialTheme.black.dark.colorContainer,
      foregroundColor: isLight
          ? MaterialTheme.black.light.onColor
          : MaterialTheme.black.dark.onColorContainer,
    );
  }

  /// Success
  static const success = ExtendedColor(
    seed: Color(0xff00a650),
    value: Color(0xff00a650),
    light: ColorFamily(
      color: Color(0xff006d32),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff25b45c),
      onColorContainer: Color(0xff001405),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff006d32),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff25b45c),
      onColorContainer: Color(0xff001405),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff006d32),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff25b45c),
      onColorContainer: Color(0xff001405),
    ),
    dark: ColorFamily(
      color: Color(0xff5adf81),
      onColor: Color(0xff003917),
      colorContainer: Color(0xff008740),
      onColorContainer: Color(0xffffffff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff5adf81),
      onColor: Color(0xff003917),
      colorContainer: Color(0xff008740),
      onColorContainer: Color(0xffffffff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff5adf81),
      onColor: Color(0xff003917),
      colorContainer: Color(0xff008740),
      onColorContainer: Color(0xffffffff),
    ),
  );

  /// Alert
  static const alert = ExtendedColor(
    seed: Color(0xffff7733),
    value: Color(0xffff7733),
    light: ColorFamily(
      color: Color(0xffa33e00),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffff8a54),
      onColorContainer: Color(0xff3c1200),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xffa33e00),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffff8a54),
      onColorContainer: Color(0xff3c1200),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xffa33e00),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffff8a54),
      onColorContainer: Color(0xff3c1200),
    ),
    dark: ColorFamily(
      color: Color(0xffffb596),
      onColor: Color(0xff581e00),
      colorContainer: Color(0xfff6702c),
      onColorContainer: Color(0xff0f0200),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffb596),
      onColor: Color(0xff581e00),
      colorContainer: Color(0xfff6702c),
      onColorContainer: Color(0xff0f0200),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffb596),
      onColor: Color(0xff581e00),
      colorContainer: Color(0xfff6702c),
      onColorContainer: Color(0xff0f0200),
    ),
  );

  /// Dark
  static const black = ExtendedColor(
    seed: Color(0xff202020),
    value: Color(0xff202020),
    light: ColorFamily(
      color: Color(0xff0c0d0d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff2d2d2d),
      onColorContainer: Color(0xffbcb9b9),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff0c0d0d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff2d2d2d),
      onColorContainer: Color(0xffbcb9b9),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff0c0d0d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff2d2d2d),
      onColorContainer: Color(0xffbcb9b9),
    ),
    dark: ColorFamily(
      color: Color(0xffc8c6c5),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff181818),
      onColorContainer: Color(0xffa5a3a3),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffc8c6c5),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff181818),
      onColorContainer: Color(0xffa5a3a3),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffc8c6c5),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff181818),
      onColorContainer: Color(0xffa5a3a3),
    ),
  );

  List<ExtendedColor> get extendedColors => [
        success,
        alert,
        black,
      ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
