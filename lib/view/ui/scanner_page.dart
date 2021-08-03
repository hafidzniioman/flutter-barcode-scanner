import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRpage extends StatefulWidget {
  @override
  _QRpageState createState() => _QRpageState();
}

class _QRpageState extends State<QRpage> {
  Barcode barcode;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(flex: 5, child: buildQrView(context)),
        Expanded(
            flex: 1,
            child: Center(
              child: Text(
                barcode != null ? '${barcode.code}' : 'Scan a code',
              ),
            ))
      ],
    ));
  }

  Widget buildResult() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white24),
        child: Text(
          barcode != null ? '${barcode.code}' : 'Scan a code',
          maxLines: 3,
        ),
      );

  Widget buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 400.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).accentColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  void onQRViewCreated(QRViewController controller) {
    // setState(() {
    //   this.controller = controller;
    // });
    // controller.scannedDataStream.listen((barcode) {
    //   setState(() {
    //     this.barcode = barcode;
    //   });
    // });

    this.controller = controller;
    bool scanned = false;
    controller.scannedDataStream.listen((barcode) {
      if (!scanned) {
        scanned = true;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SecondRoute()));
      }
    });
  }
}

class SecondRoute extends StatefulWidget {
  const SecondRoute({Key key}) : super(key: key);

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('data'),
    );
  }
}

class ResultScan extends StatefulWidget {
  const ResultScan({Key key}) : super(key: key);

  @override
  _ResultScanState createState() => _ResultScanState();
}

class _ResultScanState extends State<ResultScan> {
  Barcode barcode;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: Text(barcode != null ? '${barcode.code}' : 'Scan a code'),
      ),
    );
  }
}
