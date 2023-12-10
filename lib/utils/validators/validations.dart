import 'package:email_validator/email_validator.dart';

class AppValidations {
  static String? validateEmptyText( String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final isValid = EmailValidator.validate(value);
    return isValid ? null : 'Invalid email format';
  }
  static String? validateMatch(String? value1,String? value2) {

    return (value1==value2) ? null : 'Password does not match';
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    // Return null if the password is valid
    return null;
  }

}
