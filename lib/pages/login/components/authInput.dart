import 'package:flutter/material.dart';

import '../../../mixins/validation_mixin.dart';

class AuthInput extends StatefulWidget {
  final String type;
  final String label;
  final String name;
  final String placeholder;
  final bool isLoading;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final Map<String, Map<String, dynamic>> data;
  AuthInput({
    @required this.type,
    @required this.label,
    @required this.name,
    @required this.placeholder,
    @required this.data,
    this.isLoading,
    this.focusNode,
    this.nextFocusNode,
  });

  @override
  _AuthInputState createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> with ValidationMixin {
  bool _autoValidate = false;
  bool _isValid = false;

  void _checkValidity(String value) {
    setState(() {
      _isValid = false;
    });
    String result = widget.type == 'email'
        ? emailValidator(value)
        : widget.type == 'password' ? passwordValidator(value) : null;
    setState(() {
      if (result == null) _isValid = true;
    });
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
        onChanged: _checkValidity,
        enabled: widget.isLoading == null ? true : !widget.isLoading,
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: widget.type == 'email'
            ? TextInputType.emailAddress
            : TextInputType.text,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            helperText: '',
            hintText: widget.placeholder,
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
          if (_isValid)
            widget.data[widget.name]['isValid'] = true;
          else
            widget.data[widget.name]['isValid'] = false;
        },
      ),
    );
  }
}
