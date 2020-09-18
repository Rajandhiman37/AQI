import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/screens/home_screen.dart';
import 'package:mediapp/utils/const.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: Constants.lighTheme(context),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

      //actions: initState(),
    );
  }
}


class SplashScreen extends StatefulWidget {

  SplashScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}
var score = 0;
var AQI = 0;
var action ={};
var actions;
class SplashScreenState extends State<SplashScreen> {


  final fb = FirebaseDatabase.instance;

  initState()
  {
    super.initState();
    final ref = fb.reference();
    ref.child("Data").once().then((DataSnapshot data){
      setState(() {
        score=data.value["score"];
        AQI=data.value["AIQ"];
        action = (data.value["Action"]);
        print(action);
        actions = (action.keys).toList();
        print(actions);
      });
    });
    loadData();
  }
  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
      if(actions != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }
      else{
        loadData();
      }



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
      Center(
        child:
          CircularProgressIndicator(),
      ),

    );
  }
}


