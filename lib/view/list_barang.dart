import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sukamiskin/src/data/models/inventory.dart';
import 'package:sukamiskin/view/widgets/inventory_info.dart';

class InventoryList extends StatefulWidget {
  const InventoryList({Key key}) : super(key: key);

  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  Future<List<Inventory>> _getInventory() async {
    final apiUrl = Uri.parse('http://inventory.hafidzniioman.com/api/product');
    final response = await http.get(apiUrl);
    var responseJson = json.decode(response.body);
    print(response.body);
    return (responseJson['data']['products'] as List)
        .map((e) => Inventory.fromJson(e))
        .toList();
  }

  final List<Inventory> items = [];

  @override
  void initState() {
    super.initState();
    _getInventory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fetch"),
        ),
        body: FutureBuilder<List<Inventory>>(
            future: _getInventory(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Inventory> inventory = snapshot.data;
                return Column(
                    children: inventory
                        .map((e) => Column(
                              children: <Widget>[
                                Text(e.nama),
                              ],
                            ))
                        .toList());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            }));
  }
}
