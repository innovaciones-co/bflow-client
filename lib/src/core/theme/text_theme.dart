import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme(BuildContext context) {
  var textTheme = Theme.of(context).textTheme;
  return GoogleFonts.robotoTextTheme(textTheme).copyWith(
    displayLarge: GoogleFonts.robotoCondensed(),
    displayMedium: GoogleFonts.robotoCondensed(),
    displaySmall: GoogleFonts.robotoCondensed(),
    bodyLarge: GoogleFonts.oswald(),
    bodyMedium: GoogleFonts.oswald(),
    bodySmall: GoogleFonts.oswald(),
  );
}
