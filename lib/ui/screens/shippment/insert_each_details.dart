import 'dart:convert';

import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/enums/viewstate.dart';

import 'package:baredex/core/models/content_form_model.dart';
import 'package:baredex/core/viewmodels/shipments_rates_view_model.dart';
import 'package:baredex/ui/screens/base_view.dart';

import 'package:baredex/ui/screens/shippment/content_form.dart';
import 'package:baredex/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EachShippmentDetails extends StatefulWidget {
  @override
  _EachShippmentDetailsState createState() => _EachShippmentDetailsState();
}

class _EachShippmentDetailsState extends State<EachShippmentDetails> {
  Logger log = getLogger("InsertShippmentDetails");
  List<ContentForm> contents = [];
  List<Content> allContents = [];

  void addContent() {
    setState(() {
      var _content = Content();
      contents.add(ContentForm(
        content: _content,
        onDelete: () => onDelete(_content),
      ));
    });
  }

  ///on form user deleted
  void onDelete(Content _content) {
    setState(() {
      var find = contents.firstWhere(
        (it) => it.content == _content,
        orElse: () => null,
      );
      if (find != null) contents.removeAt(contents.indexOf(find));
    });
  }

  ///on save forms
  Future onSave() async {
    if (contents.length > 0) {
      var allValid = true;
      contents.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = contents.map((it) => it.content).toList();

        data.forEach((shipment) {
          allContents.add(shipment);
        });

        log.w("message");
        log.i(jsonEncode(allContents).toString());

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('contents', jsonEncode(allContents));
        //Navigator.pushNamed(context, 'requestShipment');
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
            Navigator.pushNamed(context, 'selctFromContact');
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  topHeading(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemBuilder: (context, index) => contents[index],
                  itemCount: contents.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                ),
              ),
              SizedBox(height: 20.0),
              buildAddOutlineButton(context),
              contents.length > 0
                  ? Container(
                      child: BaseView<ShipmentRatesListViewModel>(
                        builder: (context, model, child) =>
                            model.state == ViewState.Busy
                                //builder: (context, model, child) => 1 != 1
                                ? Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : LargeButton(
                                    title: "Next",
                                    onPressed: () async {
                                      await onSave();

                                      var getShipmentRates =
                                          await model.getShimentsData();

                                      if (getShipmentRates.error) {
                                        GlobalSnackBar.show(
                                            context, getShipmentRates.message);
                                      } else {
                                        Navigator.pushNamed(
                                            context, 'requestShipment');
                                      }
                                    },
                                  ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  OutlineButton buildAddOutlineButton(BuildContext context) {
    return OutlineButton(
      onPressed: () {
        //Navigator.pushNamed(context, 'requestShipment');
        addContent();
      },
      borderSide: BorderSide(
        color: Colors.black54,
        width: 1.0,
        style: BorderStyle.solid,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 80.0),
        child: Text(
          "Add",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Colors.black54, width: 1.0),
      ),
    );
  }

  Widget shippmentCard(String shippmentType) {
    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.only(right: 80.0),
                      child: Text(
                        "Item",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      shippmentType,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                OutlineButton(
                  color: Colors.black54,
                  onPressed: () {},
                  child: Icon(Icons.remove),
                  shape: CircleBorder(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Quantity",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 17.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "10",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text(
                        "USD",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.transparent,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Item",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 17.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "12",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text(
                        "USD",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500]),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Item",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 17.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "7.8",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text(
                        "KG",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500]),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Total Value",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 17.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "12",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text(
                        "USD",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500]),
                      )
                    ],
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Row topHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 50, 30.0, 50.0),
            child: Text(
              "Describe each unique item\n"
              "in your shipment Seperatly",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
