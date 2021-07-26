import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sukamiskin/src/data/models/inventory.dart';
import 'package:sukamiskin/src/utils/styles.dart';
import 'package:sukamiskin/view/widgets/inventory_info.dart';

class InventoryList extends StatefulWidget {
  const InventoryList({Key key}) : super(key: key);

  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  final apiUrl = Uri.parse('http://inventory.hafidzniioman.com/api/product');

  Future<List<Inventory>> _futureInventory() async {
    final response = await http.get(apiUrl);
    var responseJson = json.decode(response.body);
    return (responseJson['data']['products'] as List)
        .map((e) => Inventory.fromJson(e))
        .toList();
  }

  void getInventory() async {
    final response = await http.get(apiUrl);
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(response.body);
    responseData['data']['products'].forEach((inventoryDetail) {
      final Inventory inventory = Inventory(
          nama: inventoryDetail['nama'],
          merk: inventoryDetail['merk'],
          lokasi: inventoryDetail['lokasi'],
          gambar: inventoryDetail['gambar']);
      setState(() {
        items.add(inventory);
      });
    });
  }

  final List<Inventory> items = [];

  @override
  void initState() {
    super.initState();
    _futureInventory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "List Inventory",
          style: Styles.navBarTitle,
        )),
        body: Center(
          child: FutureBuilder(
              future: _futureInventory(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Inventory> inventory = snapshot.data;
                  return _itemListView(inventory);
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('${snapshot.error}');
                }
                return CircularProgressIndicator();
              }),
        ));
  }

  ListView _itemListView(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: InkWell(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    child: Image.network(
                        'http://inventory.hafidzniioman.com/product/' + data[index].gambar,
                        height: 150,
                        fit: BoxFit.fill),
                  ),
                  ListTile(
                    title: Text(data[index].nama),
                    subtitle: Text(data[index].merk),
                  )
                ],
              ),
            ));
      },
    );
  }

  Widget _tile(String nama, String merk, String lokasi, String gambar) =>
      ListTile(
        title: Text(nama,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        subtitle: Text(merk),
        leading: Container(
          constraints: BoxConstraints.tightFor(width: 100.0),
          child: Image.network(gambar, fit: BoxFit.fitWidth),
        ),
      );

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var itemDetail = this.items[index];
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: _itemThumbnail(itemDetail),
      title: _itemTitle(itemDetail),
      onTap: () {
        _navigationToInventoryDetail(context, itemDetail);
      },
    );
  }

  void _navigationToInventoryDetail(
      BuildContext context, Inventory inventoryDetail) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return InventoryInfo(inventoryDetail);
    }));
  }

  Widget _itemThumbnail(Inventory inventory) {
    return Container(
      constraints: BoxConstraints.tightFor(width: 100.0),
      child: inventory.gambar == null
          ? null
          : Image.network(inventory.gambar, fit: BoxFit.fitWidth),
    );
  }

  Widget _itemTitle(Inventory inventory) {
    return Text(inventory.nama, style: Styles.textDefault);
  }
}
// return Scaffold(
//         appBar: AppBar(
//           title: Text("Fetch"),
//         ),
//         body: FutureBuilder<List<Inventory>>(
//             future: _getInventory(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 List<Inventory> inventory = snapshot.data;
//                 return Column(
//                     children: inventory
//                         .map((e) => Column(
//                               children: <Widget>[
//                                 Text(e.nama),
//                               ],
//                             ))
//                         .toList());
//               } else if (snapshot.hasError) {
//                 print(snapshot.error);
//                 return Text('${snapshot.error}');
//               }
//               return CircularProgressIndicator();
//             }));


// body: ListView.builder(
//           itemCount: this.items.length, itemBuilder: _listViewItemBuilder),
