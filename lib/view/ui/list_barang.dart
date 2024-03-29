import 'package:flutter/material.dart';
import 'package:sukamiskin/src/data/models/inventory.dart';
import 'package:sukamiskin/src/services/api_service.dart';
import 'package:sukamiskin/view/widgets/inventory_info.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class InventoryList extends StatefulWidget {
  const InventoryList({Key key}) : super(key: key);

  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
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
                future: apiService.retrieveInventory(),
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
      reverse: true,
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
                _navigationToInventoryDetail(context, data[index]);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    child: Image.network(apiService.urlImage + data[index].gambar,
                        height: 150, fit: BoxFit.fitHeight),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.blueGrey),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _textContainer(
                            "Nama Barang : " + data[index].nama.toString()),
                        _textContainer("Merk : " + data[index].merk.toString()),
                        _textContainer("Kode Barang : " +
                            data[index].kodeBarang.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  Widget _textContainer(String content) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 2.0, 2.0, 2.0),
        child: Text(content, style: TextStyle(color: Colors.white)),
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
