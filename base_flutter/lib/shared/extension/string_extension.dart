extension StringExt on String {
  bool isValidEmail() {
    if (isEmpty) {
      return false;
    }
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  bool equalsIgnoreCase(String? other) {
    if (other == null || other.isEmpty) {
      return false;
    }
    return toLowerCase() == other.toLowerCase();
  }

  bool containIgnoreCase(String? other) {
    if (other == null || other.isEmpty) {
      return false;
    }
    return toLowerCase().contains(other.toLowerCase());
  }
}
