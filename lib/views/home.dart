// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:try_app/views/detail.dart';

import 'package:try_app/widgets/app_bar.dart';
import 'package:try_app/widgets/dropdown_search_pg.dart';
import 'package:try_app/widgets/nav_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware{
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mendaftarkan RouteAware
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }
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
            transform: Matrix4.identity()..scale(_scale), // Transform untuk zoom
            alignment: Alignment.center,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      // margin: EdgeInsets.only(top: 24),
                      width: 350.w,
                      height: 362,
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
                          Padding(padding: const EdgeInsets.only(top: 16),
                            child: Center(
                              child: Image.asset(
                                'assets/images/home.png',
                                width: 364,
                                height: 225,
                                fit: BoxFit.cover, // Atur bagaimana gambar disesuaikan
                              ),
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 24), // Memberikan jarak antar box
                    Container(
                      // margin: EdgeInsets.only(bottom: 60),
                      width: 350.w,
                      // height: 362,
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
                          _titleInfoCard('Unit'),
                          const SizedBox(height: 6),
                          _buildInfoCard('49 Unit', '495.99 ton', Color(0xff5FB70B), Color(0xFFE9B407)),
                          const SizedBox(height: 8),
                          _titleInfoCard('Antri Timbang'),
                          const SizedBox(height: 6),
                          _buildInfoCard('85 Unit', '495.99 ton', Color(0xff5FB70B), Color(0xFF32A2D5)),
                          const SizedBox(height: 8),
                          _titleInfoCard('Total Bahan Baku Siap Giling'),
                          const SizedBox(height: 6),
                          _buildInfoCard('134 Unit', '495.99 ton', Color(0xff5FB70B), Color(0xff5FB70B)),
                          const SizedBox(height: 28),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      width: 350.w,
                      height: 670,
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
                          _buildHomeCard('Selektor', 'BBT Masuk Selector', FontAwesomeIcons.truck, true, '423', '46.280', 'unit'),
                          _buttonSeeAll(),
            
                          Container(
                            margin: const EdgeInsets.only(left: 16,  top: 20, right: 16),
                            width: 332.w,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(17, 34, 90, 0.2),
                                  offset: Offset(0, 4),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 20, top: 12),
                                      width: 50,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD6ECF7),
                                        borderRadius: BorderRadius.circular(58),
                                      ),
                                      child: Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.rotationY(3.1416), // Flip jika `flipIcon` true
                                          child: ShaderMask(
                                            shaderCallback: (bounds) => LinearGradient(
                                              colors: [Color(0xFF0F00FF), Color(0xFF32A2D5)],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ).createShader(bounds),
                                            child: Icon(
                                              FontAwesomeIcons.scaleBalanced,
                                              size: 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                              'Timbang',
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),  
                                          Text(
                                              'Rekapitulasi BBT Timbang',
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                // fontWeight: FontWeight.w700,
                                              ),
                                            ),  
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, top: 12, bottom: 4),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 129.w,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Hari Ini',
                                              // textAlign: TextAlign.right,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFE9B407)
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Container(
                                        width: 129.w,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              's/d Hari Ini',
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFE9B407)
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                 Row(
                                    children: [
                                      Container(
                                        width: 150.w,
                                        child: _customDataTimbang('964', 'unit', true),
                                      ),
                                      Container(
                                        width: 150.w,
                                        child: _customDataTimbang('493.551', 'unit', false),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 150.w,
                                        child: _customDataTimbang('493.551', 'ton', true),
                                      ),
                                      Container(
                                        width: 150.w,
                                        child: _customDataTimbang('493.551', 'ton', false),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          _buttonSeeAll(),
                          _buildHomeCard('Giling', 'Rekapitulasi Giling', FontAwesomeIcons.dna , true, '964', '493.551', 'ton'),
                          _buttonSeeAll(),
                          // const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}

class _buttonSeeAll extends StatelessWidget {
  const _buttonSeeAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 332.w,
      height: 24,
      margin: EdgeInsets.only(left: 16, top: 6, right: 16),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailScreen(tabIndex: 2,)),
          );
        },
        // label: Text('Lihat Semua'),
        // icon: Icon(Icons.chevron_right, size: 24),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Radius sesuai keinginan
          ),
          // alignment: Alignment.centerRight,
          backgroundColor: Color(0xFF0C356A),
          foregroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lihat Semua',
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)
            ),
            SizedBox(width: 2,),
            Icon(Icons.chevron_right, size: 24),
        ]
        ),
      ),
    );
  }
}

