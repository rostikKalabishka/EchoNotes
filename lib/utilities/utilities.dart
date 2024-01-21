class Utilities {
  String? textFieldValidator(String val) {
    if (val.isEmpty) {
      return 'Please fill in this field';
    }

    return null;
  }
}
