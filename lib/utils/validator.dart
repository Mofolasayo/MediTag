class Validator {
  String? validateName(String? value, String? field) {
    if (value == null || value.isEmpty) {
      return '$field is required.';
    }

    if (value.length < 3 || value.length > 23) {
      return 'Name must be between 3 and 23 characters';
    }

    if (!value.contains(RegExp(r'^[a-zA-Z]+$'))) {
      return 'Name must contain only alphabetic characters';
    }

    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }

    if (value.length < 3 || value.length > 23) {
      return 'Username must be between 3 and 23 characters';
    }

    // Username can contain alphabets, numbers, and symbols
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    final symbolRegex = RegExp(r'[!@#$%^&*()_+]');
    final uppercaseRegex = RegExp(r'[A-Z]');

    if (!symbolRegex.hasMatch(value) || !uppercaseRegex.hasMatch(value)) {
      return 'Password must contain at least one symbol and one uppercase letter';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    final phoneRegex = RegExp(r'^\+?\d{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }
}
