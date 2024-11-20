import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'dart:math';

import '../views/detailGiling.dart';

class StackedBarChart extends StatelessWidget {
  final void Function(String kategori) onShowDialog;
  StackedBarChart({required this.onShowDialog});
  
  final List<String> times = [
    '05:00', '04:00', '03:00', '02:00', '01:00', '00:00', '23:00', '22:00', '21:00', '20:00', '19:00', '18:00', '17:00', '16:00', '15:00', '14:00', '13:00', '12:00', '11:00', '10:00', '09:00', '08:00', '07:00', '06:00' 
  ];
  
  final List<int> amountTruk = [4, 15, 9, 6, 10, 4, 2, 4, 4, 0, 9, 6, 0, 4, 2, 4, 6, 10, 4, 2, 4, 4, 0, 9,];
  final List<int> amountLori = [3, 15, 8, 6, 10, 12, 7, 5, 7, 0, 8, 0, 10, 5, 9, 11, 12, 7, 5, 7, 4, 8, 6, 10];
  final List<int> amountOdongOdong = [7, 4, 8, 6, 10, 5, 9, 11, 7, 0, 8, 0, 0, 5, 9, 5, 5, 9, 11, 7, 4, 8, 6, 0];

  Color getColorBasedOnTime(String time) {
  final targetTime = DateFormat('HH:mm').parse(time);
  final now = DateTime.now();

  // Jika target waktu antara pukul 00:00 hingga 05:00, anggap sebagai hari berikutnya
  bool isNextDay = targetTime.hour >= 0 && targetTime.hour <= 5;

  // Tambahkan logika untuk hari berikutnya
  DateTime adjustedTargetTime = isNextDay
      ? DateTime(now.year, now.month, now.day + 1, targetTime.hour, targetTime.minute)
      : DateTime(now.year, now.month, now.day, targetTime.hour, targetTime.minute);

    if (now.isAfter(adjustedTargetTime)) {
      return Colors.blue; // Ubah warna menjadi biru jika sudah lewat
    }
    return Colors.black; // Warna default jika belum lewat
  }

  BorderRadius getBorderRadius(int truk, int lori, int odong) {
    if (odong == 0) {
      if (lori == 0) {
        return BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20));
      }
      return BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20));
    }
    return BorderRadius.zero;
  }


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
        (index) {
          final int truk = amountTruk[index];
          final int lori = amountLori[index];
          final int odong = amountOdongOdong[index];
          // BorderRadius borderRadius = getBorderRadius(truk, lori, odong);

          return ChartData(
            times[index],
            truk.toDouble(),
            lori.toDouble(),
            odong.toDouble(),
            // borderRadius,
          );
        },
      );
         return Scaffold(
            body: Center(
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    final RenderBox box = context.findRenderObject() as RenderBox;
                    final Offset localOffset = box.globalToLocal(details.globalPosition);

                    // Cek jika ketukan berada di rentang area sumbu y (kategori)
                    if (localOffset.dx < 50) { 
                      int chartHeight = 30 * chartData.length; // Rentang ini dapat disesuaikan sesuai dengan layout sumbu y
                      int tappedIndex = (chartHeight - localOffset.dy) ~/ 30; // Perkirakan indeks kategori berdasarkan posisi ketukan
                      if (tappedIndex >= 0 && tappedIndex < chartData.length) {
                        String kategori = chartData[tappedIndex].x;
                        onShowDialog(kategori);
                        // print('Tapped on category: $kategori');
                        // Navigasi ke halaman detail
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => DetailGilingScreen(kategori: kategori),
                        //   ),
                        // );
                        // _showDetailDialog(this.context, kategori);
                      }
                    }
                  },
                  child: SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    backgroundColor: Colors.white,
                      // plotAreaBackgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        majorTickLines: const MajorTickLines(size: 0),
                        axisLine: const AxisLine(width: 0,),
                        labelStyle: GoogleFonts.poppins(
                          // color: Colors.black,
                          fontSize: 12,
                        ),
                        axisLabelFormatter: (AxisLabelRenderDetails details) {
                        String labelTime = details.text;
                        return ChartAxisLabel(
                          labelTime,
                          TextStyle(
                            color: getColorBasedOnTime(labelTime), // Gunakan warna dinamis berdasarkan waktu
                          ),
                        );
                      },
                      ),
                      primaryYAxis: NumericAxis(
                        interval: 5,
                        majorTickLines: const MajorTickLines(size: 0),
                        axisLine: const AxisLine(width: 0,),
                        labelStyle: const TextStyle(fontSize: 0),
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
                              color: const Color(0xFFE9B407),
                              // borderRadius: BorderRadius.only(
                              //   topLeft: Radius.circular(chartData.any((data) => data.y3 == 0 && data.y2 == 0) ? 20 : 0),
                              //   topRight: Radius.circular(chartData.any((data) => data.y3 == 0 && data.y2 == 0) ? 15 : 0),
                              // ),
                              // borderRadius: chartData[0].borderRadius,
                              // borderRadius: getBorderRadius(0, 0, chartData.map((e) => e.y3.toInt()).reduce(max)),
                              // borderRadius: getBorderRadius(data.y1, data.y2, data.y3),
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
                              color: const Color(0xFF32A2D5),
                              // borderRadius: chartData.last.isLoriBorderRadius()
                              // ? BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))
                              // : BorderRadius.zero,
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
                              color: const Color(0xFF6EB911),
                              // borderRadius: chartData.last.isLastNonZero()
                              // ? BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))
                              // : BorderRadius.zero,
                              borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))
                          ),
                      ],
                  ),
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
  // final BorderRadius borderRadius;
  // Metode untuk menentukan bar mana yang terakhir tidak 0
  // bool isLastNonZero() {
  //   return y3 != 0 || y2 != 0 || y1 != 0;
  // };

  bool isTrukBorderRadius() {
    return y3 == 0 && y2 == 0;
    // return false;
  }

  bool isLoriBorderRadius() {
    return y3 != 0;
    // return false;
  }
  // final double total;
}