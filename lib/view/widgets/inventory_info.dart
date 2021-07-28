import 'package:flutter/material.dart';
import 'package:sukamiskin/src/data/models/inventory.dart';

class InventoryInfo extends StatelessWidget {
  final Inventory inventoryDetail;

  InventoryInfo(this.inventoryDetail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${inventoryDetail.nama}')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _renderBody(context, inventoryDetail),
      ),
    );
  }

  List<Widget> _renderBody(BuildContext context, Inventory inventoryDetail) {
    List<Widget> result = [];
    // Image.network(urlImage + data[index].gambar,)
    String urlImage = "http://inventory.hafidzniioman.com/product/";
    result.add(_bannerImage(urlImage + inventoryDetail.gambar, 240));
    result.addAll(_renderinfo(context, inventoryDetail));
    return result;
  }

  Widget _bannerImage(String url, double height) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          constraints: BoxConstraints.tightFor(height: height),
          child: Image.network(url, fit: BoxFit.fitHeight)),
    );
  }

  List<Widget> _renderinfo(BuildContext context, Inventory inventoryDetail) {
    List<Widget> result = [];
    result.add(_sectionTitle(inventoryDetail.nama));
    result.add(
        _sectionText("Kode Barang : " + inventoryDetail.kodeBarang.toString()));
    result.add(_sectionText("No Urut Pendaftaran : " +
        inventoryDetail.noUrutPendaftaran.toString()));
    result.add(_sectionText("Merk : " + inventoryDetail.merk));
    result.add(_sectionText(
        "Tahun Peroleh : " + inventoryDetail.tahunPeroleh.toString()));
    result.add(_sectionText(
        "Jumlah Barang : " + inventoryDetail.jumlahBarang.toString()));
    result.add(_sectionText("Lokasi : " + inventoryDetail.lokasi));
    return result;
  }

  Widget _sectionTitle(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 4),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _sectionText(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 8, 25, 12),
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }
}
