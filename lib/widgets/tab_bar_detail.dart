import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:try_app/widgets/bar_chart.dart';
import 'package:try_app/widgets/donut_chart_payment.dart';
// import 'package:try_app/widgets/donut_chart_tab.dart';
import 'package:try_app/widgets/stacked_bar_chart.dart';

import 'detail_giling_list.dart';
import 'gradient_indicator.dart';

class TabBarInContainerExample extends StatelessWidget {
  TabBarInContainerExample({super.key});

  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final List<int> cumulativeData = [34, 50, 101, 4804, 6825, 7605, 12528];

  final List<int> cumulativeDataUnit = [20, 18, 21, 30, 18, 25, 34, 14, 20, 18, 21, 30, 18, 25, 34, 14, 20, 18, 21, 30, 18, 25, 34, 14];

  // List<Widget> tabWidget = [],
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        width: double.infinity,
        height: 900 + (cumulativeData.length * 30 ) + (cumulativeDataUnit.length * 30),
        // height: double.infinity,
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(17, 34, 90, 0.2),
              offset: Offset(0, 4),
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              labelColor: const Color(0xFF033689),
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                color: const Color(0xFFD6ECF7),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                border: Border.all(color: const Color(0xFFBBE0F1)),
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
              // fit: FlexFit.loose,
              child: Container(
                // height: 1000,
                color: const Color(0xFFD6ECF7),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
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
    
    // return SingleChildScrollView(
      // padding: const EdgeInsets.all(0),
      return ListView(
        // shrinkWrap: true,
        // primary: true,
        physics: const ScrollPhysics(),
        children: [
          //Container Kategori TSS
          RepaintBoundary(child: tssCategoryContainer(cumulativeData: cumulativeData)),
          const SizedBox(height: 20),
          //Container Jenis Pembayaran
          const RepaintBoundary(child: PaymentTypeContainer()),
          const SizedBox(height: 20,),
          //Container Kategori Kendaraan
          RepaintBoundary(child: vehicleTypeContainer(cumulativeDataUnit: cumulativeDataUnit))
        ],
      );
    // );
  }
}

class vehicleTypeContainer extends StatelessWidget {
  const vehicleTypeContainer({
    super.key,
    required this.cumulativeDataUnit,
  });

  final List<int> cumulativeDataUnit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
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
          const SizedBox(height: 12,),
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
                          color: const Color(0xFFE9B407),
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      const SizedBox(width: 4,),
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
                          color: const Color(0xFF32A2D5),
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      const SizedBox(width: 4,),
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
                          color: const Color(0xFF6EB911),
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      const SizedBox(width: 4,),
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
          const SizedBox(height: 16,),
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
                SizedBox(
                  // padding: EdgeInsets.only(left: 16),
                  width: 270.w,
                  height: cumulativeDataUnit.length * 30, 
                  // color: Colors.white,
                  child: StackedBarChart(
                    onShowDialog: (kategori) => _showDialog(context, kategori), 
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.5),
                    child: SizedBox(
                      height: cumulativeDataUnit.length * 30,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        // primary: false,
                        itemCount: cumulativeDataUnit.length,
                        itemBuilder: (context, index){
                        return Container(
                            // margin: EdgeInsets.only(top: 1),
                            padding: const EdgeInsets.only(top: 11),
                            child: Text(
                              cumulativeDataUnit[index].toString(),
                              textAlign: TextAlign.end,
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
                // Padding(
                //   padding: const EdgeInsets.only(top: 5.5),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     // mainAxisAlignment: MainAxisAlignment.center,
                //     children: List.generate(cumulativeDataUnit.length, (index) {
                //         return Container(
                //           // margin: EdgeInsets.only(top: 1),
                //           padding: const EdgeInsets.only(top: 11),
                //           child: Text(
                //             cumulativeDataUnit[index].toString(),
                //             textAlign: TextAlign.end,
                //             style: GoogleFonts.poppins(
                //               fontSize: 12,
                //               // backgroundColor: Colors.amber
                //             )
                //           ),
                //         );
                //       }
                //     )
                //   ),
                // ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xFFE2E8F0),
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Container(
            // margin: EdgeInsets.all(4),
            // color: Color(0xFFDDDDDD),
            width: 285.w,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFDDDDDD), // Pindahkan color ke sini // Border akan berfungsi
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
                  color: const Color(0xFFFCE4D7),
                  child: Text(
                    '99',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE9B407),
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 21,
                  color: const Color(0xFFD6ECF7),
                  child: Text(
                    '99',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF32A2D5),
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 21,
                  color: const Color(0xFFE2F1CF),
                  child: Text(
                    '99',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6EB911),
                    ),
                  ),
                ),
                Text(
                  '310',
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
    );
  }
}

class PaymentTypeContainer extends StatelessWidget {
  const PaymentTypeContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
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
          const SizedBox(height: 6),
          SizedBox(
            width: 320.w,
            height: 362,
            child: const TabBarPaymentType(),
          )
        ],
      ),
    );
  }
}

