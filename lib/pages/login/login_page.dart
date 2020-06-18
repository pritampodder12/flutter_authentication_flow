import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './components/social_media_icon.dart';
import './components/authInput.dart';
import '../../constants/index.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  bool _autoValidate = false;
  bool _isLoading = false;
  Map<String, String> _loginData = {
    'email': '',
    'password': '',
  };
  _handleSubmit() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      print(_loginData);
      await Future.delayed(Duration(seconds: 2),
          () => Navigator.pushReplacementNamed(context, RouterNames.HOME));
    } else
      setState(() {
        _autoValidate = true;
      });
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
                autovalidate: _autoValidate,
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
                      isLoading: _isLoading,
                      data: _loginData,
                      nextFocusNode: _passwordFocusNode,
                    ),
                    SizedBox(height: 20),
                    AuthInput(
                      type: 'password',
                      label: 'Password',
                      name: 'password',
                      data: _loginData,
                      isLoading: _isLoading,
                      focusNode: _passwordFocusNode,
                    ),
                    SizedBox(height: 40),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: _isLoading ? null : _handleSubmit,
                      child: Text(_isLoading ? 'Please wait.....' : 'Log In',
                          style:
                              TextStyle(color: Theme.of(context).accentColor)),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialMediaIcon(iconName: ImageNames.googleLogo),
                        SocialMediaIcon(iconName: ImageNames.facebookLogo)
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
