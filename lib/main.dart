import 'package:flutter/material.dart';
import 'package:meditap/screens/splash_screen.dart';
import 'package:meditap/utils/colors.dart';

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
        
        colorScheme: ColorScheme.fromSeed(seedColor: primary500),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(249, 250, 250, 1),
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(249, 250, 250, 1),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
              fontFamily: 'Open_Sans',
              fontWeight: FontWeight.w600,
              fontSize: 16
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
