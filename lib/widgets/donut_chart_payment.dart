import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class DonutChartPayment extends StatelessWidget {
  const DonutChartPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // CustomPaint untuk menggambar border dengan ujung bulat
          CustomPaint(
            size: const Size(250, 250),
            painter: RoundedBorderPainter(),
          ),
          // Donut Chart
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: const Color(0xFF6EB911),
                  value: 4,
                  title: '4',
                  badgeWidget: badge('4'),
                  badgePositionPercentageOffset: 1,
                  titleStyle: const TextStyle(color:  Color(0x00000000)),
                ),
                PieChartSectionData(
                  color: const Color(0xFFE9B407),
                  value: 4,
                  // title: '4',
                  badgeWidget: badge('4'), 
                  badgePositionPercentageOffset: 1,
                  titleStyle: const TextStyle(color:  Color(0x00000000)),
                ),
                PieChartSectionData(
                  color: const Color(0xFF32A2D5),
                  value: 9,
                  // title: '9',
                  badgeWidget: badge('9'),
                  badgePositionPercentageOffset: 1,
                  titleStyle: const TextStyle(color:  Color(0x00000000)),
                ),
              ],
              centerSpaceRadius: 60, // Untuk memberi ruang di tengah
              sectionsSpace: 10,
              // borderData: FlBorderData(
              //   border: Border.all(),
              // )
            ),
          ),
          // Text di tengah chart
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              Text(
                '15',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget badge(String title) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFECEAF8),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class RoundedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Membuat ujung rounded

    // Menggambar border di sepanjang lingkaran chart
    double radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Angle dari setiap section chart (disesuaikan dengan data chart)
    List<double> angles = [0, 4 / 15 * 2 * pi, 8 / 15 * 2 * pi, 2 * pi];
    for (int i = 0; i < angles.length - 1; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - 6),
        angles[i],
        angles[i + 1] - angles[i] - 0.1,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}