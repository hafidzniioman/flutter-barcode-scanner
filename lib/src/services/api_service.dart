import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sukamiskin/src/data/models/inventory.dart';

class ApiService {
  final String apiUrl = 'http://inventory.hafidzniioman.com/api/product';
  final String urlImage = "http://inventory.hafidzniioman.com/product/";

  Future<List<Inventory>> retrieveInventory() async {
    final response = await http.get(apiUrl);
    var responseJson = json.decode(response.body);
    return (responseJson['data']['products'] as List)
        .map((e) => Inventory.fromJson(e))
        .toList();
  }
}
