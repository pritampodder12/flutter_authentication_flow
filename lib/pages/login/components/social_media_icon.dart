import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaIcon extends StatelessWidget {
  final String iconName;
  SocialMediaIcon({this.iconName});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 50,
      onPressed: () {
        // signInWithGoogle().whenComplete(() {
        //   Navigator.of(context).pushReplacementNamed(RouterNames.HOME);
        // });
      },
      icon: SvgPicture.asset(
        iconName,
        semanticsLabel: 'Acme Logo',
        height: 30,
        width: 30,
      ),
    );
  }
}
