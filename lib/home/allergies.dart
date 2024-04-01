import 'package:allergi_scan/home/allergy_tile.dart';
import 'package:allergi_scan/models/allergy.dart';
import 'package:flutter/material.dart';
import '../services/database_service.dart';

class Allergies extends StatefulWidget {
  const Allergies({super.key});

  @override
  State<Allergies> createState() => _Allergies();
}

class _Allergies extends State<Allergies> {
  late Future<List<Allergy>> allergiesList = getAllergies();
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Allergy>> getAllergies() async {
    return await _databaseService.allergies();
  }

  Future<void> deleteAllergy(Allergy allergy) async {
    // Suppression de la base de données
    await _databaseService.delete(allergy.id);
    // Actualisation des données
    setState(() {
      allergiesList.then((allergies) =>
          allergies.removeWhere((element) => element.id == allergy.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Allergy>>(
      future: allergiesList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Expanded(child: Text('Erreur : ${snapshot.error}'));
        } else if (snapshot.data!.isEmpty) {
          return const Expanded(
              child: Center(
            child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
                'Commencez par scanner un aliment pour ajouter des intolérances'),
          ));
        } else {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                    key: Key(snapshot.data![index].id.toString()),
                    title: AllergyTile(
                        allergy: snapshot.data![index],
                        deleteAllergy: deleteAllergy));
              },
            ),
          );
        }
      },
    );
  }
}
