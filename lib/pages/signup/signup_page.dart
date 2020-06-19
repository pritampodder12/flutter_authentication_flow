import 'package:flutter/material.dart';

import '../../common_widgets/authInput.dart';
import '../../constants/index.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final _formData = <String, Map<String, dynamic>>{
    'name': {'value': '', 'isValid': false},
    'phone': {'value': '', 'isValid': false},
    'email': {'value': '', 'isValid': false},
    'password': {'value': '', 'isValid': false},
  };
  bool _isLoading = false;
  bool _formIsValid = false;

  _handleChange() {
    _formKey.currentState.save();
    bool valid = true;
    _formData.forEach((key, value) {
      if (!value['isValid']) valid = false;
    });
    setState(() {
      _formIsValid = valid;
    });
  }

  _handleSubmit() async {
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, RouterNames.HOME));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lime[300],
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(children: [
              if (_isLoading)
                Theme(
                  data: Theme.of(context).copyWith(accentColor: Colors.green),
                  child: new LinearProgressIndicator(),
                ),
              Form(
                key: _formKey,
                onChanged: _handleChange,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  children: [
                    SizedBox(height: 50),
                    Text('Sign Up',
                        style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).primaryColor)),
                    Divider(
                        color: Theme.of(context).primaryColor, thickness: 1),
                    SizedBox(height: 40),
                    AuthInput(
                      type: 'text',
                      label: 'Name',
                      name: 'name',
                      placeholder: 'full name',
                      isLoading: _isLoading,
                      data: _formData,
                      nextFocusNode: _phoneFocusNode,
                    ),
                    SizedBox(height: 20),
                    AuthInput(
                      type: 'number',
                      label: 'Phone',
                      name: 'phone',
                      placeholder: 'Phone Number',
                      isLoading: _isLoading,
                      data: _formData,
                      focusNode: _phoneFocusNode,
                      nextFocusNode: _emailFocusNode,
                    ),
                    SizedBox(height: 20),
                    AuthInput(
                      type: 'email',
                      label: 'Email',
                      name: 'email',
                      placeholder: 'e.g. company@example.com',
                      isLoading: _isLoading,
                      data: _formData,
                      focusNode: _emailFocusNode,
                      nextFocusNode: _passwordFocusNode,
                    ),
                    SizedBox(height: 20),
                    AuthInput(
                      type: 'password',
                      label: 'Password',
                      name: 'password',
                      placeholder: 'e.g. abc@123',
                      data: _formData,
                      isLoading: _isLoading,
                      focusNode: _passwordFocusNode,
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      textColor: Colors.white,
                      disabledTextColor: Colors.white,
                      onPressed:
                          _isLoading || !_formIsValid ? null : _handleSubmit,
                      child: Text(_isLoading ? 'Signing up.....' : 'Sign Up'),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
