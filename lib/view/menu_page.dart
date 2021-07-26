import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sukamiskin/view/list_barang.dart';
import 'package:sukamiskin/view/scanner_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String data = "Scan Barcode Barang";
  int _currentIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _pages = [
    InventoryList(),
    InventoryList(),
    QRpage(),
    InventoryList(),
    InventoryList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60,
        items: <Widget>[
          Icon(
            Icons.add,
            size: 30,
          ),
          Icon(
            Icons.list,
            size: 30,
          ),
          Icon(
            Icons.qr_code,
            size: 30,
          ),
          Icon(
            Icons.delete_outline_rounded,
            size: 30,
          ),
          Icon(
            Icons.perm_identity,
            size: 30,
          )
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white10,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: _pages[_currentIndex],
    );
  }
}
