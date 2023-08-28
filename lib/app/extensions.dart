extension NonNullString on String? {
  String orEmpty() {
    if (this == null) return "";
    return this!;
  }
}

extension NonNullInteger on int? {
  int orZeros() {
    if (this == null) return 0;
    return this!;
  }
}

void text() {
  int x = 1;
  print(x.orZeros());
}
