import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
 void initState() {
  super.initState();
  Future.delayed(Duration(seconds: 3), () {
    Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
    );
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Expanded(
                child: Center(
              child: SvgPicture.asset(
                'lib/images/logo.svg',
                height: 150,
                width: 150,
              ),
            )),
            Text('Developed by Basant Adel')
          ],
        ),
      ),
    );
  }
}
