import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodData {
  static Future<Map<String, dynamic>> get(String barcode) async {
    final uri = Uri.https('world.openfoodfacts.org','/api/v2/product/$barcode.json');
    final response = await http.get(uri);
    final data = await jsonDecode(response.body);
    return data['product'];
  }
}
