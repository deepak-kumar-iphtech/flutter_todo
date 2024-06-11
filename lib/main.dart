import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 88, 236, 255),
            brightness: Brightness.dark),
        fontFamily: GoogleFonts.poppins().fontFamily,
        //useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
