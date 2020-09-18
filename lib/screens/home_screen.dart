import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mediapp/main.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/widgets/card_items.dart';
import 'package:mediapp/widgets/card_main.dart';
import 'package:mediapp/widgets/card_section.dart';
import 'package:mediapp/widgets/custom_clipper.dart';



class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  bool _isAppbar = true;
  ScrollController _scrollController = new ScrollController();

  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        print(ScrollDirection);
        appBarStatus(false);
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        print(ScrollDirection);
        appBarStatus(true);
      }
    });
  }

  void appBarStatus(bool status) {
    setState(() {
      _isAppbar = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    ScrollController _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        print(ScrollDirection);
        appBarStatus(false);
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        print(ScrollDirection);
        appBarStatus(true);
      }
    });

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              color: Theme.of(context).accentColor,
              height: _isAppbar ? Constants.headerHeight+statusBarHeight:0.0,
              //width: _isAppbar ?  900:0.0,
            ),
          ),

          Positioned(
              right: -45,
              top: -30,
              child: ClipOval(
                  child: Container(
                    color: Colors.black.withOpacity(0.05),
                    height: 220,
                    width: 220,
                  ),
              ),
          ),

          // BODY
          Padding(
            padding: EdgeInsets.all(Constants.paddingSide),
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                // Header - Greetings and Avatar
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Hello Maya",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.white
                          ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage('assets/icons/maya.jpg')
                    )
                  ],
                ),

                SizedBox(height: 40),

                // Main Cards - Heartbeat and Blood Pressure
                Container(
                    height: 140,
                  child:
                    Row(
                      //scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Hero(
                          tag:"Hero1",
                          child:
                          Material(
                              type: MaterialType.transparency,
                              child:

                        CardMain(
                            image: AssetImage('assets/icons/score.png'),
                            title: "Your Score",
                            value: score.toString(),
                            unit: "Average",
                            color: Constants.lightGreen,
                        )
                          )
                        ),
                        CardMain(
                            image: AssetImage('assets/icons/drop.png'),
                            title: "Today's AQI",
                            value: AQI.toString(),
                            unit: "Moderate",
                            color: Constants.lightYellow
                        )
                      ],
                    ),
                ),

                // Section Cards - Daily Medication
                SizedBox(height: 40),

                Text("Today's Reminders",
                    style: TextStyle(
                        color: Constants.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                    ),
                ),

                SizedBox(height: 20),

                Container(
                    height: 125,

                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        CardSection(
                          image: AssetImage('assets/icons/vacuum.png'),
                          title: "Vacuum",
                          value: "living",
                          unit: "room",
                          time: "8-9AM",
                          isDone: false,
                        ),
                        CardSection(
                          image: AssetImage('assets/icons/window.png'),
                          title: "Open Windows",
                          value: "whole",
                          unit: "house",
                          time: "6-7AM",
                          isDone: true,
                        )
                      ],
                    )),

                SizedBox(height: 50),

                // Scheduled Activities
                Text("Top Actions",
                    style: TextStyle(
                        color: Constants.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),
                ),

                SizedBox(height: 20),
                Container(
                  height:450,
                  decoration: new BoxDecoration(
                    boxShadow: [
                      //color: Colors.white, //background color of box
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.01),
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 2.0, //extend the shadow
                        offset: Offset(
                          0.15, // Move to right 10  horizontally
                          0.15, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                    child:
                    new ListView.builder
                      (
                        physics: NeverScrollableScrollPhysics(),
                        dragStartBehavior: DragStartBehavior.start,
                        shrinkWrap: true,
                        itemCount: actions.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return new CardItems(
                            image: Image.asset(
                              'assets/icons/'+ action[actions[index]]["image"].toString(),
                              height: 20,
                              width: 20,
                            ),
                            title: actions[index],
                            value: action[actions[index]]["time"].toString(),
                            unit: "pts",
                            color: Constants.lightYellow,
                            subtitle: action[actions[index]]["status"].toString(),
                            //progress: 30,
                          );
                        }
                    ),



                   /* ListView(
                      scrollDirection: Axis.vertical,
                      //physics: NeverScrollableScrollPhysics(),
                      //primary: false,
                      shrinkWrap: true,
                      children: <Widget>[
                        CardItems(
                          image: Image.asset(
                            'assets/icons/Walking.png',
                          ),
                          title: "Change Air Filter",
                          value: "15",
                          unit: "min",
                          color: Constants.lightYellow,
                          subtitle: "MERV 11",
                          //progress: 30,
                        ),
                        CardItems(
                          image: Image.asset(
                            'assets/icons/Swimming.png',
                          ),
                          title: "Fix Leak",
                          value: "30",
                          unit: "mins",
                          color: Constants.lightBlue,
                          subtitle: "Bathroom sink",
                          //progress: 0,
                        ),
                        CardItems(
                          image: Image.asset(
                            'assets/icons/Swimming.png',
                          ),
                          title: "Fix Leak",
                          value: "30",
                          unit: "mins",
                          color: Constants.lightBlue,
                          subtitle: "Bathroom sink",
                          //progress: 0,
                        ),
                      ],
                    ),*/
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


