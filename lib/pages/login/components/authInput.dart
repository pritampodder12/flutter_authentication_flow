import 'package:flutter/material.dart';

import '../../../mixins/validation_mixin.dart';

class AuthInput extends StatefulWidget {
  final String type;
  final String label;
  final String name;
  final bool isLoading;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final Map<String, Map<String, dynamic>> data;
  AuthInput({
    @required this.type,
    @required this.label,
    @required this.name,
    @required this.data,
    this.isLoading,
    this.focusNode,
    this.nextFocusNode,
  });

  @override
  _AuthInputState createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  bool _autoValidate = false;
  bool _isValid;
  String emailValidator(String value) {
    if (value.isEmpty) return 'Email is required';
    if (!value.contains('@'))
      return 'Please enter valid email id';
    else {
      // setState(() {
      //   _isValid = true;
      // });
      return null;
    }
  }

  String passwordValidator(String value) {
    if (value.isEmpty) return 'Password is required';
    if (value.length < 3)
      return 'Password must atleast 3 character';
    else {
      // setState(() {
      //   _isValid = true;
      // });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus)
          setState(() {
            _autoValidate = true;
          });
      },
      child: TextFormField(
        enabled: widget.isLoading == null ? true : !widget.isLoading,
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: widget.type == 'email'
            ? TextInputType.emailAddress
            : TextInputType.text,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            helperText: '',
            labelText: widget.label),
        validator: widget.type == 'email'
            ? emailValidator
            : widget.type == 'password' ? passwordValidator : null,
        obscureText: widget.type == 'password' ? true : false,
        autovalidate: _autoValidate,
        textInputAction: widget.nextFocusNode != null
            ? TextInputAction.next
            : TextInputAction.done,
        onFieldSubmitted: (_) => widget.nextFocusNode != null
            ? FocusScope.of(context).requestFocus(widget.nextFocusNode)
            : null,
        onSaved: (value) {
          widget.data[widget.name]['value'] = value;
          widget.data[widget.name]['isValid'] = true;
        },
      ),
    );
  }
}
