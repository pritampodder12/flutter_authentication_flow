class ValidationMixin {
  String emailValidator(String value) {
    if (value.isEmpty) return 'Email is required';
    if (!value.contains('@')) return 'Please enter valid email id';
    return null;
  }

  String passwordValidator(String value) {
    if (value.isEmpty) return 'Password is required';
    if (value.length < 3) return 'Password must atleast 3 character';
    return null;
  }
}
