import 'dart:convert';
import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/viewmodels/shipments_rates_view_model.dart';
import 'package:baredex/core/viewmodels/shipments_request_view_model.dart';
import 'package:baredex/ui/screens/base_view.dart';
import 'package:baredex/ui/screens/shippment/payment_service_options.dart';
import 'package:baredex/ui/shared/shared.dart';
import 'package:baredex/ui/shared/widgets/payment_badges.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentView extends StatefulWidget {
  static const String routeName = 'paymentView';

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  Logger log = getLogger("InsertShippmentDetails");
  bool bgColorBlue = false;
  int selctedServiceIndex = 0;

  @override
  void initState() {
    super.initState();
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
            Navigator.pushNamed(context, 'eachShipmentDetail');
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BaseView<ShipmentRatesListViewModel>(
            onModelReady: (model) => model.getShimentsData(),
            builder: (context, model, child) => model.state == ViewState.Busy
                //builder: (context, model, child) => 1 != 1
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      topHeading("Choose Service"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 330.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return PaymentServiceOptions(
                                onPressed: () async {
                                  setState(() {
                                    selctedServiceIndex = index;
                                  });
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(
                                      'service',
                                      jsonEncode(
                                          model.shipmentRates.data[index]));
                                },
                                bgColors:
                                    selctedServiceIndex == index ? true : false,
                                serviceName:
                                    model.shipmentRates.data[index].serviceName,
                                vendor: model.shipmentRates.data[index].vendor,
                                charge: model.shipmentRates.data[index].charge,
                                currency:
                                    model.shipmentRates.data[index].currency,
                                shipmentDate: model
                                    .shipmentRates.data[index].shipmentDate,
                                delivery:
                                    model.shipmentRates.data[index].delivery,
                              );
                            },
                            itemCount: model.shipmentRates.data.length,
                          ),
                        ),
                      ),
                      topHeading("Payment Method"),
                      PaymentBadges(),
                      BaseView<ShipmentRequestViewModel>(
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
                                    title: "Complete my Order",
                                    onPressed: () async {
                                      var makeRequest =
                                          await model.makeShipmentRequest(1);

                                      if (makeRequest.error) {
                                        GlobalSnackBar.show(
                                            context, makeRequest.message);
                                      } else {
                                        Navigator.pushNamed(context, '/');
                                      }
                                    },
                                  ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Row topHeading(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              text,
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
