import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sukamiskin/src/data/models/inventory.dart';
import 'package:sukamiskin/view/widgets/inventory_info.dart';

final apiUrl = Uri.parse('http://inventory.hafidzniioman.com/api/product');

Future<Inventory> getInventory() async {
  var response = await http.get(apiUrl);
  if (response.statusCode == 200) {
    return Inventory.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class InventoryList extends StatefulWidget {
  const InventoryList({Key? key}) : super(key: key);

  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  late Future<Inventory> futureInventory;

  @override
  void initState() {
    super.initState();
    futureInventory = getInventory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder<Inventory>(
          future: futureInventory,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Text(snapshot.data!.id.toString()),
                  Text(snapshot.data!.nama),
                  Text(snapshot.data!.kodeBarang)
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          }),
    ));
  }
}
