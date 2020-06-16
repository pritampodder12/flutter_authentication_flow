import 'package:case_study/constants/image_names.dart';
import 'package:case_study/constants/router_names.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, RouterNames.LOGIN);
            },
            child: Text('Log Out'),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Align(
            alignment: Alignment.topLeft,
            child: Hero(
                tag: "DemoTag",
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Color(0xffFDCF09),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(ImageNames.myImage),
                  ),
                )),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouterNames.TEST);
            },
            child: Text('Navigate'),
          ),
          IconButton(
            iconSize: 50,
            icon: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: _animationController,
            ),
            onPressed: () => _handleOnPressed(),
          ),
        ]),
      ),
    );
  }

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }
}
