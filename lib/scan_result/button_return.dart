import 'package:allergi_scan/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonReturn extends StatelessWidget {
  const ButtonReturn({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        side: const BorderSide(
            width: 2, color: Colors.black, style: BorderStyle.solid),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        foregroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromRGBO(146, 218, 179, 1.0));
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        style: style,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/arrow-left-circle-fill.svg',
              width: 36,
              height: 36,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}
