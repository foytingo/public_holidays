import 'package:flutter/material.dart';
import 'package:public_holidays/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF3DB3FF)),
        useMaterial3: true,
      ),
      home: const SearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

