// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:try_app/widgets/donut_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:try_app/views/detail.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:try_app/widgets/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Daftar item untuk dropdown
  final List<String> _dropdownItems = ['PG Ngadirejo', 'PG Glenmore', 'PG Cinta Manis'];
  
  // Variabel untuk menyimpan nilai yang dipilih
  String? _selectedItem;
  final PageController pageController = PageController(initialPage: 0);
  late int _selectedIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _refreshPage() async {
    setState(() {
      // Di sini tidak ada data yang diperbarui, hanya memicu refresh UI
    });
    // Memberi jeda sejenak agar simulasi refresh lebih nyata
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Prodis Mobile", 
          style: TextStyle(color: Color(0xFF033689),fontWeight: FontWeight.bold, fontSize: 20),),
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF033689)),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        actions: [
          IconButton(
            onPressed: _refreshPage,
            icon: const Icon(Icons.cached, color: Color(0xFF033689),),
          ),
        ],
      ),
      extendBody: true,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // showDialog(
      //     //   context: context,
      //     //   builder: (BuildContext context) {
      //     //     // return const AddTaskAlertDialog();
      //     //   },
      //     // );
      //   },
      //   child: const Icon(Icons.add),
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   notchMargin: 6.0,
      //   clipBehavior: Clip.antiAlias,
      //   child: SizedBox(
      //     height: kBottomNavigationBarHeight,
      //     child: BottomNavigationBar(
      //       currentIndex: _selectedIndex,
      //       selectedItemColor: Colors.brown,
      //       unselectedItemColor: Colors.black,
      //       onTap: (index) {
      //         setState(() {
      //           _selectedIndex = index;
      //           pageController.jumpToPage(index);
      //         });
      //       },
      //       items: const [
      //         BottomNavigationBarItem(
      //           icon: Icon(CupertinoIcons.square_list),
      //           label: '',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(CupertinoIcons.tag),
      //           label: '',
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshPage,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                // margin: EdgeInsets.only(top: 24),
                width: 350,
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
                      child: Image.asset(
                        'assets/images/home.png',
                        width: 364,
                        height: 225,
                        fit: BoxFit.cover, // Atur bagaimana gambar disesuaikan
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0), // Padding horizontal untuk dropdown
                      decoration: BoxDecoration(
                        color: Colors.white, // Warna latar belakang
                        borderRadius: BorderRadius.circular(8.0), // Membuat sudut bulat
                      ),
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.menu(
                          fit: FlexFit.loose, 
                          // constraints: BoxConstraints(),
                          showSearchBox: true,  // Enables the search functionality
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              hintText: 'Cari Pabrik Gula',
                              // fillColor: Colors.amber,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        items: _dropdownItems,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: 'Pilih Pabrik Gula',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                            border: InputBorder.none,  // No underline by default
                          ),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedItem = newValue;  // Store the selected value
                          });
                        },
                        selectedItem: _selectedItem,  // Current selected item
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24), // Memberikan jarak antar box
              Container(
                // margin: EdgeInsets.only(bottom: 60),
                width: 350,
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
                width: 350,
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
                      width: 332,
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
                                  width: 129,
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
                                  width: 129,
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
                                  width: 150,
                                  child: _customDataTimbang('964', 'unit', true),
                                ),
                                Container(
                                  width: 150,
                                  child: _customDataTimbang('493.551', 'unit', false),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 150,
                                  child: _customDataTimbang('493.551', 'ton', true),
                                ),
                                Container(
                                  width: 150,
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
      width: 318,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8)
      ),
      margin: EdgeInsets.only(left: 16, top: 6),
      child: TextButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailScreen()),
          );
        },
        label: Text('Lihat Semua'),
        icon: Icon(Icons.chevron_right, size: 24),
        style: TextButton.styleFrom(
          backgroundColor: Color(0xFF0C356A),
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)
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
    width: 324,
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
    width: 332,
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
                  width: 107,
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

