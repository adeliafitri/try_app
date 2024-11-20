import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class GilingListView extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('EEEE. MMM, d yyyy HH:mm:ss');
    // return formatter.format(dateTime);
    String formattedDate = formatter.format(dateTime);
  
    // Dapatkan time zone
    String timeZone = dateTime.timeZoneName;

    // Gabungkan dengan time zone
    return '$formattedDate $timeZone';
  }

  GilingListView({required this.data});
  @override
  Widget build(BuildContext context){
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index){
        final item = data[index];
        return Padding(
          padding: const EdgeInsets.only(top:0, bottom: 20),
          child: Container(
            // margin: EdgeInsets.only(top: 0),
                    width: 364.w,
                    height: 545,
                    decoration: BoxDecoration(
                      color: Color(0xFFF6FBFF),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(
                        color: Color.fromRGBO(17, 34, 90, 0.20000000298023224),
                        offset: Offset(0,4),
                        blurRadius: 20
                      )],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 11.5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 205.w,
                                // color: Colors.amber,
                                child: Text(
                                  'Nomor Polisi: ${item['nomorPolisi']}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0C356A)
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Nilai Mutu :',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      // fontWeight: FontWeight.bold,
                                      color: Color(0xFF0C356A)
                                    ),
                                  ),
                                  Text(
                                    item['nilaiMutu'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0C356A)
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 15.5),
                          buildDataRow('Nomor SPTA', item['nomorSPTA']),
                          SizedBox(height: 15.5),
                          buildDataRow('Nama Blok', item['namaBlok']),
                          SizedBox(height: 15.5),
                          buildDataRow('Kode Blok', item['kodeBlok']),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                formatDateTime(item['tanggal']),
                                // textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                  color: Color(0xFF0C356A),
                                  // backgroundColor: Colors.amber
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12,),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 325,
                            ),
                            child: Image.asset(
                              'assets/images/foto_giling.png',
                            ),
                          )
                        ]
                      ),
                    ),
                  ),
        );
      },
    );
  }

  Widget buildDataRow(String label, String value) {
    return Row(
      children: [
        Container(
          width: 85,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Color(0xFF0C356A),
            ),
          ),
        ),
        Container(
          width: 5,
          child: Text(
            ':',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Color(0xFF0C356A),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Color(0xFF0C356A),
            ),
          ),
        ),
      ],
    );
  }
}