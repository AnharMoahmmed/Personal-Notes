class Validator {
  Validator._(); // opject created by this line

  static String? nameValidator(String? name) {
    name = name?.trim() ?? '';

    return name.isEmpty ? 'No name provided!' : null;
  }

  static const String _emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  static String? emailValidator(String? email) {
    email = email?.trim() ?? '';
    return email.isEmpty
        ? 'No Eamil provided!'
        : !RegExp(_emailPattern).hasMatch(email)
        ? 'password is not a valid  formate '
        : null;
  }

  static String? passwordValidator(String? password) {
    String errorMessag = '';

    if (password!.isEmpty) {
      errorMessag = 'No password provided!';
    } else {
      if (password.length < 6) {
        errorMessag = 'Password must be at least 6 characters long ';
      }
      if (!password.contains(RegExp(r'[a-z]'))) {
        errorMessag =
            '$errorMessag \nPassword must containe at lest one lowercase letter  ';
      }
      if (!password.contains(RegExp(r'[A-Z]'))) {
        errorMessag =
            '$errorMessag \nPassword must containe at lest one Uppercase letter ';
      }
      if (!password.contains(RegExp(r'[0-9]'))) {
        errorMessag =
            '$errorMessag \nPassword must containe at lest one number ';
      }
    }

    return errorMessag.isNotEmpty ? errorMessag.trim() : null;
  }
}
