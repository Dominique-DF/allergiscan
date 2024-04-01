import 'package:allergi_scan/home/allergies.dart';
import 'package:allergi_scan/home/button_scan.dart';
import 'package:allergi_scan/home/header.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(134, 222, 223, 1.0),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Header(),
          Allergies(),
          ButtonScan()
        ],
      ),
    );
  }
}
