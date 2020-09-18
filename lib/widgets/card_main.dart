import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/screens/detail_screen.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/widgets/custom_clipper.dart';

class CardMain extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String value;
  final String unit;
  final Color color;

  CardMain(
      {Key key,
      @required this.image,
      @required this.title,
      @required this.value,
      @required this.unit,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Container(
            margin: const EdgeInsets.only(right: 7.0),
            width: (
                (MediaQuery.of(context).size.width - (Constants.paddingSide * 2 + Constants.paddingSide / 2)) /
                2),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              shape: BoxShape.rectangle,
              color: color,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                    offset: Offset(0.15, 0.15)
                )
              ],
            ),
              child:
            Material(

              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  overflow: Overflow.clip,
                  children: <Widget>[
                    Positioned(
                        child: ClipPath(
                            clipper: MyCustomClipper(clipType: ClipType.semiCircle),
                            child: Container(
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                color: Colors.black.withOpacity(0.03),
                              ),
                              height: 100,
                              width: 100,
                            ),
                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Icon and Hearbeat
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                width: 25,
                                height: 25,
                                image: image
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                      title,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Constants.textDark
                                      ),
                                  ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(value,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color: Constants.textDark,
                              ),
                          ),
                          Text(
                              unit,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Constants.textDark
                              ),
                          ),
                        ],
                      )),

                  ],
                ),
                onTap: () {
                  debugPrint("CARD main clicked. redirect to details page");
                  Navigator.of(context).pushReplacement(
                     MaterialPageRoute(builder: (context) => DetailScreen()));

                  //Navigator.of(context).push(_createRoute());
                  /*Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(seconds: 2),
                          pageBuilder: (_, __, ___) => DetailScreen()));*/
                },
              ),
              color: Colors.transparent,
            ),
        ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    DetailScreen(),
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        ScaleTransition(
          scale: Tween<double>(
            begin: 1.5,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        ),
        /*Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        ),*/
  );
   /* pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 3.5);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SizeTransition(
        //position: animation.drive(tween),
        sizeFactor: animation,
        axis: Axis.vertical,
        child: child,
      );
    },
  );*/
}


