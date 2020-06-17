import 'package:flutter/material.dart';

import '../../../mixins/validation_mixin.dart';

class TextInput extends StatelessWidget with ValidationMixin {
  final String type;
  final String label;
  final String placeholder;
  final bool obscureText;
  TextInput({this.type, this.label, this.placeholder, this.obscureText});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: () {
        print('editing complete');
      },
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