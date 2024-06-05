enum AppFonts {
  rubikMoonrocks,
  roboto;

  String get fontName {
    switch (this) {
      case AppFonts.rubikMoonrocks:
        return 'RubikMoonrocks';
      case AppFonts.roboto:
        return 'Roboto';
    }
  }
}
