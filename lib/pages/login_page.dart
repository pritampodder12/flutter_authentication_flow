import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/index.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // prefs.setBool('loggedIn', true);
              Navigator.pushReplacementNamed(context, RouterNames.HOME);
            },
            child: Text('Log In',
                style: TextStyle(color: Theme.of(context).accentColor)),
          ),
          SizedBox(height: 20),
          IconButton(
            onPressed: () {
              signInWithGoogle().whenComplete(() {
                Navigator.of(context).pushReplacementNamed(RouterNames.HOME);
              });
            },
            icon: SvgPicture.asset(
              ImageNames.googleLogo,
              semanticsLabel: 'Acme Logo',
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
    ));
  }
}
