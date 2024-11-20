import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mingcute.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:try_app/views/analisa.dart';
import 'package:try_app/views/home.dart';
import 'package:try_app/views/quick_report.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 45.0, // Ukuran container
                                height: 45.0, // Ukuran container
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/profile.jpg"),
                                    fit: BoxFit.cover, // Menggunakan cover
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shoffiyatul',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0C356A),   
                                ),
                              ),
                              Text(
                                'Magenta',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,   
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24,),
                      Container(
                        width: 232,
                        height: 44,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            );
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(99),
                            ),
                            backgroundColor: const Color(0xFF54B1DC),
                            foregroundColor: const Color(0xFF0C356A),
                            padding: const EdgeInsets.symmetric(horizontal: 12), // Padding dalam tombol
                            textStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start, // Susun ke kiri
                            crossAxisAlignment: CrossAxisAlignment.center, // Rata tengah secara vertikal
                            children: [
                              Icon(FontAwesomeIcons.house, size: 12), // Ikon di sebelah kiri
                              const SizedBox(width: 8), // Jarak antara ikon dan teks
                              Text('Dashboard', textAlign: TextAlign.left),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ListTile(
              leading: Icon(Icons.inbox_outlined, color: Color(0xFF64748B),),
              title: Text('Analisa', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF64748B)),),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnalisaScreen()),
                ),
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ListTile(
              leading: Icon(Icons.move_to_inbox_outlined, color: Color(0xFF64748B),),
              title: Text('Quick Report', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF64748B)),),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuickReportScreen(tabIndex: tabIndex)),
                ),
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ListTile(
              leading: Icon(Icons.insert_chart_outlined, color: Color(0xFF64748B),),
              title: Text('Data PG (GM)', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF64748B)),),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ListTile(
              leading: Icon(MingCuteIcons.mgc_presentation_1_line, color: Color(0xFF64748B)),
              title: Text('Data PG (BOD)', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF64748B)),),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ),
          Divider(
            color: Color(0xFFE2E8F0), // Warna divider
            thickness: 1, // Ketebalan divider
            indent: 0,   // Jarak divider dari sisi kiri
            endIndent: 0, // Jarak divider dari sisi kanan
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ListTile(
              leading: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.14159), // Membalik ikon secara horizontal
                child: Icon(
                  Icons.lock_open_outlined,
                  color: Color(0xFF64748B),
                ),
              ),
              title: Text('Ganti Password', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF64748B)),),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ListTile(
              leading: Icon(Icons.logout_outlined, color: Colors.red,),
              title: Text('Sign Out', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ),
          SizedBox(height: 150,),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Divider(
                color: Color(0xFFE2E8F0), // Warna divider
                thickness: 1, // Ketebalan divider
                indent: 16,   // Jarak divider dari sisi kiri
                endIndent: 16, // Jarak divider dari sisi kanan
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/images/Logo_SGN.png',
                      width: 39,
                      height: 53,
                      fit: BoxFit.cover, // Atur bagaimana gambar disesuaikan
                    ),
                  ),
                  Text(
                    'PT Sinergi Gula Nusantara',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64748B)
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}