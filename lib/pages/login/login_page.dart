import 'package:case_study/pages/login/components/social_media_icon.dart';
import 'package:case_study/pages/login/components/authInput.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/index.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // GoogleSignInAccount _currentUser;

  // @override
  // void initState() {
  //   super.initState();
  //   googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
  //     setState(() {
  //       _currentUser = account;
  //       //print(_currentUser.email);
  //     });
  //   });
  // }

  // Future<String> signInWithGoogle() async {
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;

  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );

  //   final AuthResult authResult = await _auth.signInWithCredential(credential);
  //   final FirebaseUser user = authResult.user;

  //   assert(!user.isAnonymous);
  //   assert(await user.getIdToken() != null);

  //   final FirebaseUser currentUser = await _auth.currentUser();
  //   assert(user.uid == currentUser.uid);

  //   return 'signInWithGoogle succeeded: $user';
  // }

  // void signOutGoogle() async {
  //   await googleSignIn.signOut();

  //   print("User Sign Out");
  // }
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  _handleSubmit() {
    if (_formKey.currentState.validate())
      Navigator.pushReplacementNamed(context, RouterNames.HOME);
    else
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
        body: Container(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                children: [
                  SizedBox(height: screenSize.height * 0.2),
                  Text('Log In',
                      style: TextStyle(
                          fontSize: 30, color: Theme.of(context).primaryColor)),
                  Divider(color: Theme.of(context).primaryColor, thickness: 1),
                  SizedBox(height: 40),
                  AuthInput(
                    type: 'email',
                    label: 'Email',
                    placeholder: 'Enter Email',
                    focusNode: _emailFocusNode,
                    nextFocusNode: _passwordFocusNode,
                  ),
                  SizedBox(height: 20),
                  AuthInput(
                    type: 'password',
                    label: 'Password',
                    placeholder: 'Enter Password',
                    focusNode: _passwordFocusNode,
                  ),
                  SizedBox(height: 40),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _handleSubmit,
                    child: Text('Log In',
                        style: TextStyle(color: Theme.of(context).accentColor)),
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
          ),
        ));
  }
}
