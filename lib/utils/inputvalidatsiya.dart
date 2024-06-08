abstract class Validate {
  static passportSerialNumber(String serialNumber) {
    // Define the regular expression pattern
    String pattern = r'^[A-Z]{2}\d{7}$';
    // Create a RegExp object
    RegExp regExp = RegExp(pattern);
    // Check if the input string matches the pattern
    return regExp.hasMatch(serialNumber);
  }

  static phone(String phoneNumber) {
    // Define the regular expression pattern
    String pattern = r'^\+998\d{9}$';
    // Create a RegExp object
    RegExp regExp = RegExp(pattern);
    // Check if the input string matches the pattern
    return regExp.hasMatch(phoneNumber);
  }


  
}
