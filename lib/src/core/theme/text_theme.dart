import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme(BuildContext context) {
  var textTheme = Theme.of(context).textTheme;
  return GoogleFonts.figtreeTextTheme(textTheme).copyWith(
    displayLarge: GoogleFonts.robotoCondensed(),
    displayMedium: GoogleFonts.robotoCondensed(),
    displaySmall: GoogleFonts.robotoCondensed(),
    headlineLarge: GoogleFonts.robotoCondensed(),
    headlineMedium: GoogleFonts.robotoCondensed(),
    headlineSmall: GoogleFonts.robotoCondensed(),
    titleLarge: GoogleFonts.figtree(),
    titleMedium: GoogleFonts.figtree(),
    titleSmall: GoogleFonts.figtree(),
    bodyLarge: GoogleFonts.figtree(),
    bodyMedium: GoogleFonts.figtree(),
    bodySmall: GoogleFonts.figtree(),
    labelLarge: GoogleFonts.figtree(),
    labelMedium: GoogleFonts.figtree(),
    labelSmall: GoogleFonts.figtree(),
  );
}
