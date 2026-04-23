class Validator {
  Validator._internal();

  static final Validator _instance = Validator._internal();

  factory Validator() => _instance;

  String error = '';

  /// Email Validation
  bool validateEmail(String email) {
    final value = email.trim();

    if (value.isEmpty) {
      error = "Email is required";
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

    if (!RegExp(pattern).hasMatch(value)) {
      error = "Invalid email format";
      return false;
    }

    error = '';
    return true;
  }

  /// Password Validation
  bool validatePassword(String password) {
    final value = password.trim();

    if (value.isEmpty) {
      error = "Password is required";
      return false;
    } else if (value.length < 8) {
      error = "Password must be at least 8 characters";
      return false;
    } else if (!RegExp(r'(?=.*?[A-Z])').hasMatch(value)) {
      error = "Must include at least one uppercase letter";
      return false;
    } else if (!RegExp(r'(?=.*?[a-z])').hasMatch(value)) {
      error = "Must include at least one lowercase letter";
      return false;
    } else if (!RegExp(r'(?=.*?\d)').hasMatch(value)) {
      error = "Must include at least one number";
      return false;
    } else if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(value)) {
      error = "Must include at least one special character";
      return false;
    }

    error = '';
    return true;
  }

  /// Login / Signup Validation
  bool loginAndSignUpValidator({
    required String userName,
    required String password,
  }) {
    if (userName.trim().isEmpty) {
      error = "Please enter username";
      return false;
    }

    if (!validatePassword(password)) {
      return false; // error already set
    }

    error = '';
    return true;
  }
}
