import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String type;
  final String label;
  final String placeholder;
  final bool obscureText;
  TextInput({this.type, this.label, this.placeholder, this.obscureText});

  final Function(String) emailValidator = (String value) {
    if (!value.contains('@')) return 'Please enter valid email id';
  };

  final Function(String) passwordValidator = (String value) {
    if (value.length < 3) return 'Password must atleast 4 character';
  };

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      keyboardType:
          type == 'email' ? TextInputType.emailAddress : TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          helperText: '',
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red[400], width: 1.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red[400], width: 1.0)),
          hintText: placeholder,
          labelText: label),
      validator: type == 'email'
          ? emailValidator
          : type == 'password' ? passwordValidator : null,
      obscureText: type == 'password' ? true : false,
    );
  }
}
