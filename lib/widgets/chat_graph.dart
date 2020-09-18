/// Package import
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';



SfCartesianChart getDefaultSplineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: '' ),
      legend: Legend(isVisible:  false),
      primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          //minorGridLines: MinorGridLines(width: 1),
          labelPlacement: LabelPlacement.onTicks),
      primaryYAxis: NumericAxis(
          minimum: 30,
          maximum: 80,
          axisLine: AxisLine(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          minorTickLines: MinorTickLines(size: 0),

          //labelFormat: '{value}°F',
          majorTickLines: MajorTickLines(size: 0)),
      series: getDefaultSplineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
      enableAxisAnimation: true,
    );
  }

  /// Returns the list of chart series which need to render on the spline chart.
  List<SplineSeries<ChartSampleData, String>> getDefaultSplineSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'Mar', y: 50,),
      ChartSampleData(x: 'Apr', y: 54, ),
      ChartSampleData(x: 'May', y: 61,),
      ChartSampleData(x: 'Jun', y: 66,),
    ];
    return <SplineSeries<ChartSampleData, String>>[
      SplineSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        color: Color.fromRGBO(137, 218, 170,100),
        //markerSettings: MarkerSettings(isVisible: true),
        name: 'High',
      ),
    ];
  }


class ChartSampleData {
  ChartSampleData(
      {this.x,
        this.y,
        this.xValue,
        this.yValue,
        this.yValue2,
        this.yValue3,
        this.pointColor,
        this.size,
        this.text,
        this.open,
        this.close});
  final dynamic x;
  final num y;
  final dynamic xValue;
  final num yValue;
  final num yValue2;
  final num yValue3;
  final Color pointColor;
  final num size;
  final String text;
  final num open;
  final num close;
}
