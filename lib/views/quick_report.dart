import 'dart:math';
// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:try_app/widgets/dropdown_search_pg.dart';
import 'package:try_app/widgets/nav_drawer.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/app_bar.dart';
import '../widgets/dropdown_date.dart';
import '../widgets/tab_bar_detail.dart';
// import 'package:intl/date_symbol_data_local.dart';

class QuickReportScreen extends StatefulWidget {
  final int tabIndex;
  const QuickReportScreen({required this.tabIndex});

  @override
  State<QuickReportScreen> createState() => _QuickReportScreenState();
}

class  _QuickReportScreenState extends State<QuickReportScreen>{

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
        title: 'Quick Report',
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
              child: Padding(
                padding: const EdgeInsets.symmetric(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 8, left: 24)
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}