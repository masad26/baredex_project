import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class PaymentServiceOptions extends StatefulWidget {
  final Function onPressed;
  final bool bgColors;
  final String serviceName;
  final String vendor;
  final double charge;
  final String currency;
  final String shipmentDate;
  final String delivery;

  const PaymentServiceOptions(
      {Key key,
      this.onPressed,
      this.bgColors,
      this.serviceName,
      this.vendor,
      this.charge,
      this.currency,
      this.shipmentDate,
      this.delivery})
      : super(key: key);

  @override
  _PaymentServiceOptionsState createState() => _PaymentServiceOptionsState();
}

class _PaymentServiceOptionsState extends State<PaymentServiceOptions> {
  Logger log = getLogger("PaymentServiceOptions");
  @override
  Widget build(BuildContext context) {
    // Get date formatted to show below charge
    var delivery = DateTime.parse('${widget.delivery}');
    var formatter = new DateFormat('EEEE 2,MMMM');
    String formated = formatter.format(delivery);

    // Get number of Days Remaining to Deliver Shipment
    final now = DateTime.now();
    final daysRequiredToDelivershipment = delivery.difference(now).inDays;

    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.only(right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            serviceTitle('${widget.serviceName}'),
            Container(
              width: 220,
              child: Card(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Container(
                  decoration: widget.bgColors
                      ? BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Theme.of(context).accentColor,
                            Color(0xFF7193f5),
                          ]),
                          borderRadius: BorderRadius.circular(5.0),
                        )
                      : BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.grey[400], Colors.grey[300]]),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${widget.vendor}',
                              textAlign: TextAlign.end,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 200,
                        height: 190,
                        color: Colors.transparent,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Positioned(
                              left: 20,
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black87),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/daisy-murphy.png"),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                left: 70.0,
                                top: 10.0,
                                child: Text("${Api.originCity}")),
                            Positioned(
                              top: 40,
                              left: 38.0,
                              child: Container(
                                width: 2.0,
                                height: 23.0,
                                color: Colors.black45,
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                height: 40,
                                width: 120,
                                child: Center(
                                  child: Text(
                                    "$daysRequiredToDelivershipment Days",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: 38.0,
                              child: Container(
                                width: 2.0,
                                height: 30.0,
                                color: Colors.black45,
                              ),
                            ),
                            Positioned(
                              left: 20,
                              bottom: 25,
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black87),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/images/stevan.png"),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                left: 70.0,
                                bottom: 35.0,
                                child: Text("${Api.destinationCity}")),
                          ],
                        ),
                      ),
                      Text(
                        '${widget.charge} ${widget.currency}',
                        style: TextStyle(
                            fontSize: 26.0, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Arive $formated",
                        style: TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 20.0)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row serviceTitle(String title) {
    return Row(
      children: <Widget>[
        SizedBox(width: 5.0),
        Text(
          "$title",
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        CircleAvatar(
          radius: 10.0,
          backgroundColor: Colors.grey[400],
          child: Column(
            children: <Widget>[
              SizedBox(height: 5.0),
              Text(
                'i',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
