enum AppFonts {
  rubikMoonrocks,
  roboto,
}

extension AppFontsExt on AppFonts {
  String get fontName {
    switch (this) {
      case AppFonts.rubikMoonrocks:
        return 'RubikMoonrocks';
      case AppFonts.roboto:
        return 'Roboto';
    }
  }
}
