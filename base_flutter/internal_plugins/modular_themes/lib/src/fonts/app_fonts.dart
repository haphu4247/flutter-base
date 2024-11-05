enum AppFonts {
  rubikMoonrocks,
  roboto;

  String get fontName {
    switch (this) {
      case AppFonts.rubikMoonrocks:
        return 'RubikMoonrocks';
      default:
        return 'Roboto';
    }
  }
}
