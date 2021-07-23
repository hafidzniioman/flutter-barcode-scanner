import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sukamiskin/src/data/models/inventory.dart';

Future<List<Inventory>> getInventory() async {
  final apiUrl = Uri.parse('http://inventory.hafidzniioman.com/api/product');
  var response = await http.get(apiUrl);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => new Inventory.fromJson(e)).toList();
    // return Inventory.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data from API');
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
    // futureInventory = getInventory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder<List<Inventory>>(
          future: getInventory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Inventory>? data = snapshot.data;
              return _inventoryListView(data);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          }),
    ));
  }

  ListView _inventoryListView(data) {
    return ListView.builder(itemBuilder: (context, index) {
      return _tile(data[index].nama, data[index].merk, Icons.work);
    });
  }

  ListTile _tile(String name, String merk, IconData icon) => ListTile(
        title: Text(name,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        subtitle: Text(merk),
        leading: Icon(icon, color: Colors.blue[500]),
      );
}
