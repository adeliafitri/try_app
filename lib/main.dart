import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'views/home.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// void main() {
//   runApp(const MyApp());
// }
const Map<int, Color> whiteColorSwatch = {
  50: Color(0xFFFFFFFF),
  100: Color(0xFFFFFFFF),
  200: Color(0xFFFFFFFF),
  300: Color(0xFFFFFFFF),
  400: Color(0xFFFFFFFF),
  500: Color(0xFFFFFFFF),
  600: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
  800: Color(0xFFFFFFFF),
  900: Color(0xFFFFFFFF),
};

const MaterialColor whiteSwatch = MaterialColor(0xFFFFFFFF, whiteColorSwatch);
Future main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null).then((_) => runApp(const ToDoApp())); 
  // await Firebase.initializeApp();
  // runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),  // Ukuran desain dasar (misalnya untuk iPhone 11 Pro)
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: whiteSwatch, // Menggunakan MaterialColor putih
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key?key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Todo List',
//       theme: ThemeData(   
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const MyHomePage(title: 'To Do List'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final PageController pageController = PageController(initialPage: 0);
//   late int _selectedIndex = 0;

//   // int _counter = 0;

//   // void _incrementCounter() {
//   //   setState(() {
//   //     _counter++;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
   
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//         centerTitle: true,
//       ),
//       extendBody: true,
//       body: PageView(
//         controller: pageController,
//         children: const <Widget>[
//           Center(
//             child: Home(),
//           ),
//           Center(
//             child: Search(),
//           ),
//           Center(
//             child: Favourite(),
//           ),
//           Center(
//             child: Profile(),
//           ),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         tooltip: 'Add',
//         child: const Icon(Icons.add),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12), // Atur radius sesuai kebutuhan
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 5.0,
//         clipBehavior: Clip.antiAlias,
//         child: SizedBox(
//           // height: kBottomNavigationBarHeight,
//           child: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//             currentIndex: _selectedIndex,
//             selectedItemColor: Colors.white,
//             unselectedItemColor: Colors.black,
//             onTap: (index) {
//               setState(() {
//                 _selectedIndex = index;
//                 pageController.jumpToPage(index);
//               });
//             },
//             items: [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home_outlined),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.search),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.favorite_border_outlined),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.account_circle_outlined),
//                 label: '',
//               ),
//           ]),
//         ),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
   
//   @override
//   Widget build(BuildContext context){
//     return const Text('Home');
//   }
// }

// class Search extends StatelessWidget {
//   const Search({Key? key}) : super(key: key);
   
//   @override
//   Widget build(BuildContext context){
//     return const Text('Search');
//   }
// }

// class Favourite extends StatelessWidget {
//   const Favourite({Key? key}) : super(key: key);
   
//   @override
//   Widget build(BuildContext context){
//     return const Text('Favourite');
//   }
// }

// class Profile extends StatelessWidget {
//   const Profile({Key? key}) : super(key: key);
   
//   @override
//   Widget build(BuildContext context){
//     return const Text('Profile');
//   }
// }