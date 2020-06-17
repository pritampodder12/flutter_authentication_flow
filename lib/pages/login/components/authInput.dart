import 'package:flutter/material.dart';

import '../../../mixins/validation_mixin.dart';

class AuthInput extends StatelessWidget with ValidationMixin {
  final String type;
  final String label;
  final String placeholder;
  AuthInput({
    @required this.type,
    @required this.label,
    @required this.placeholder,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      keyboardType:
          type == 'email' ? TextInputType.emailAddress : TextInputType.text,
      textInputAction:
          type == 'email' ? TextInputAction.next : TextInputAction.done,
      onFieldSubmitted: (_) =>
          type == 'email' ? FocusScope.of(context).nextFocus() : null,
      decoration: InputDecoration(
        helperText: '',
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromRGBO(101, 106, 54, 1), width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[400], width: 1.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[400], width: 1.0)),
        hintText: placeholder,
        labelText: label,
      ),
      validator: type == 'email'
          ? emailValidator
          : type == 'password' ? passwordValidator : null,
      obscureText: type == 'password' ? true : false,
    );
  }
}
