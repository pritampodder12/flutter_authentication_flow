class ValidationMixin {
  String emailValidator(String value) {
    if (value.isEmpty) return 'Email is required';
    if (!value.contains('@')) return 'Please enter valid email id';
    return null;
  }

  String passwordValidator(String value) {
    if (value.isEmpty) return 'Password is required';
    if (value.contains(' ')) return 'Password should not contain space(s)';
    if (value.length < 3) return 'Password must atleast 3 character';
    return null;
  }

  String nameValidator(String value) {
    if (value.isEmpty) return 'Name is required';
    if (value.length < 3) return 'Name must atleast 3 character';
    return null;
  }

  String phoneValidator(String value) {
    if (value.isEmpty) return 'Ph. no. is required';
    if (value.length < 4) return 'Number must atleast 4 character';
    return null;
  }
}
