import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  Uint8List bytes = Uint8List(0);
  TextEditingController? _outputController;

  @override
  void initState() {
    super.initState();
    this._outputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: Text('Hello world'),
      ),
    );
  }

  Widget _buttonGroup() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scan,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Icon(Icons.qr_code),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Scan")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _scan() async {
    await Permission.camera.request();
    String? barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      this._outputController!.text = barcode;
    }
  }
}

// return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.blueAccent,
//         body: Builder(
//           builder: (BuildContext context) {
//             return ListView(
//               children: <Widget>[
//                 Container(
//                     color: Colors.white,
//                     child: Column(
//                       children: <Widget>[
//                         TextField(
//                           controller: this._outputController,
//                           maxLines: 2,
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.wrap_text),
//                             helperText:
//                                 'The barcode or qrcode you scan will be displayed in this area.',
//                             hintText:
//                                 'The barcode or qrcode you scan will be displayed in this area.',
//                             hintStyle: TextStyle(fontSize: 15),
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 7, vertical: 15),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         this._buttonGroup(),
//                         SizedBox(height: 70),
//                       ],
//                     ))
//               ],
//             );
//           },
//         ),
//       ),
//     );