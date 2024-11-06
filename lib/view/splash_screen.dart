import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smachara_app/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Image.asset(
              'images/splash_pic.jpg',
              fit: BoxFit.cover,
              height: height * .6,
              // width: width * .9,
            ),
            SizedBox(
              height: height * .04,
            ),
            Text(
              "खबर",
              style: GoogleFonts.anton(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              "आपकी खबर, आपकी पसंद ।",
              style: GoogleFonts.anton(
                fontSize: 19,
                letterSpacing: 2,
              ),
            ),
            SizedBox(
              height: height * .04,
            ),
            const SpinKitChasingDots(
              color: Colors.deepOrangeAccent,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
