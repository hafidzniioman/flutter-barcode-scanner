import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sukamiskin/src/data/models/inventory.dart';

Future<List<Inventory>> _getInventory() async {
  final apiUrl = Uri.parse('http://inventory.hafidzniioman.com/api/product');
  final response = await http.get(apiUrl);
  var responseJson = json.decode(response.body);
  print(response.body);
  return (responseJson['data']['products'] as List)
      .map((e) => Inventory.fromJson(e))
      .toList();
}
