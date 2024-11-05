import 'dart:math';
// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:try_app/widgets/bar_chart.dart';
import 'package:try_app/widgets/donut_chart_tab.dart';
import 'package:try_app/widgets/nav_drawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:try_app/widgets/stacked_bar_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
// import 'package:intl/date_symbol_data_local.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class  _DetailScreenState extends State<DetailScreen>{
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
  void initState() {
    super.initState();
      initializeDateFormatting('id_ID', null).then((_) {
      print('Locale initialized');
      setState(() {}); // Rebuild UI after locale is ready
    });
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
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  // margin: EdgeInsets.only(top: 24),
                  width: 350,
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
                SizedBox(height: 20,),
                // IntrinsicHeight(
                  
                    Container(
                      width: 0.95.sw,
                      height: 2.sh,
                      // color: Colors.amber,
                      child: TabBarInContainerExample(),
                    ),
                // )
            ],
          ),
        ),
      ),
    );
  }
}

class DateSelector extends StatefulWidget {
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime selectedDate = DateTime.now();
  final DateFormat monthFormat = DateFormat('MMMM', 'id_ID');

  void changeDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
  }

  List<int> generateYearList(int range) {
    int currentYear = DateTime.now().year;
    return List<int>.generate(range, (index) => currentYear - range ~/ 2 + index);
  }

  @override
  Widget build(BuildContext context) {
    List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: () {
            changeDate(-1);
          },
        ),
        _buildDateDropdown(
          selectedDate.day,
          List<int>.generate(31, (index) => index + 1),
          (int? newDay) {
            if (newDay != null) {
              setState(() {
              selectedDate = DateTime(
                selectedDate.year,
                selectedDate.month,
                newDay,
              );
            });
            }
          },
        ),
        _buildDateDropdown(
          selectedDate.month,
          List<int>.generate(12, (index) => index + 1),
          (int? newMonth) {
            if (newMonth != null) {
              setState(() {
              selectedDate = DateTime(
                selectedDate.year,
                newMonth,
                selectedDate.day,
              );
            });
            }
          },
          displayText: (int month) => months[month - 1],
        ),
        _buildDateDropdown(
          selectedDate.year,
          generateYearList(50),
          (int? newYear) {
            if (newYear != null) {
              setState(() {
              selectedDate = DateTime(
                newYear,
                selectedDate.month,
                selectedDate.day,
              );
            });
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.arrow_right),
          onPressed: () {
            changeDate(1);
          },
        ),
      ],
    );
  }

  Widget _buildDateDropdown<T>(
      T value, List<T> items, ValueChanged<T?>? onChanged,
      {String Function(T)? displayText}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButton<T>(
        value: value,
        onChanged: onChanged,
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child:  Row(
            mainAxisSize: MainAxisSize.min, // Agar widget tidak terlalu lebar
            children: [
              Text(
                displayText != null ? displayText(item) : item.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // SizedBox(width: 4), // Atur jarak antara teks dan ikon
              
            ],
          ),
          );
        }).toList(),
        icon: Visibility (
          visible:true, 
          child:Transform.rotate(
            angle: -45 * math.pi / 180, // Contoh rotasi 45 derajat
            child: Icon(
              Icons.arrow_drop_down,
              color: Color(0xFF4F46E5),
              size: 24,
            ),
          ),
        ),
        underline: SizedBox(),
      ),
    );
  }
}

