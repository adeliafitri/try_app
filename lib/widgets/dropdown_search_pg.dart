import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class DropdownSearchPg extends StatefulWidget {
  @override
  _DropdownSearchPgState createState() => _DropdownSearchPgState();
}
class _DropdownSearchPgState extends State<DropdownSearchPg> with RouteAware{
   // Daftar item untuk dropdown
  final List<String> _dropdownItems = ['PG Ngadirejo', 'PG Glenmore', 'PG Cinta Manis'];
  
  // Variabel untuk menyimpan nilai yang dipilih
  String? _selectedItem;
  
  @override
  void initState() {
    super.initState();
    _loadSelectedItem(); // Memuat nilai yang disimpan dari session
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Daftarkan halaman ini ke RouteObserver
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    // Hapus pendaftaran RouteObserver
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  // Fungsi untuk memuat nilai yang disimpan di SharedPreferences
  Future<void> _loadSelectedItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedItem = prefs.getString('selectedItem');
    setState(() {
      _selectedItem = savedItem ?? _dropdownItems[0];
    });
  }

  // Fungsi untuk menyimpan nilai ke SharedPreferences
  Future<void> _saveSelectedItem(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedItem', value);
  }

  @override
  void didPopNext() {
    _loadSelectedItem(); // Refresh data ketika kembali
  }
  
  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0), // Padding horizontal untuk dropdown
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(8.0), // Membuat sudut bulat
      ),
      child: DropdownSearch<String>(
      popupProps: const PopupProps.menu(
        fit: FlexFit.loose, 
        // constraints: BoxConstraints(),
        showSearchBox: true,  // Enables the search functionality
        searchFieldProps: TextFieldProps(
        decoration: InputDecoration(
          hintText: 'Cari Pabrik Gula',
          // fillColor: Colors.amber,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2), // Border saat input aktif
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1), // Border saat input tidak aktif
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 12 // Mengatur tinggi/padding vertikal
          ),
        ),
        ),
      ),
      items: _dropdownItems,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: 'Pilih Pabrik Gula',
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          border: InputBorder.none,  // No underline by default
        ),
      ),
      onChanged: (String? newValue) async {
          if (newValue != null && newValue != _selectedItem) {
            setState(() {
              _selectedItem = newValue;
            });
            await _saveSelectedItem(newValue); // Simpan nilai yang dipilih ke session
          }
        },
      selectedItem: _selectedItem,  // Current selected item
      ),
    );
  }
}


