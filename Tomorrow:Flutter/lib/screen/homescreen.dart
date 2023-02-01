import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tomorrow/screen/write.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer timer;
  int checkSeconds = 0;
  void onTick(Timer timer) {
    checkSeconds++;
    if (checkSeconds == 4) {
      timer.cancel();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Write(),
        ),
      );
    }
  }

  void changeimage() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  @override
  Widget build(BuildContext context) {
    changeimage();
    return Container(
      alignment: const Alignment(0, -0.2),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/background.jpg'), // 배경 이미지
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          heightFactor: 12.5,
          child: Text(
            'Tomorrow',
            style: TextStyle(
              fontSize: 50,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
