import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonutChartRendemen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Donut Chart
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Color(0xFF6EB911),
                  value: 3.8,
                  title: '3.8',
                  badgeWidget: badge('3.8'),
                  badgePositionPercentageOffset: 1,
                  titleStyle: TextStyle(color:  Color(0x00000000)),
                ),
                PieChartSectionData(
                  color: Color(0xFFE9B407),
                  value: 81,
                  // title: '20',
                  badgeWidget: badge('81'),
                  badgePositionPercentageOffset: 1,
                  titleStyle: TextStyle(color:  Color(0x00000000)),
                ),
                PieChartSectionData(
                  color: Color(0xFF48B10B),
                  value: 7.2,
                  // title: '7.2',
                  badgeWidget: badge('7.2'),
                  badgePositionPercentageOffset: 1,
                  titleStyle: TextStyle(color:  Color(0x00000000)),
                ),
                PieChartSectionData(
                  color: Color(0xFF734A00),
                  value: 10,
                  // title: '9',
                  badgeWidget: badge('10'),
                  badgePositionPercentageOffset: 1,
                  titleStyle: TextStyle(color:  Color(0x00000000)),
                ),
              ],
              // centerSpaceRadius: 60, // Untuk memberi ruang di tengah
              sectionsSpace: 0,
              // borderData: FlBorderData(
              //   border: Border.all(),
              // )
            ),
          ),
        ],
      ),
    );
  }

  Widget badge(String title) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFECEAF8),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Text(
        title + '%',
        style: GoogleFonts.inter(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }
}