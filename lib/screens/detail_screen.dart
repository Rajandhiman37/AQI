import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediapp/main.dart';
import 'package:mediapp/screens/home_screen.dart';
import 'package:mediapp/utils/const.dart';
import 'package:mediapp/widgets/chat_graph.dart';
import 'package:mediapp/widgets/custom_clipper.dart';
import 'package:mediapp/widgets/grid_item.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart' as prefix0;

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    // For Grid Layout
    double _crossAxisSpacing = 16, _mainAxisSpacing = 16, _cellHeight = 150.0;
    int _crossAxisCount = 2;

    double _width = (MediaQuery.of(context).size.width -
        ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    double _aspectRatio =
        _width / (_cellHeight + _mainAxisSpacing + (_crossAxisCount + 1));

    final customTickFormatter =
    charts.BasicNumericTickFormatterSpec((num value) {
      if (value == 0) {
        return "March";
      } else if (value == 1) {
        return "April";
      } else if (value == 2) {
        return "May";
      } else if (value == 3) {
        return "Jun";
      }
    });


    var chartwidget =  Expanded(
        child: Container(
            margin: EdgeInsets.fromLTRB(12.0,12.0, 12.0, 12.0),

            child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child:
                LineChart(
                  _createSampleData(),
                  domainAxis: charts.NumericAxisSpec(
                    tickProviderSpec:
                    charts.BasicNumericTickProviderSpec(desiredTickCount: 4),
                    tickFormatterSpec: customTickFormatter,
                  ),
                 defaultRenderer: new LineRendererConfig(includePoints: true,stacked: true),
                 /*behaviors: [
                    LinePointHighlighter(
                        symbolRenderer: CustomCircleSymbolRenderer()
                    )
                  ],*/

                  selectionModels: [
                    SelectionModelConfig(
                        changedListener: (SelectionModel model) {
                          if(model.hasDatumSelection)
                            print(model.selectedSeries[0].measureFn(model.selectedDatum[0].index));
                        }
                    )
                  ],
                  animate: true,

                  /* domainAxis: new OrdinalAxisSpec(
                      tickProviderSpec:
                      new StaticOrdinalTickProviderSpec(staticTicks3)),*/
                ))
        ))
    ;

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body:

      Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Constants.darkGreen,
              height: Constants.headerHeight + statusBarHeight,
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
            child:
            ListView(
              //scrollDirection: Axis.vertical,
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Back Button
                        SizedBox(
                          width: 34,
                          child:RawMaterialButton(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => HomeScreen()));
                              /*Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration: Duration(seconds: 2),
                                      pageBuilder: (_, __, ___) => HomeScreen()));*/
                            },
                            child: Icon(
                                Icons.arrow_back_ios,
                                size: 15.0,
                                color: Colors.white
                            ),
                            shape: CircleBorder(
                                side: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                    style: BorderStyle.solid
                                ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Hero(
                        tag: "Hero1",
                        child:
                        Material(
                        type: MaterialType.transparency,
                        child:


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Your Score",
                                style: prefix0.TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white
                                ),
                            ),
                            SizedBox(height: 10),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              mainAxisAlignment: MainAxisAlignment.start,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(score.toString(),
                                    style: prefix0.TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white
                                    ),
                                ),

                                SizedBox(width: 10),

                                Text("Average",
                                    style: prefix0.TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                    ),
                                ),
                              ],
                            )
                          ],
                        ))),
                      ],
                    ),
                    Spacer(),
                    Image(
                      fit: BoxFit.cover,
                        image: AssetImage('assets/icons/score.png'),
                        height: 60,
                        width: 60,
                        color: Colors.white.withOpacity(0.3)
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Chart
                Material(
                  shadowColor: Colors.grey.withOpacity(0.01), // added
                  type: MaterialType.card,
                  elevation: 10, borderRadius: new BorderRadius.circular(10.0),
                  child: Container(

                    padding: EdgeInsets.all(20.0),
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("History"),
                        // Rest "Action" Legend
                       /* Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(10.0),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Constants.lightGreen,
                                  shape: BoxShape.circle
                              ),
                            ),
                            Text("Activities"),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Constants.darkGreen,
                                  shape: BoxShape.circle
                              ),
                            ),
                            Text("Action"),
                          ],
                        ),*/
                        SizedBox(height: 20),
                        //getDefaultSplineChart(),
                        // Main Cards - Heartbeat and Blood Pressure
                        Container(

                          height: 200,
                          child: getDefaultSplineChart(),
                          //chartwidget,

                          /*ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              ProgressVertical(
                                value: 50,
                                date: "5/11",
                                isShowDate: true,
                              ),
                              ProgressVertical(
                                value: 50,
                                date: "5/12",
                                isShowDate: false,
                              ),
                              ProgressVertical(
                                value: 45,
                                date: "5/13",
                                isShowDate: false,
                              ),
                              ProgressVertical(
                                value: 30,
                                date: "5/14",
                                isShowDate: true,
                              ),
                              ProgressVertical(
                                value: 50,
                                date: "5/15",
                                isShowDate: false,
                              ),
                              ProgressVertical(
                                value: 20,
                                date: "5/16",
                                isShowDate: false,
                              ),
                              ProgressVertical(
                                value: 45,
                                date: "5/17",
                                isShowDate: true,
                              ),
                              ProgressVertical(
                                value: 67,
                                date: "5/18",
                                isShowDate: false,
                              ),
                            ],
                          ),*/
                        ),
                      ],
                    ),
                  ), // added
                ),
                SizedBox(height: 30),
                Container(
                  child: new GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _crossAxisCount,
                      crossAxisSpacing: _crossAxisSpacing,
                      mainAxisSpacing: _mainAxisSpacing,
                      childAspectRatio: _aspectRatio,
                    ),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {

                      switch(index) {
                        case 0:
                          return GridItem(
                              status: "Actions",
                              value: "7",
                              unit: "completed",
                              color: Constants.darkGreen,
                              image: null,
                              remarks: "ok"
                          );
                          break;
                        case 1:
                          return GridItem(
                              status: "Actions",
                              value: "11",
                              unit: "open",
                              color: Constants.darkOrange,
                              image: null,
                              remarks: "ok"
                          );
                          break;
                        case 2:
                          return GridItem(
                              status: "Health Impact",
                              value: "82",
                              unit: "moderate",
                              color: Constants.darkOrange,
                              image: AssetImage("assets/icons/Heart.png"),
                              remarks: "ok"
                          );
                          break;
                        case 3:
                          return GridItem(
                              status: "Reminders",
                              value: "7",
                              unit: "active",
                              color: Constants.darkOrange,
                              image: AssetImage("assets/icons/bell.png"),
                              remarks: "Ok"
                          );
                          break;
                        default:
                          return GridItem(
                            status: "Activities",
                            //time: "4h 45m",
                            value: "76",
                            unit: "avg bpm",
                            image: null,
                            remarks: "ok",
                            color: Constants.darkOrange,
                          );
                          break;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
    ),
    );


  }
  List <LinearSales> data = [];
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 40),
      new LinearSales(1, 50),
      new LinearSales(2, 60),
      new LinearSales(3, 70),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.month,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class LinearSales {
  final int month;
  final double sales;
  LinearSales(this.month, this.sales);
}