class TabBarInContainerExample extends StatelessWidget {
  const TabBarInContainerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        width: double.infinity,
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(17, 34, 90, 0.2),
              offset: const Offset(0, 4),
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TabBar(
              labelColor: const Color(0xFF033689),
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                color: const Color(0xFFD6ECF7),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                border: Border.all(color: Color(0xFFBBE0F1))
              ),
              indicatorWeight: 3.0,
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: 'Selektor'),
                Tab(text: 'Timbang'),
                Tab(text: 'Giling'),
              ],
            ),
            Expanded(
              child: Container(
                color: const Color(0xFFD6ECF7),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: TabBarView(
                  children: [
                    _buildTabContent('Selektor', 'Content for Selektor'),
                    _buildTabContent('Timbang', 'Content for Timbang'),
                    _buildTabContent('Giling', 'Content for Giling'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String title, String description) {
    final List<int> cumulativeData = [34, 50, 101, 4804, 6825, 7605, 12528];

    final List<int> cumulativeDataUnit = [20, 18, 21, 30, 18, 25, 34, 14];
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            width: 340,
            height: 150 + (cumulativeData.length * 30),
            // height: screenHeight * 0.4 + (cumulativeData.length * 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              // boxShadow: [
              //   BoxShadow(
              //     color: const Color.fromRGBO(17, 34, 90, 0.2),
              //     offset: const Offset(0, 4),
              //     blurRadius: 20,
              //   ),
              // ],
            ),
            // padding: const EdgeInsets.all(16),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Kategori',
                    textAlign:  TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 85, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hari Ini',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        's/d Hari Ini',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      width: 232,
                      height: cumulativeData.length * 30,
                      // color: Colors.amber,
                      child: HorizontalBarChart(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(cumulativeData.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              cumulativeData[index].toString(),
                              style: GoogleFonts.poppins(fontSize: 12)
                            ),
                          );
                        }
                      )
                    ),
                  ],
                ),
                SizedBox(height: 4,),
                Divider(
                  color: Color(0xFFE2E8F0),
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Container(
                  // margin: EdgeInsets.all(4),
                  // color: Color(0xFFDDDDDD),
                  width: 285,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFFDDDDDD), // Pindahkan color ke sini // Border akan berfungsi
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                        'Total',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '99',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '31.947',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 340,
            height: 424,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Jenis Pembayaran',
                    textAlign:  TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Container(
                  width: 320,
                  height: 362,
                  child: TabBarPaymentType(),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: 340,
            height: 180 + (cumulativeDataUnit.length * 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Kategori',
                    textAlign:  TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Color(0xFFE9B407),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            SizedBox(width: 4,),
                            Text(
                              'Truk',
                              style: GoogleFonts.inter(
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
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Color(0xFF32A2D5),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            SizedBox(width: 4,),
                            Text(
                              'Lori',
                              style: GoogleFonts.inter(
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
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Color(0xFF6EB911),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            SizedBox(width: 4,),
                            Text(
                              'Odong-odong',
                              style: GoogleFonts.inter(
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
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jam',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Jenis',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Total',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // padding: EdgeInsets.only(left: 16),
                        width: 270,
                        height: cumulativeDataUnit.length * 30, 
                        // color: Colors.white,
                        child: StackedBarChart(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(cumulativeDataUnit.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                cumulativeDataUnit[index].toString(),
                                textAlign: TextAlign.end,
                                style: GoogleFonts.poppins(fontSize: 12)
                              ),
                            );
                          }
                        )
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xFFE2E8F0),
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Container(
                  // margin: EdgeInsets.all(4),
                  // color: Color(0xFFDDDDDD),
                  width: 285,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFFDDDDDD), // Pindahkan color ke sini // Border akan berfungsi
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                        'Total',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 21,
                        color: Color(0xFFFCE4D7),
                        child: Text(
                          '99',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE9B407),
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 21,
                        color: Color(0xFFD6ECF7),
                        child: Text(
                          '99',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF32A2D5),
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 21,
                        color: Color(0xFFE2F1CF),
                        child: Text(
                          '99',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6EB911),
                          ),
                        ),
                      ),
                      Text(
                        '31.947',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class GradientTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _GradientIndicatorPainter();
  }
}

class _GradientIndicatorPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xFF0F00FF), Color(0xFF32A2D5)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(
        Rect.fromLTWH(offset.dx, offset.dy, configuration.size!.width, 4),
      )
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final Offset start = Offset(offset.dx, configuration.size!.height - 4);
    final Offset end = Offset(offset.dx + configuration.size!.width, configuration.size!.height - 4);

    canvas.drawLine(start, end, paint);
  }
}

class TabBarPaymentType extends StatelessWidget {
  const TabBarPaymentType({super.key});

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
          // boxShadow: [
          //   BoxShadow(
          //     color: const Color.fromRGBO(17, 34, 90, 0.2),
          //     offset: const Offset(0, 4),
          //     blurRadius: 20,
          //   ),
          // ],
        ),
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              indicator: GradientTabIndicator(),
              indicatorWeight: 2.0,
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.normal),
              tabs: const [
                Tab(text: 'Hari Ini'),
                Tab(text: 'Sampai Hari Ini'),
              ],
            ),
            Expanded(
              child: Container(
                // color: const Color(0xFFD6ECF7),
                // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: TabBarView(
                  children: [
                    _buildTabPaymentContent('Selektor', 'Content for Selektor'),
                    _buildTabPaymentContent('Timbang', 'Content for Timbang'),
                    _buildTabPaymentContent('Giling', 'Content for Giling'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabPaymentContent(String title, String description) {
    final List<int> cumulativeData = [34, 50, 101, 4804, 6825, 7605, 12528];
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            width: 294,
            height: 294,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              // boxShadow: [
              //   BoxShadow(
              //     color: const Color.fromRGBO(17, 34, 90, 0.2),
              //     offset: const Offset(0, 4),
              //     blurRadius: 20,
              //   ),
              // ],
            ),
            // padding: const EdgeInsets.all(16),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 270,
                  height: 270,
                  // color: Colors.amber,
                  child: DonutChartTab(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Color(0xFF32A2D5),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            SizedBox(width: 4,),
                            Text(
                              'TS',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                // fontWeight: FontWeight.bold,
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
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Color(0xFFE9B407),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            SizedBox(width: 4,),
                            Text(
                              'SBH',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                // fontWeight: FontWeight.bold,
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
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Color(0xFF6EB911),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            SizedBox(width: 4,),
                            Text(
                              'SPT',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                // fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}