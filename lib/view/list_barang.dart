import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sukamiskin/src/data/models/inventory.dart';

final String apiUrl = "http://inventory.hafidzniioman.com/api/product";

Future<List<dynamic>> fetchInventory() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return json.decode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load inventory');
  }
}

class ListBarang extends StatefulWidget {
  const ListBarang({Key? key}) : super(key: key);

  @override
  _ListBarangState createState() => _ListBarangState();
}

class _ListBarangState extends State<ListBarang> {
  late Future<Inventory> futureInventory;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fetch data inventory",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<dynamic>>(
            future: fetchInventory(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data![index]['image']),
                        ),
                        title: Text(snapshot.data![index]['nama']),
                        subtitle: Text(snapshot.data![index]['lokasi']),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
