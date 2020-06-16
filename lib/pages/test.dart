import 'package:case_study/constants/index.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: "DemoTag",
          child: CircleAvatar(
            radius: 55,
            backgroundColor: Color(0xffFDCF09),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(ImageNames.myImage),
            ),
          ),
        ),
      ),
    );
  }
}
