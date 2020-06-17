import 'package:flutter/material.dart';

import '../../../mixins/validation_mixin.dart';

class AuthInput extends StatefulWidget {
  final String type;
  final String label;
  final String placeholder;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  AuthInput({
    @required this.type,
    @required this.label,
    @required this.placeholder,
    @required this.focusNode,
    this.nextFocusNode,
  });

  @override
  _AuthInputState createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> with ValidationMixin {
  bool _autoValidate = false;

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
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: widget.type == 'email'
            ? TextInputType.emailAddress
            : TextInputType.text,
        focusNode: widget.focusNode,
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
          hintText: widget.placeholder,
          labelText: widget.label,
        ),
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
      ),
    );
  }
}
