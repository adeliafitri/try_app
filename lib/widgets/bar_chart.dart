import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

class HorizontalBarChart extends StatelessWidget {
  final List<String> categories = [
    'TRT-II MD', 'TSS-III HG', 'TSS-IV HG', 
    'TST-I HG', 'TST-II HG', 'TST-III HG', 'TSS-V HG'
  ];
  
  final List<int> todayData = [15, 15, 15, 6, 10, 21, 17];

  @override
  Widget build(BuildContext context) {
    // Temukan nilai maksimum dari data
    int maxDataValue = todayData.reduce(max);

    // Atur maksimum sumbu X ke kelipatan 5 terdekat di atas nilai maksimum
    int maxXAxis = (maxDataValue / 5).ceil() * 5;

    final List<ChartData> data = List.generate(
      categories.length,
      (index) => ChartData(categories[index], todayData[index].toDouble()),
    );
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      borderWidth: 0,                // Menghilangkan border chart
      // borderColor: Colors.transparent,
      primaryXAxis: CategoryAxis(
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
      primaryYAxis: NumericAxis(
        interval: 5,
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
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            color: Color(0xFFD6ECF7),
            textStyle: GoogleFonts.poppins(
              color: Color(0xFF2583AD)
            ),
            offset: Offset(6, 0),
          ),
          color: Color(0xFF32A2D5),
          borderRadius: BorderRadius.circular(20),
          width: 0.5,
          spacing: - 0.3
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}