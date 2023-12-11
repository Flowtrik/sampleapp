
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrcodePage extends StatefulWidget {

  @override
  _QrcodePageState createState() => _QrcodePageState( );
}


class _QrcodePageState extends State<QrcodePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? _scanBarcode;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body:
      Center(
        widthFactor: 200,
      heightFactor: 200,


      child:IconButton(
        icon: Icon(
          Icons.qr_code_scanner_sharp,
          color: Colors.red,
        ),
        onPressed: () {
          print("cdgjcgsdj");
          scanQR();
        },
      )
      )
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    setState(() {
      _scanBarcode = barcodeScanRes;
      print('_scanBarcode******'+_scanBarcode.toString());
      var snackBar = SnackBar(content: Text("Title :"+ _scanBarcode.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    });


  }



}