class tssCategoryContainer extends StatelessWidget {
  const tssCategoryContainer({
    super.key,
    required this.cumulativeData,
  });

  final List<int> cumulativeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
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
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // margin: EdgeInsets.only(left: 12),
                width: 0.67.sw,
                height: cumulativeData.length * 30,
                // color: Colors.amber,
                child: HorizontalBarChart(),
              ),
              Expanded(
                child: SizedBox(
                  height: cumulativeData.length * 30,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                        // primary: false,
                    itemCount: cumulativeData.length,
                    itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        cumulativeData[index].toString(),
                        style: GoogleFonts.poppins(fontSize: 12)
                      ),
                    );
                  }),
                ),
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: List.generate(cumulativeData.length, (index) {
              //       return Padding(
              //         padding: const EdgeInsets.only(top: 10.0),
              //         child: Text(
              //           cumulativeData[index].toString(),
              //           style: GoogleFonts.poppins(fontSize: 12)
              //         ),
              //       );
              //     }
              //   )
              // ),
            ],
          ),
          const SizedBox(height: 4,),
          const Divider(
            color: Color(0xFFE2E8F0),
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Container(
            // margin: EdgeInsets.all(4),
            // color: Color(0xFFDDDDDD),
            width: 285.w,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFDDDDDD), // Pindahkan color ke sini // Border akan berfungsi
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
    );
  }
}



class TabBarPaymentType extends StatelessWidget {
  const TabBarPaymentType({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
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
              child: TabBarView(
                children: [
                  _buildTabPaymentContent('Selektor', 'Content for Selektor'),
                  _buildTabPaymentContent('Timbang', 'Content for Timbang'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabPaymentContent(String title, String description) {
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
            ),
            // padding: const EdgeInsets.all(16),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 270,
                  height: 270,
                  // color: Colors.amber,
                  // child: DonutChartTab(),
                  child: DonutChartPayment(),
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
                                color: const Color(0xFF32A2D5),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            const SizedBox(width: 4,),
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
                                color: const Color(0xFFE9B407),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            const SizedBox(width: 4,),
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
                                color: const Color(0xFF6EB911),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            const SizedBox(width: 4,),
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

void _showDialog(BuildContext context, String kategori) {
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
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal:10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Scaffold(
          appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
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
          extendBodyBehindAppBar: true,
          // backgroundColor: Colors.white,
          body: SizedBox(
            // width: 0.95.sw,
            width: MediaQuery.of(context).size.width * 0.95, 
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
              //      padding: EdgeInsets.only(
              //   left: 10,
              //   right: 10,
              //   top: MediaQuery.of(context).padding.top + 60, // Sesuaikan top agar konten di bawah AppBar
              // ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 45),
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
                                  'Pukul ${kategori}',
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
                      const SizedBox(height: 20,),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
      // ),
      );
    },
  );
}
