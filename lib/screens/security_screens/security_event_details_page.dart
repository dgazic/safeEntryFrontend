import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class SecurityEventDetailsPage extends StatefulWidget {
  const SecurityEventDetailsPage({super.key});

  @override
  State<SecurityEventDetailsPage> createState() =>
      _SecurityEventDetailsPageState();
}

class _SecurityEventDetailsPageState extends State<SecurityEventDetailsPage> {
  String? _data;
  Future<String> _scan() async {
    return await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Odustani", false, ScanMode.QR);
  }

  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: 0.2, //lesson.indicatorValue,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        // "\$" + lesson.price.toString(),
        "Ul. Petra Preradovića 28a",
        style: TextStyle(color: Colors.white),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        Icon(
          Icons.event,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Expanded(
          child: Text(
            // lesson.title,
            "Privatna zabava - Pula",
            style: TextStyle(color: Colors.white, fontSize: 28.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 5,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      // lesson.level,
                      "1",
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 5, child: coursePrice)
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
                // image: new DecorationImage(
                // image: new AssetImage("drive-steering-wheel.jpg"),
                // fit: BoxFit.cover,
                // ),
                )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      // lesson.content,
      "Privatna zabava provjeravanje svake osobe",
      style: TextStyle(fontSize: 18.0),
    );
    final scannButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton.icon(
          icon: Icon(Icons.scanner_outlined),
          label: Text(
            "PROVJERI ULAZAK",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async => {_data = await _scan(), print(_data)},
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            bottomContentText,
            Align(alignment: Alignment.bottomCenter, child: scannButton)
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
