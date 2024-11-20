import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:try_app/widgets/bar_chart_spt.dart';
import 'package:try_app/widgets/column_chart.dart';
// import 'package:try_app/widgets/detail_giling_list.dart';
import 'package:try_app/widgets/donut_chart_meja_tebu.dart';
import '../widgets/app_bar.dart';
// import '../widgets/donut_chart_payment.dart';
import '../widgets/donut_chart_rendemen.dart';
// import '../widgets/donut_chart_tab.dart';
import '../widgets/dropdown_date.dart';
import '../widgets/dropdown_search_pg.dart';
import '../widgets/gradient_indicator.dart';
import '../widgets/nav_drawer.dart';

class AnalisaScreen extends StatefulWidget {
  // final String kategori;

  // AnalisaScreen({required this.kategori});

  @override
  State<AnalisaScreen> createState() => _AnalisaScreenState();
}

class _AnalisaScreenState extends State<AnalisaScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  double _scale = 1;
  double _previousScale = 1;

  @override
  Widget build(BuildContext context){

    Future<void> _refreshPage() async {
      setState(() {
        // Di sini tidak ada data yang diperbarui, hanya memicu refresh UI
      });
      // Memberi jeda sejenak agar simulasi refresh lebih nyata
      await Future.delayed(Duration(seconds: 2));
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      appBar: ProdisAppBar(
        scaffoldKey: _scaffoldKey, 
        refreshIndicatorKey: _refreshIndicatorKey,
        title: 'Analisa',
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
                          SizedBox(height: 11),
                          DateSelector(),  
                        ],
                      ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: 362.w,
                    height: 380,
                    decoration: BoxDecoration(
                      color: Color(0xFFD6ECF7),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(
                        color: Color.fromRGBO(17, 34, 90, 0.20000000298023224),
                        offset: Offset(0,4),
                        blurRadius: 20
                      )],
                    ),
                    child: MejaTebuContainer(),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: 362.w,
                    constraints: BoxConstraints(
                      minHeight: 200,
                      maxHeight: 1030,
                    ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(12),
                          width: 340.w,
                          height: 284,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(17, 34, 90, 0.20000000298023224),
                              offset: Offset(0,0),
                              blurRadius: 4
                            )],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'Analisis Rendemen',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomCard(
                                      colorCard: Color(0xFFE9B407), 
                                      labelCardUp: 'R Min Hi', 
                                      labelCardDown: 'R Min sd', 
                                      valueCardUp: '5.00', 
                                      valueCardDown: '5.00',
                                      urlImage: 'assets/images/analisis_rendemen1.png',
                                    ),
                                    CustomCard(
                                      colorCard: Color(0xFF6EB911), 
                                      labelCardUp: 'R Max Hi', 
                                      labelCardDown: 'R Max sd', 
                                      valueCardUp: '5.00', 
                                      valueCardDown: '5.00',
                                      urlImage: 'assets/images/analisis_rendemen_max.png',
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(12),
                          width: 340.w,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(17, 34, 90, 0.20000000298023224),
                              offset: Offset(0,0),
                              blurRadius: 4
                            )],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Kategori',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start, // Pastikan tidak ada spacing
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: SizedBox(
                                        height: 224,
                                        child: ColumnChart(),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        height: 224,
                                        child: ColumnChartTotal(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 21),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF6EB911),
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                          ),
                                          const SizedBox(width: 4,),
                                          Text(
                                            'Hari Ini',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE9B407),
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                          ),
                                          const SizedBox(width: 4,),
                                          Text(
                                            's/d Hari Ini',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 380,
                          child: RendemenContainer(),
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: 362.w,
                    height: 296,
                    decoration: BoxDecoration(
                      color: Color(0xFFD6ECF7),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(
                        color: Color.fromRGBO(17, 34, 90, 0.20000000298023224),
                        offset: Offset(0,4),
                        blurRadius: 20
                      )],
                    ),
                    child: SptContainer(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SptContainer extends StatelessWidget {
  SptContainer({
    super.key,
  });

  final List<double> amount = [875.29, 17.11, 350.83];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      width: 340.w,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        // boxShadow: [BoxShadow(
        //   color: Color.fromRGBO(17, 34, 90, 0.20000000298023224),
        //   offset: Offset(0,4),
        //   blurRadius: 20
        // )],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Sisa Pagi Tertimbang',
              textAlign:  TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jam',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Ton',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 270.w,
                height: 200,
                // color: Colors.amber,
                child: BarChartSpt(),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        // primary: false,
                        itemCount: amount.length,
                        itemBuilder: (context, index){
                        return Container(
                            margin: EdgeInsets.only(bottom: index == amount.length - 1 ? 0 : 12),
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              amount[index].toString(),
                              // textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                // backgroundColor: Colors.amber
                              )
                            ),
                          );
                      }),
                    ),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}

class MejaTebuContainer extends StatelessWidget {
  const MejaTebuContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      width: 340.w,
      height: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(17, 34, 90, 0.2),
              offset: const Offset(0, 0),
              blurRadius: 4,
            ),
          ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Meja Tebu',
              textAlign:  TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 320.w,
            height: 300,
            child: const TabBarMejaTebu(),
          )
        ],
      ),
    );
  }
}

