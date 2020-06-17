class ValidationMixin {
  final Function(String) emailValidator = (String value) {
    if (value.isEmpty) return 'Email is required';
    if (!value.contains('@')) return 'Please enter valid email id';
  };

  final Function(String) passwordValidator = (String value) {
    if (value.isEmpty) return 'Password is required';
    if (value.length < 3) return 'Password must atleast 3 character';
  };
}
