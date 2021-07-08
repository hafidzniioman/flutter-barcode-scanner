import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sukamiskin/widgets/scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  late String _result;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Scanner"),
      ),
      body: Center(
        child: Text(
          _result != null ? _result : 'Data',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openScanner,
        child: Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _openScanner() {
    Navigator.push(context, MaterialPageRoute(builder: (c) => Scanner()));
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.blueAccent,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(data),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 var cameraScanResult = await scanner.scan();
//                 setState(() {});
//               },
//               child: Text('Scan QR Code'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
