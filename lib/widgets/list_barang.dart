import 'package:flutter/material.dart';

class ListBarang extends StatefulWidget {
  const ListBarang({Key? key}) : super(key: key);

  @override
  _ListBarangState createState() => _ListBarangState();
}

class _ListBarangState extends State<ListBarang> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("List Data Barang"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {});
              },
              child: Text('List Barang'),
            ),
          ],
        ),
      ),
    );
  }
}
