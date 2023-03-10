import 'package:flutter/material.dart';
import 'package:tomorrow/screen/homescreen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Menu Example',
      home: HomeScreen(),
    );
  }
}
