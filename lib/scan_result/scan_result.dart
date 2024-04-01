import 'package:allergi_scan/models/allergy.dart';
import 'package:allergi_scan/scan_result/button_return.dart';
import 'package:allergi_scan/scan_result/header_result.dart';
import 'package:allergi_scan/scan_result/result_tile.dart';
import 'package:allergi_scan/services/openfoodfact_service.dart';
import 'package:flutter/material.dart';
import '../services/database_service.dart';

class ScanResult extends StatefulWidget {
  final String barcode;

  const ScanResult({super.key, required this.barcode});

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  final DatabaseService _databaseService = DatabaseService();

  Future<Map<String, dynamic>> getData() {
    return FoodData.get(widget.barcode);
  }

  Future<List<Allergy>> getAllergies() {
    return _databaseService.allergies();
  }

  List<List<String>> dissociateAllergens(
      List<String> items, List<Allergy> allergies) {
    List<String> founded = [];
    List<String> notFounded = [];

    for (String i in items) {
      bool isPresent = allergies.where((a) => a.item == i).any((_) => true);
      if (isPresent) {
        founded.add(i);
      } else {
        notFounded.add(i);
      }
    }
    return [founded, notFounded];
  }

  Future<void> addAllergy(String item) async {
    // Ajout dans la base de données
    await _databaseService.add(item);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getData(), getAllergies()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erreur : ${snapshot.error}');
          } else {
            final String barcode = widget.barcode;
            final Map<String, dynamic> jsonData =
                snapshot.data![0] as Map<String, dynamic>;
            final List<Allergy> allergies = snapshot.data![1] as List<Allergy>;
            final String productName = jsonData['product_name_fr'];
            final String imgURL = jsonData['image_front_url'];
            final additives = jsonData['additives_original_tags'];
            List<String> additivesString = [];
            if (additives is List<dynamic>) {
              additivesString = additives.cast<String>();
            }
            final allergens = jsonData['allergens_tags'];
            List<String> allergensString = [];
            if (allergens is List<dynamic>) {
              allergensString = allergens.cast<String>();
            }

            final dissociatedAdditives =
                dissociateAllergens(additivesString, allergies);
            final dissociatedAllergenes =
                dissociateAllergens(allergensString, allergies);

            final bool foundAllergies =
                additivesString[0].length + allergensString[0].length > 0;

            return Scaffold(
                backgroundColor: foundAllergies
                    ? const Color.fromRGBO(250, 50, 50, 1.0)
                    : const Color.fromRGBO(134, 222, 223, 1.0),
                body: Padding(
                  padding:
                      const EdgeInsets.only(top: 60.0, left: 10.0, right: 10.0),
                  child: Column(children: [
                    HeaderResult(
                        productName: productName,
                        barCode: barcode,
                        imgURL: imgURL),
                    Row(
                      children: [
                        additives.isNotEmpty
                            ? const Text('Additifs',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold))
                            : const Text('Aucun additif',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: dissociatedAdditives[0].length,
                        itemBuilder: (context, index) {
                          return ResultTile(
                              item: dissociatedAdditives[0][index], alert: true, addAllergy: addAllergy);
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: dissociatedAdditives[1].length,
                        itemBuilder: (context, index) {
                          return ResultTile(
                              item: dissociatedAdditives[1][index], alert: false, addAllergy: addAllergy);
                        },
                      ),
                    ),
                    Row(
                      children: [
                        allergens.isNotEmpty
                            ? const Text('Allergènes',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold))
                            : const Text('Aucun allergène',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: dissociatedAllergenes[0].length,
                        itemBuilder: (context, index) {
                          return ResultTile(
                              item: dissociatedAllergenes[0][index], alert: true, addAllergy: addAllergy);
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: dissociatedAllergenes[1].length,
                        itemBuilder: (context, index) {
                          return ResultTile(
                              item: dissociatedAllergenes[1][index],
                              alert: false, addAllergy: addAllergy);
                        },
                      ),
                    ),
                    const ButtonReturn()
                  ]),
                ));
          }
        });
  }
}
