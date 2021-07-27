import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

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
  final String urlImage = "http://inventory.hafidzniioman.com/product/";

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
            backgroundColor: Colors.white,
            title: Text("Daftar BMN Sukamiskin",
                style: TextStyle(color: Colors.black))),
        body: CustomRefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 2));
          },
          builder: (BuildContext context, Widget child,
              IndicatorController controller) {
            return AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, _) {
                  return Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        if (!controller.isIdle)
                          Positioned(
                              top: 35.0 * controller.value,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  value: !controller.isLoading
                                      ? controller.value.clamp(0.0, 1.0)
                                      : null,
                                ),
                              )),
                        Transform.translate(
                          offset: Offset(0, 100.0 * controller.value),
                          child: child,
                        ),
                      ]);
                });
          },
          child: Center(
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
          ),
        ));
  }

  ListView _itemListView(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
            elevation: 5,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: InkWell(
              onTap: () {
                _navigationToInventoryDetail(context, data[index].id);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    child: Image.network(urlImage + data[index].gambar,
                        height: 150, fit: BoxFit.fitHeight),
                  ),
                  ListTile(
                    title: Text("Nama : " + data[index].nama),
                    subtitle: Text("Merk : " + data[index].merk),
                  ),
                  _textContainer(
                      "Kode Barang : " + data[index].kodeBarang.toString()),
                  _textContainer("No Urut Pendaftaran : " +
                      data[index].noUrutPendaftaran.toString()),
                  _textContainer(
                      "Tahun Peroleh : " + data[index].tahunPeroleh.toString()),
                  _textContainer(
                      "Jumlah Barang : " + data[index].jumlahBarang.toString()),
                  _textContainer("Lokasi : " + data[index].lokasi),
                  // Text(data[index])
                ],
              ),
            ));
      },
    );
  }

  Widget _textContainer(String content) {
    return Container(
      width: 48,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(content),
      ),
    );
  }

  void _navigationToInventoryDetail(
      BuildContext context, Inventory inventoryDetail) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return InventoryInfo(inventoryDetail);
    }));
  }
}
