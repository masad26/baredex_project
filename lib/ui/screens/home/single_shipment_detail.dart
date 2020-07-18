import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/viewmodels/shipment_list_view_model.dart';
import 'package:baredex/ui/screens/base_view.dart';
import 'package:baredex/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class SingleShipmentDetail extends StatefulWidget {
  final int shipmentId;
  SingleShipmentDetail(this.shipmentId);

  @override
  _SingleShipmentDetailState createState() => _SingleShipmentDetailState();
}

class _SingleShipmentDetailState extends State<SingleShipmentDetail> {
  Logger log = getLogger("SingleShipmentDetail");
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var shipment;
    String firstName;
    String lastName;
    String day;
    String dayName;
    String month;
    String year;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).accentColor,
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              _buildBottomSheet(context);
            },
          )
        ],
      ),
      body: BaseView<ShipmentListViewModel>(
        onModelReady: (model) => model.getShimentsData(),
        builder: (context, model, child) {
          if (model.state != ViewState.Busy) {
            shipment = model.userShipments.data.data
                .singleWhere((f) => f.id == widget.shipmentId);
            firstName = shipment.origin?.firstName ?? '';
            lastName = shipment.origin?.lastName ?? '';
            //var parsedDate = shipment.deliveryTime.toString();
            day =
                DateFormat('EEEE').format(DateTime.parse(shipment.deliverTime));
            dayName =
                DateFormat('d').format(DateTime.parse(shipment.deliverTime));

            month =
                DateFormat('MMMM').format(DateTime.parse(shipment.deliverTime));
            year = DateFormat('y').format(DateTime.parse(shipment.deliverTime));
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: model.state == ViewState.Busy
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Column(
                    children: <Widget>[
                      buildShipmentInfoContainer(
                        shipment.trackNumber,
                        '${shipment.totalPrice.toString()}',
                        day,
                        dayName,
                        month,
                        year,
                      ),
                      SizedBox(height: 30.0),
                      buildOriginContainer(firstName + ' ' + lastName),
                      SizedBox(height: 30.0),
                    ],
                  ),
          );
        },
      ),
    );
  }

  void _buildBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20.0),
            )),
            height: 225,
            child: Column(
              children: <Widget>[
                SizedBox(height: 5.0),
                ListTile(
                  leading: Icon(Icons.archive),
                  title: Text("Archive Order"),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  title: Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                LargeButton(
                  title: "Cancel",
                  onPressed: () {},
                )
              ],
            ),
          );
        });
  }

  Container buildShipmentInfoContainer(
    String trackingNumber,
    String totalPrice,
    String day,
    String dayName,
    String month,
    String year,
  ) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child: Center(child: Text("Tracking # $trackingNumber")),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Estimated Delivery Date",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 5.0),
                        RichText(
                          text: TextSpan(
                              text: "$day $dayName",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: " $month $year",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Chip(
                      backgroundColor: Colors.grey[400],
                      padding: EdgeInsets.all(0),
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: 13, vertical: 0),
                      label: Text('In Transit',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 22, left: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Total Shipment Cost",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 7),
                Text(
                  "\$$totalPrice",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.transparent))),
                  child: Center(child: Text("Cost Details")),
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.grey))),
              ),
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.transparent))),
                  child: Center(
                      child: InkWell(
                    child: Text("Track Shaipments"),
                    onTap: () {
                      Navigator.pushNamed(context, 'shipmentTimelineTracking');
                    },
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildOriginContainer(String fromName) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 70.0,
                  height: 70.0,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                ),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                      text: "From ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "$fromName",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey))),
            child: Center(child: Text("Show Details")),
          ),
        ],
      ),
    );
  }
}
