import 'package:flutter/material.dart';

class HeaderResult extends StatelessWidget {
  final String productName;
  final String barCode;
  final String imgURL;

  const HeaderResult(
      {super.key,
      required this.productName,
      required this.barCode,
      required this.imgURL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: [
                Text(productName,
                    softWrap: true,
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Code barres : $barCode', style: const TextStyle(fontSize: 10.0),),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Image.network(imgURL),
        ),
      ]),
    );
  }
}