Widget _titleInfoCard(String title){
  return Padding(padding: EdgeInsets.all(16),
  child: Text(
    title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
  );                    
}

// Fungsi untuk membuat kartu informasi
Widget _buildInfoCard(String unit, String ton, Color color, Color colorChart) {
  return Container(
    margin: const EdgeInsets.only(left: 13),
    width: 324.w,
    height: 62,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(7.69),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(17, 34, 90, 0.2),
          offset: Offset(0, 4),
          blurRadius: 20,
        ),
      ],
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // const DonutChart(),
        Positioned(
          // left: -30, // Membuat chart keluar ke kiri
          top: -10,
          bottom: -10,
          child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            height: 80, // Ukuran bundar
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white, // Background putih
              shape: BoxShape.circle, // Bentuk bundar
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black12, // Sedikit bayangan
              //     blurRadius: 8,
              //     offset: Offset(0, 4),
              //   ),
              // ],
            ),
          child: SizedBox(
            height: 50,
            width: 50,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 20, // Space di tengah donut
                sectionsSpace: 0, // Jarak antar slice
                sections: [
                  PieChartSectionData(
                    color: colorChart,
                    value: 100, // Persentase (contoh)
                    radius: 10,
                    showTitle: false, // Tidak tampilkan nilai di chart
                  ),
                  // PieChartSectionData(
                  //   color: Colors.grey.shade200,
                  //   value: greyPercent, // Sisanya
                  //   radius: 10,
                  //   showTitle: false,
                  // ),
                ],
              ),
            ),
          ),
          ),
        ), 
        ),
        Positioned(
          left: 80, // Agar tidak bertabrakan dengan chart
          top: 20,
          child: Row(
            children: [
              Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            unit,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Text(
            ton,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ), 
            ],
          )
        ),
      ],
    ),
  );
}

Widget _buildHomeCard(String title, String subTitle, IconData icon, bool flipIcon, String amountToday, String amountAll, String unit) {
  return Container(
    margin: const EdgeInsets.only(left: 16,  top: 20, right: 16),
    width: 332.w,
    height: 142,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(17, 34, 90, 0.2),
          offset: Offset(0, 4),
          blurRadius: 20,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, top: 12),
              width: 50,
              height: 55,
              decoration: BoxDecoration(
                color: Color(0xFFD6ECF7),
                borderRadius: BorderRadius.circular(58),
              ),
              child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(flipIcon ? 3.1416 : 0), // Flip jika `flipIcon` true
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Color(0xFF0F00FF), Color(0xFF32A2D5)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds),
                    child: Icon(
                      icon,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),  
                   Text(
                      subTitle,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        // fontWeight: FontWeight.w700,
                      ),
                    ),  
                ],
              ),
            ),
          ],
        ),
        CustomDataRow(amount: amountToday, unit: unit, isToday: true),
        CustomDataRow(amount: amountAll, unit: unit, isToday: false),
      ],
    ),
  );
}

// Widget _buttonLihatSemua() {
  
// }

class CustomDataRow extends StatelessWidget {
  final String amount; // Nilai yang ditampilkan
  final String unit; // Unit yang ditampilkan
  final bool isToday; // Menentukan apakah ini untuk "Hari ini" atau "s/d Hari ini"

  CustomDataRow({
    required this.amount,
    required this.unit,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    // Warna berdasarkan kondisi
    final color = isToday ? Color(0xFF0C356A) : Color(0xFF98D0EA);
    final textColor =  Color(0xFFE9B407);

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 12),
      child: Row(
        children: [
          // Kontainer warna di sebelah kiri
          Container(
            width: 5,
            height: 21,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(width: 8), // Spasi antar elemen

          Expanded(
            child: Row(
              children: [
                // Kolom untuk nilai
                Container(
                  width: 107.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        amount,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 6),

                // Kolom untuk unit
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      unit,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 4),

                // Kolom untuk teks "Hari ini" atau "s/d Hari ini"
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isToday ? 'Hari ini' : 's/d Hari ini',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColor, // Mengatur warna teks
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _customDataTimbang(String amount, String unit, bool isToday) {
  final color = isToday ? Color(0xFF0C356A) : Color(0xFF98D0EA);

  return Padding(
      padding: const EdgeInsets.only(left: 20, top: 12),
      child: Row(
        children: [
          // Kontainer warna di sebelah kiri
          Container(
            width: 5,
            height: 21,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(width: 8), // Spasi antar elemen

          Expanded(
            child: Row(
              children: [
                // Kolom untuk nilai
                Container(
                  width: 80,
                  // decoration: BoxDecoration(color: Colors.green),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        amount,
                        // textAlign: TextAlign.right,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 6),

                // Kolom untuk unit
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      unit,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 4),
              ],
            ),
          ),
        ],
      ),
    );
}

