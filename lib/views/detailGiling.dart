import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:try_app/widgets/detail_giling_list.dart';
import '../widgets/app_bar.dart';
import '../widgets/nav_drawer.dart';

class DetailGilingScreen extends StatefulWidget {
  final String kategori;

  DetailGilingScreen({required this.kategori});

  @override
  State<DetailGilingScreen> createState() => _DetailGilingScreenState();
}

class _DetailGilingScreenState extends State<DetailGilingScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context){
    final List<Map<String, dynamic>> data = [
      {
        'nomorPolisi': 'K 1288 NE',
        'nilaiMutu': 'E',
        'nomorSPTA': 'SG33-03112024-0418',
        'namaBlok': '',
        'kodeBlok': '239887891 / TST-III HG',
        'tanggal': DateTime(2024, 11, 4, 6, 33, 19),
      },
      {
        'nomorPolisi': 'DK 8014 VW',
        'nilaiMutu': 'E',
        'nomorSPTA': 'SG33-03112024-0642',
        'namaBlok': '',
        'kodeBlok': '239887479 / TST-II HG',
        'tanggal': DateTime(2024, 11, 4, 6, 00, 02),
      },
      {
        'nomorPolisi': 'P 9101 UZ',
        'nilaiMutu': 'C',
        'nomorSPTA': 'SG33-03112024-0746',
        'namaBlok': '',
        'kodeBlok': '23988991 / TST-I HG',
        'tanggal': DateTime(2024, 11, 4, 6, 44, 38),
      },
      // Tambahkan data statis lainnya di sini
    ];

    Future<void> _refreshPage() async {
      setState(() {
        // Di sini tidak ada data yang diperbarui, hanya memicu refresh UI
      });
      // Memberi jeda sejenak agar simulasi refresh lebih nyata
      await Future.delayed(Duration(seconds: 2));
    }

    return Scaffold(
      // key: _scaffoldKey,
      // drawer: NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
      title: const Text(
        "Prodis Mobile",
        style: TextStyle(
          color: Color(0xFF033689),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      // leading: IconButton(
      //   icon: const Icon(Icons.menu, color: Color(0xFF033689)),
      //   onPressed: () {
      //     _scaffoldKey.currentState?.openDrawer();
      //   },
      // ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, color: Color(0xFF033689)),
        ),
      ],
      // key: _refreshIndicatorKey,
      ),
      extendBody: true,
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshPage,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      width: 364.w,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Color(0xFFD6ECF7),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(
                          color: Color.fromRGBO(17, 34, 90, 0.20000000298023224),
                          offset: Offset(0,4),
                          blurRadius: 20
                        )],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '04 November 2024',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C356A)
                              ),
                            ),
                            Text(
                              'Pukul ${widget.kategori}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C356A)
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SingleChildScrollView(
                  //   child: Column(
                  //     children: data.map((item) {
                  //       return GilingListView(data: data);
                  //     }).toList(),
                  //   ),
                  // ),
                  Column(
                    children: <Widget>[
                      GilingListView(data: data)
                    ],
                  ),
                  // Container(height:data.length * 550, child: GilingListView(data: data)),
                  // SizedBox(height: 20,)
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}