import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'main_screen.dart';

void main() async {
  //2 things to do for ads running
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

// RequestConfiguration requestConfiguration = RequestConfiguration(
//   testDeviceIds:
// )

  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bmi calculator',
      theme: ThemeData(
        primarySwatch: Colors.brown,

        //Text Themes
        //
        textTheme: TextTheme(
            //Body Small
            bodySmall: GoogleFonts.roboto(
                fontSize: 14, color: const Color(0xff39AFEA)),
            //Body Medium
            bodyMedium: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
            //
            //Body Large
            bodyLarge: GoogleFonts.roboto(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            //title Medium
            titleMedium: GoogleFonts.montserrat(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.w700),
            //title Large
            titleLarge: GoogleFonts.montserrat(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                color: const Color(0xff39AFEA))),

        //
      ),
      home: const MainScreen(),
    );
  }
}
