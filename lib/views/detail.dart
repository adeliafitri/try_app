import 'dart:math';
// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:try_app/widgets/dropdown_search_pg.dart';
import 'package:try_app/widgets/nav_drawer.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/app_bar.dart';
import '../widgets/dropdown_date.dart';
import '../widgets/tab_bar_detail.dart';
// import 'package:intl/date_symbol_data_local.dart';

class DetailScreen extends StatefulWidget {
  final int tabIndex;
  const DetailScreen({required this.tabIndex});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class  _DetailScreenState extends State<DetailScreen>{

  final PageController pageController = PageController(initialPage: 0);
  late int _selectedIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<void> _refreshPage() async {
    setState(() {
      // Di sini tidak ada data yang diperbarui, hanya memicu refresh UI
    });
    // Memberi jeda sejenak agar simulasi refresh lebih nyata
    await Future.delayed(Duration(seconds: 2));
  }

  double _scale = 1;
  double _previousScale = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      appBar: ProdisAppBar(
        scaffoldKey: _scaffoldKey, 
        refreshIndicatorKey: _refreshIndicatorKey,
        title: 'Prodis Mobile',
      ),
      extendBody: true,
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshPage,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(16),
          child: GestureDetector(
            onScaleStart: (ScaleStartDetails details) {
              _previousScale = _scale;
            },
            onScaleUpdate: (ScaleUpdateDetails details) {
              setState(() {
                // Batasan minimum dan maksimum untuk skala
                double minScale = 1.0;  // Skala awal
                double maxScale = 3.0;  // Skala maksimum yang diizinkan

                // Hitung skala baru dan batasi dengan clamp
                _scale = (_previousScale * details.scale).clamp(minScale, maxScale);
              });
            },
            onScaleEnd: (ScaleEndDetails details) {
              _previousScale = _scale;
            },
            child: Transform(
              transform: Matrix4.identity()..scale(_scale),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      // margin: EdgeInsets.only(top: 24),
                      width: 0.95.sw,
                      height: 226,
                      decoration: BoxDecoration(
                        color: Color(0xFFD6ECF7),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(
                            color: Color.fromRGBO(17, 34, 90, 0.20000000298023224),
                            offset: Offset(0,4),
                            blurRadius: 20
                        )],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 18),
                            child: Text(
                              'Pabrik Gula', 
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,   
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownSearchPg(),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 18),
                            child: Text(
                              'Tanggal', 
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,   
                              ),
                            ),
                          ),
                          const SizedBox(height: 11),
                          DateSelector(),  
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    // TabBarInContainerExample(),
                    // IntrinsicHeight(
                          // ConstrainedBox(
                          //   constraints: BoxConstraints(
                          //     maxHeight: 2000,
                          //   ),
                            // child: Container(
                              // width: 0.95.sw,
                              // height: 1300,
                              // color: Colors.amber,
                               TabBarInContainerExample(),
                            // ),
                          // ),
                        // ),
                    // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}