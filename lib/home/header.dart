import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text('AllergiScan',
              style: GoogleFonts.lilitaOne(
                  textStyle: const TextStyle(
                fontSize: 24,
                letterSpacing: 2.0,
              ))),
        ),
        const Spacer(),
        SizedBox(
          width: 200,
          child: Image.asset('assets/images/allergies.png'),
        ),
      ]),
    );
  }
}
