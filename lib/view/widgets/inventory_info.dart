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
    result.add(_bannerImage(inventoryDetail.gambar, 240));
    result.addAll(_renderinfo(context, inventoryDetail));
    return result;
  }

  List<Widget> _renderinfo(BuildContext context, Inventory inventoryDetail) {
    List<Widget> result = [];
    result.add(_sectionTitle(inventoryDetail.nama));
    result.add(_sectionText(inventoryDetail.merk));
    return result;
  }

  Widget _sectionTitle(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 10),
      child: Text(
        text,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _sectionText(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
      child: Text(text),
    );
  }

  Widget _bannerImage(String url, double height) {
    return Container(
        constraints: BoxConstraints.tightFor(height: height),
        child: Image.network(url, fit: BoxFit.fitWidth));
  }
}
