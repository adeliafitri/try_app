import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

class StackedBarChart extends StatelessWidget {
  final List<String> times = [
    '13:00', '12:00', '11:00', '10:00', '09:00', '08:00', '07:00', '06:00' 
  ];
  
  final List<int> amountTruk = [4, 15, 9, 6, 10, 4, 2, 4];
  final List<int> amountLori = [3, 15, 8, 6, 10, 12, 7, 5];
  final List<int> amountOdongOdong = [7, 4, 8, 6, 10, 5, 9, 11];

  

  @override
    Widget build(BuildContext context) {
      // // Sort daftar times
      // times.sort((a, b) {
      //   // Konversi string ke format DateTime untuk perbandingan
      //   final timeA = DateTime.parse('2000-01-01 ' + a + ':00');
      //   final timeB = DateTime.parse('2000-01-01 ' + b + ':00');
      //   return timeA.compareTo(timeB);
      // });

      final List<ChartData> chartData = List.generate(
        times.length,
        (index) => ChartData(times[index], amountTruk[index].toDouble(), amountLori[index].toDouble(), amountOdongOdong[index].toDouble()),
      );
         return Scaffold(
            body: Center(
                child: Container(
                    child: SfCartesianChart(
                      plotAreaBorderWidth: 0,
                      backgroundColor: Colors.white,
                        // plotAreaBackgroundColor: Colors.white,
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
                          majorTickLines: MajorTickLines(size: 0),
                          axisLine: AxisLine(width: 0,),
                          labelStyle: TextStyle(fontSize: 0),
                        ),
                        axes: <ChartAxis>[
                            NumericAxis(
                                name: 'yAxis',
                                opposedPosition: true,
                                title: AxisTitle(
                                    text: 'Secondary Y Axis'
                                )
                            )
                        ],
                        // legend: Legend(
                        //   isVisible: true,
                        //   position: LegendPosition.top
                        // ),
                        series: <CartesianSeries>[
                            StackedBarSeries<ChartData, String>(
                                name:'Truk',
                               dataLabelSettings: DataLabelSettings(
                                isVisible:true,
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white
                               )),
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y1,
                                color: Color(0xFFE9B407)
                                // pointColorMapper: (ChartData, _) => Color(0xFFE9B407)
                            ),
                            StackedBarSeries<ChartData, String>(
                                name:'Lori',
                                dataLabelSettings: DataLabelSettings(
                                  isVisible:true,
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white
                                  ),
                                ),
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y2,
                                color: Color(0xFF32A2D5)
                            ),
                            StackedBarSeries<ChartData, String>(
                                name:'Odong-odong',
                                dataSource: chartData,
                                dataLabelSettings: DataLabelSettings(
                                  isVisible:true,
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white
                                  ),
                                ),
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y3,
                                color: Color(0xFF6EB911),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))
                            ),
                        ]
                    )
                )   
            )
        );
    }
}

class ChartData {
  ChartData(this.x, this.y1, this.y2, this.y3);
  final String x;
  final double y1;
  final double y2;
  final double y3;
  // final double total;
}