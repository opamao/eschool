import 'package:eschoolparent/src/features/splash/spalsh.dart';
import 'package:eschoolparent/src/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: appColor),
          textTheme: GoogleFonts.dmSansTextTheme(),
          useMaterial3: true,
        ),
        home: SplashPage(),
      );
    });
  }
}