import 'dart:convert';

import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/models/shipment_form_model.dart';
import 'package:baredex/ui/screens/shippment/shipment_form.dart';
import 'package:baredex/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertShippmentDetails extends StatefulWidget {
  @override
  _InsertShippmentDetailsState createState() => _InsertShippmentDetailsState();
}

class _InsertShippmentDetailsState extends State<InsertShippmentDetails> {
  Logger log = getLogger("InsertShippmentDetails");

  List<ShipmentForm> shipments = [];
  List<Shipment> allShipments = [];

  bool _showNext = false;

  @override
  void initState() {
    super.initState();
    allShipments = [];
  }

  void addShipment(String type) {
    setState(() {
      var _shipment = Shipment();
      shipments.add(ShipmentForm(
        shippmentType: type,
        shipment: _shipment,
        onDelete: () => onDelete(_shipment),
      ));
      if (shipments.length > 0) {
        _showNext = true;
      }
    });
  }

  ///on form user deleted
  void onDelete(Shipment _shipment) {
    setState(() {
      var find = shipments.firstWhere(
        (it) => it.shipment == _shipment,
        orElse: () => null,
      );
      if (find != null) shipments.removeAt(shipments.indexOf(find));
      if (shipments.length < 1) {
        _showNext = false;
      }
    });
  }

  ///on save forms
  void onSave() async {
    if (shipments.length > 0) {
      var allValid = true;
      shipments.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = shipments.map((it) => it.shipment).toList();

        double totalWeight = 0.00;

        data.forEach((f) => log.w(totalWeight += f.weight));
        log.w("weight");

        data.forEach((shipment) {
          allShipments.add(shipment);
        });

        log.w("message");
        log.w(totalWeight);
        log.i(jsonEncode(allShipments).toString());

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('packages', jsonEncode(allShipments));
        prefs.setDouble('totalWeight', totalWeight);
        Navigator.pushNamed(context, 'selctFromContact');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(children: <Widget>[]),
            topHeading(),
            shipmentAdd(),
            ListView.builder(
              itemBuilder: (context, index) => shipments[index],
              itemCount: shipments.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            ),
            SizedBox(height: 10.0),
            _showNext
                ? LargeButton(
                    title: "Next",
                    onPressed: () {
                      //saveShipmentsData();
                      // if (!_formKey.currentState.validate()) {
                      //   return;
                      // }
                      //Navigator.pushNamed(context, 'selctFromContact');
                      onSave();
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Container shipmentAdd() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
      height: 60.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          buildOutlineButton('BOX'),
          buildOutlineButton('BAG'),
          buildOutlineButton('ENVELOPE'),
        ],
      ),
    );
  }

  // Widget shippmentCard() {
  //   return
  // }

  Widget buildOutlineButton(String buttonText) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: FlatButton(
        onPressed: () {
          addShipment(buttonText);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: Colors.black54, width: 2.0),
        ),
      ),
    );
  }

  Column nextButton(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'selctToContact');
              },
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(38.0),
                side: BorderSide(color: Theme.of(context).accentColor),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 13.0, horizontal: 72.0),
                  child: Text(
                    "Next",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 30.0)
      ],
    );
  }

  Row topHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Send Package",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
