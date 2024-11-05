import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

class DonutChartTab extends StatelessWidget {
  final List<String> categories = [
    'TRT-II MD', 'TSS-III HG', 'TSS-IV HG', 
    'TST-I HG', 'TST-II HG', 'TST-III HG', 'TSS-IV HG'
  ];
  
  final List<int> todayData = [15, 15, 15, 6, 10, 21, 17];

  @override
    Widget build(BuildContext context) {
        final List<ChartData> chartData = [
          ChartData('TS', 9, Color(0xFF32A2D5)),
          ChartData('SBH', 4, Color(0xFFE9B407)), 
          ChartData('SPT', 4, Color(0xFF6EB911)), 
        ];
        return Scaffold(
            body: Center(
                child: Container(
                    child: SfCircularChart(
                      backgroundColor: Colors.white,
                      // legend: Legend(
                      //   isVisible: true,
                      //   position: LegendPosition.bottom
                      // ),
                      annotations: <CircularChartAnnotation>[
                        CircularChartAnnotation(
                          widget: 
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total', 
                                    style:GoogleFonts.poppins(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '17',
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ],
                              )
                            ),
                            verticalAlignment: ChartAlignment.center,
                            // horizontalAlignment: ChartAlignment.center
                        )
                      ],
                        series: <CircularSeries>[
                            // Renders doughnut chart
                            DoughnutSeries<ChartData, String>(
                                dataSource: chartData,
                                pointColorMapper:(ChartData data,  _) => data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                cornerStyle: CornerStyle.bothCurve,
                                explode: true,
                                explodeAll: true,
                                dataLabelSettings: DataLabelSettings(
                                    // Renders the data label
                                    isVisible: true,
                                    labelPosition: ChartDataLabelPosition.outside,
                                    color: Color(0xFFECEAF8)
                                ),
                                radius: '65%',
                                innerRadius: '70%'
                            )
                        ]
                    )
                )
            )
        );
    }
}

    class ChartData {
        ChartData(this.x, this.y, this.color);
            final String x;
            final double y;
            final Color color;
    }