import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

class BarChartSpt extends StatelessWidget {
  final List<String> hours = [
    '>= 24 s/d <=36 jam', '>36 jam', '<24 jam'
  ];
  
  final List<double> amount = [350.83, 17.11, 875.29];
  final List<Color> colors = [Color(0xFF32A2D5), Color(0xFF6EB911), Color(0xFFE9B407)];

  @override
  Widget build(BuildContext context) {
    // Temukan nilai maksimum dari data
    double maxDataValue = amount.reduce(max);

    // Atur maksimum sumbu X ke kelipatan 5 terdekat di atas nilai maksimum
    int maxXAxis = (maxDataValue / 200).ceil() * 200;

    final List<ChartData> data = List.generate(
      hours.length,
      (index) => ChartData(hours[index], amount[index], colors[index]),
    );
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      borderWidth: 0,                // Menghilangkan border chart
      // borderColor: Colors.transparent,
      primaryXAxis: CategoryAxis(
        maximumLabelWidth: 50,
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(size: 0),
        axisLine: AxisLine(width: 0,),
        labelStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 12,
        ),
        labelAlignment:LabelAlignment.center,
        edgeLabelPlacement: EdgeLabelPlacement.none
        // labelPosition: ChartDataLabelPosition.inside,
        // tickPosition: TickPosition.inside,
      ),
      // axes: <ChartAxis>[
      //   NumericAxis(
      //     name: 'NumericAxis', // Nama sumbu tambahan
      //     opposedPosition: true, // Sumbu berada di sisi kanan
      //     title: AxisTitle(text: 'Values'),
      //   ),
      // ],
      primaryYAxis: NumericAxis(
        interval: 200,
        maximum: maxXAxis.toDouble(), 
        // isVisible: true,
        majorTickLines: MajorTickLines(size: 0),
        axisLine: AxisLine(width: 0,),
        labelStyle: TextStyle(fontSize: 0),
        // edgeLabelPlacement: EdgeLabelPlacement.none
      ),
      series: <BarSeries<ChartData, String>>[
        BarSeries<ChartData, String>(
          dataSource: data,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (ChartData data, _) => data.color,
          // dataLabelSettings: DataLabelSettings(
          //   isVisible: true,
          //   color: Color(0xFFD6ECF7),
          //   textStyle: GoogleFonts.poppins(
          //     color: Color(0xFF2583AD)
          //   ),
          //   offset: Offset(6, 0),
          // ),
          color: Color(0xFF32A2D5),
          borderRadius: BorderRadius.circular(20),
          width: 0.5,
          // spacing: 0.3
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color? color;
}