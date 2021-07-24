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
  final List<Inventory> items = [];

  @override
  void initState() {
    super.initState();
    _getInventory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: this.items.length, itemBuilder: _listViewItemBuilder));
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var inventoryDetail = this.items[index];
    return ListTile(
        contentPadding: EdgeInsets.all(10.0),
        leading: _itemThumbnail(inventoryDetail),
        title: _itemTitle(inventoryDetail),
        onTap: () {
          _navigationToInventoryDetail(context, inventoryDetail);
        });
  }

  void _navigationToInventoryDetail(
      BuildContext context, Inventory inventoryDetail) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return InventoryInfo(inventoryDetail);
    }));
  }

  Widget _itemThumbnail(Inventory inventoryDetail) {
    return Container(
      constraints: BoxConstraints.tightFor(width: 100.0),
      child: inventoryDetail.image == null
          ? null
          : Image.network(inventoryDetail.image, fit: BoxFit.fitWidth),
    );
  }

  Widget _itemTitle(Inventory inventoryDetail) {
    return Text(inventoryDetail.nama);
  }

  Future<Inventory> _getInventory() async {
    final apiUrl = Uri.parse('http://inventory.hafidzniioman.com/api/product');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      return Inventory.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
    // final Map<String, dynamic> responseData = json.decode(response.body);
    // responseData['products'].forEach((inventoryDetail) {
    //   final Inventory inventory = Inventory(
    //       id: inventoryDetail['id'],
    //       nama: inventoryDetail['nama'],
    //       kodeBarang: inventoryDetail["kode_barang"],
    //       noUrutPendaftaran: inventoryDetail["no_urut_pendaftaran"],
    //       merk: inventoryDetail["merk"],
    //       tahunPeroleh: inventoryDetail["tahun_peroleh"],
    //       jumlahBarang: inventoryDetail["jumlah_barang"],
    //       satuanBarang: inventoryDetail["satuan_barang"],
    //       lokasi: inventoryDetail["lokasi"],
    //       image: inventoryDetail["image"]);
    //   setState(() {
    //     items.add(inventory);
    //   });
    // });
  }
}
