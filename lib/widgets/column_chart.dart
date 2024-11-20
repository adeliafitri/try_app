import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'dart:math';

class ColumnChart extends StatelessWidget {
  final List<String> categories = [
    'TS-SGN', 'TS-PTPN', 'TR', 
    'SPT'
  ];
  
  final List<double> todayData = [5, 6, 6.5, 6.2];
  final List<double> untilTodayData = [5.1, 7.3, 7.5, 9];

  ColumnChart({super.key});

  @override
    Widget build(BuildContext context) {
      // Temukan nilai maksimum dari data
      double maxDataValue = todayData.reduce(max);

      // Atur maksimum sumbu X ke kelipatan 5 terdekat di atas nilai maksimum
      int maxXAxis = (maxDataValue / 5).ceil() * 5;
      final List<ChartData> chartData = List.generate(
        categories.length,
        (index) {
          return ChartData(
            categories[index],
            todayData[index],
            untilTodayData[index]
            // borderRadius,
          );
        },
      );
        return Scaffold(
            body: Center(
                child: Container(
                  // padding: EdgeInsets.zero,
                  color: Colors.white,
                    child: SfCartesianChart(
                      margin: EdgeInsets.zero,
                      plotAreaBorderWidth: 0,
                      borderWidth: 0,  
                        primaryXAxis: CategoryAxis(
                          majorGridLines: MajorGridLines(width: 0),
                          majorTickLines: MajorTickLines(size: 0),
                          axisLine: AxisLine(width: 0,),
                          labelStyle: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        primaryYAxis: NumericAxis(
                          interval: 5,
                          maximum: maxXAxis.toDouble(), 
                          majorTickLines: MajorTickLines(size: 0),
                          axisLine: AxisLine(width: 0,),
                          labelStyle: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        // Palette colors
                        palette: <Color>[
                            Color(0xFF6EB911),
                            Color(0xFFE9B407),
                        ],
                        series: <CartesianSeries>[
                            ColumnSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  // color: Color(0xFFD6ECF7),
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Color(0xFF6EB911)
                                  ),
                                  offset: Offset(0, -6),
                                ),
                                borderRadius: BorderRadius.circular(2.76),
                                width: 0.7,
                                spacing: 0.3,
                            ),
                            ColumnSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y1,
                                dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  // color: Color(0xFFD6ECF7),
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Color(0xFFE9B407),
                                  ),
                                  offset: Offset(0, -6),
                                ),
                                borderRadius: BorderRadius.circular(2.76),
                                width: 0.7,
                                spacing: 0.3,
                            ),
                        ]
                    )
                )
            )
        );
    }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final String x;
  final double? y;
  final double? y1;
}

class ColumnChartTotal extends StatelessWidget {
  ColumnChartTotal({super.key});

  @override
    Widget build(BuildContext context) {
      // Temukan nilai maksimum dari data
      double amountToday = 6.5;
      double amountUntilToday = 7.51;

      // Atur maksimum sumbu X ke kelipatan 5 terdekat di atas nilai maksimum
      int maxXAxis = (amountUntilToday / 5).ceil() * 5;
      final List<ChartDataTotal> chartDataTotal = [
        ChartDataTotal('Total', amountToday, amountUntilToday)
      ];
        return Scaffold(
            body: Center(
                child: Container(
                  color: Colors.white,
                    child: SfCartesianChart(
                      margin: EdgeInsets.zero,
                      plotAreaBorderWidth: 0,
                      borderWidth: 0,  
                        primaryXAxis: CategoryAxis(
                          majorGridLines: MajorGridLines(width: 0),
                          majorTickLines: MajorTickLines(size: 0),
                          axisLine: AxisLine(width: 0,),
                          labelStyle: GoogleFonts.poppins(
                            color: Color(0xFF396700),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        primaryYAxis: NumericAxis(
                          interval: 5,
                          maximum: maxXAxis.toDouble(), 
                          majorTickLines: MajorTickLines(size: 0),
                          axisLine: AxisLine(width: 0,),
                          labelStyle: GoogleFonts.poppins(
                            color: Colors.black,
                            
                            fontSize: 0,
                          ),
                        ),
                        // Palette colors
                        palette: <Color>[
                            Color(0xFF4B7E0C),
                            Color(0xFF8C6D08),
                        ],
                        series: <CartesianSeries>[
                            ColumnSeries<ChartDataTotal, String>(
                                dataSource: chartDataTotal,
                                xValueMapper: (ChartDataTotal data, _) => data.x,
                                yValueMapper: (ChartDataTotal data, _) => data.y,
                                dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  // color: Color(0xFFD6ECF7),
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Color(0xFF4B7E0C)
                                  ),
                                  offset: Offset(0, -6),
                                ),
                                borderRadius: BorderRadius.circular(2.76),
                                width: 0.5,
                                spacing: 0.3,
                            ),
                            ColumnSeries<ChartDataTotal, String>(
                                dataSource: chartDataTotal,
                                xValueMapper: (ChartDataTotal data, _) => data.x,
                                yValueMapper: (ChartDataTotal data, _) => data.y1,
                                dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  // color: Color(0xFFD6ECF7),
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Color(0xFF8C6D08),
                                  ),
                                  offset: Offset(0, -6),
                                ),
                                borderRadius: BorderRadius.circular(2.76),
                                width: 0.5,
                                spacing: 0.3,
                            ),
                        ]
                    )
                )
            )
        );
    }
}

class ChartDataTotal {
  ChartDataTotal(this.x, this.y, this.y1);
  final String x;
  final double? y;
  final double? y1;
}