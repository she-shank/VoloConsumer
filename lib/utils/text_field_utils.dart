// ignore_for_file: constant_identifier_names

enum EmailValidationError { FIELD_EMPTY, INVALID_EMAIL }
enum PasswordValidationError {
  FIELD_EMPTY,
  TOO_SHORT,
  MUST_CONTAIN_UPPERCASE,
  MUST_CONTAIN_LOWERCASE,
  MUST_CONTAIN_DIGIT,
  MUST_CONTAIN_SPECIAL_CHAR
}

class TextFieldUtils {
  static final RegExp _emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  static RegExp get emailRegex => _emailRegex;
  static final RegExp _passRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  static RegExp get passRegex => _passRegex;
  static const int _passwordMinLen = 8;

  static String? passValidator(String? value) {
    if (value == null || value == '') {
      return PasswordValidationError.FIELD_EMPTY.toString().split('.').last;
    } else {
      if (value.length < _passwordMinLen) {
        return PasswordValidationError.TOO_SHORT.toString().split('.').last;
      }
      if (!_passRegex.hasMatch(value)) {
        return PasswordValidationError.MUST_CONTAIN_DIGIT
            .toString()
            .split('.')
            .last;
      }
    }
  }

  static String? emailValidator(String? value) {
    if (value == null || value == '') {
      return EmailValidationError.FIELD_EMPTY.toString().split('.').last;
    } else {
      if (!_emailRegex.hasMatch(value)) {
        return EmailValidationError.INVALID_EMAIL.toString().split('.').last;
      }
    }
  }

  static String? usernameValidator(String? value) {
    return null;
  }
}
