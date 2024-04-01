import 'package:allergi_scan/models/allergy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class AllergyTile extends StatelessWidget {
  final Allergy allergy;
  final Function(Allergy) deleteAllergy;

  const AllergyTile({super.key, required this.allergy, required this.deleteAllergy});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(allergy.item),
        const Spacer(),
        IconButton(
            onPressed: () => deleteAllergy(allergy),
            icon: SvgPicture.asset('assets/icons/delete-bin-fill.svg')),
      ],
    );
  }
}
