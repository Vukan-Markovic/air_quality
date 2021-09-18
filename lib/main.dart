import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'service_locator.dart';
import 'ui/home_page/home.dart';

void main() {
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kvalitet vazduha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      home: const HomePage(),
    );
  }
}
