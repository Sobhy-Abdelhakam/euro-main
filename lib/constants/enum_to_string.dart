extension EnumToString on Enum {
  String valueToString() {
    return toString().split(".").last;
  }
}
