import 'package:flutter/material.dart';

import '../mixins/validation_mixin.dart';

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
    String result = widget.name == 'email'
        ? emailValidator(value)
        : widget.name == 'password'
            ? passwordValidator(value)
            : widget.name == 'name'
                ? nameValidator(value)
                : widget.name == 'phone' ? phoneValidator(value) : null;

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
        autovalidate: _autoValidate,
        onChanged: _checkValidity,
        validator: widget.name == 'email'
            ? emailValidator
            : widget.name == 'password'
                ? passwordValidator
                : widget.name == 'name'
                    ? nameValidator
                    : widget.name == 'phone' ? phoneValidator : null,
        onSaved: (value) {
          widget.data[widget.name]['value'] = value;
          if (_isValid)
            widget.data[widget.name]['isValid'] = true;
          else
            widget.data[widget.name]['isValid'] = false;
        },
        onFieldSubmitted: (_) => widget.nextFocusNode != null
            ? FocusScope.of(context).requestFocus(widget.nextFocusNode)
            : null,
        focusNode: widget.focusNode,
        enabled: widget.isLoading == null ? true : !widget.isLoading,
        cursorColor: Theme.of(context).primaryColor,
        obscureText: widget.type == 'password' ? true : false,
        textInputAction: widget.nextFocusNode != null
            ? TextInputAction.next
            : TextInputAction.done,
        keyboardType: widget.type == 'email'
            ? TextInputType.emailAddress
            : widget.type == 'number'
                ? TextInputType.number
                : TextInputType.text,
        decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
            helperText: '',
            hintText: widget.placeholder,
            labelText: widget.label),
      ),
    );
  }
}
