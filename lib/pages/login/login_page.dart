import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './components/social_media_icon.dart';
import '../../widgets/authInput.dart';
import '../../constants/index.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  final _formData = <String, Map<String, dynamic>>{
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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool('loggedIn', true);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
                    SizedBox(height: screenSize.height * 0.2),
                    Text('Log In',
                        style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).primaryColor)),
                    Divider(
                        color: Theme.of(context).primaryColor, thickness: 1),
                    SizedBox(height: 40),
                    AuthInput(
                      type: 'email',
                      label: 'Email',
                      name: 'email',
                      placeholder: 'e.g. company@example.com',
                      isLoading: _isLoading,
                      data: _formData,
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
                      child: Text(_isLoading ? 'Loging in.....' : 'Log In'),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialMediaIcon(iconName: ImageNames.googleLogo),
                        SocialMediaIcon(iconName: ImageNames.facebookLogo)
                      ],
                    ),
                    FlatButton(
                      textColor: Colors.black,
                      child: Text('Sign Up'),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).pushNamed(RouterNames.SIGNUP);
                      },
                    )
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