class TabBarMejaTebu extends StatelessWidget {
  const TabBarMejaTebu({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              indicator: GradientTabIndicator(),
              indicatorWeight: 2.0,
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              unselectedLabelStyle: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.normal),
              isScrollable: true,
              tabs: const [
                Tab(text: 'Hari Ini'),
                Tab(text: 'Sampai dengan Hari Ini'),
              ],
            ),
            Expanded(
              child: Container(
                // color: const Color(0xFFD6ECF7),
                // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: TabBarView(
                  children: [
                    _buildMejaTebuContent('Selektor', 'Content for Selektor'),
                    _buildMejaTebuContent('Timbang', 'Content for Timbang'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMejaTebuContent(String title, String description) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          const SizedBox(height: 20,),
          // Container(
          //   width: 294,
          //   height: 294,
          //   decoration: BoxDecoration(
          //     // color: Colors.amber,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   // padding: const EdgeInsets.all(16),
          //   child: Column(
          //     // crossAxisAlignment: CrossAxisAlignment.start,
              // children: [
                Container(
                  width: 177.w,
                  height: 188,
                  // color: Colors.amber,
                  // child: DonutChartTab(),
                  child: DonutChartMejaTebu(),
                ),
                const SizedBox(height: 9),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelDonutChart(color: Color(0xFF6EB911), title: 'A'),
                      LabelDonutChart(color: Color(0xFF32A2D5), title: 'B'),
                      LabelDonutChart(color: Color(0xFFE9B407), title: 'C'),
                      LabelDonutChart(color: Color(0xFF033689), title: 'D'),
                      LabelDonutChart(color: Color(0xFF734A00), title: 'E'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LabelDonutChart extends StatelessWidget {
  final Color color;
  final String title;
  const LabelDonutChart({
    required this.color,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10)
            ),
          ),
          SizedBox(width: 4,),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              // fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class RendemenContainer extends StatelessWidget {
  const RendemenContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      width: 340.w,
      height: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(17, 34, 90, 0.2),
              offset: const Offset(0, 0),
              blurRadius: 4,
            ),
          ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Rendemen',
              textAlign:  TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 320.w,
            height: 300,
            child: const TabBarRendemen(),
          )
        ],
      ),
    );
  }
}

class TabBarRendemen extends StatelessWidget {
  const TabBarRendemen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              indicator: GradientTabIndicator(),
              indicatorWeight: 2.0,
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              unselectedLabelStyle: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.normal),
              isScrollable: true,
              tabs: const [
                Tab(text: 'Hari Ini'),
                Tab(text: 'Sampai dengan Hari Ini'),
              ],
            ),
            Expanded(
              child: Container(
                // color: const Color(0xFFD6ECF7),
                // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: TabBarView(
                  children: [
                    _buildRendemenContent('Selektor', 'Content for Selektor'),
                    _buildRendemenContent('Timbang', 'Content for Timbang'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRendemenContent(String title, String description) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          const SizedBox(height: 20,),
                Container(
                  width: 177.w,
                  height: 188,
                  // color: Colors.amber,
                  // child: DonutChartTab(),
                  child: DonutChartRendemen(),
                ),
                const SizedBox(height: 9),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelDonutChart(color: Color(0xFFE9B407), title: '<6,00'),
                      LabelDonutChart(color: Color(0xFF48B10B), title: '6,01-7,00'),
                      LabelDonutChart(color: Color(0xFF734A00), title: '7,01-8,00'),
                      LabelDonutChart(color: Color(0xFF6EB911), title: '>=8'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class LabelDonutChart extends StatelessWidget {
//   final Color color;
//   final String title;
//   const LabelDonutChart({
//     required this.color,
//     required this.title,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 2),
//       child: Row(
//         children: [
//           Container(
//             width: 14,
//             height: 14,
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: BorderRadius.circular(10)
//             ),
//           ),
//           SizedBox(width: 4,),
//           Text(
//             title,
//             style: GoogleFonts.inter(
//               fontSize: 12,
//               // fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CustomCard extends StatelessWidget {
  final Color colorCard;
  final String labelCardUp;
  final String labelCardDown;
  final String valueCardUp;
  final String valueCardDown;
  final String urlImage;

  CustomCard({
    required this.colorCard, 
    required this.labelCardUp, 
    required this.labelCardDown, 
    required this.valueCardUp, 
    required this.valueCardDown,
    required this.urlImage
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145.w,
      height: 211, // Sesuaikan lebar sesuai kebutuhan
      padding: EdgeInsets.only(top:16,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFFD9D9D9),
          width: 1,
          style: BorderStyle.solid
        )
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     blurRadius: 10,
        //     offset: Offset(0, 4),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItem(context, labelCardUp, valueCardUp, colorCard),
          SizedBox(height: 16),
          _buildItem(context, labelCardDown, valueCardDown, colorCard),
          Row(
            children: [
              // _buildChartPlaceholder(),
              Image.asset(urlImage, width: 138.w)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: color,
                ),
              ),
              // Spacer(),
              
            ],
          ),
          Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  // color: Colors.black87,
                ),
              ),
        ],
      ),
    );
  }
}