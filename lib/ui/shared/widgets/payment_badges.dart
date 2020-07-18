import 'package:flutter/material.dart';

class PaymentBadges extends StatelessWidget {
  const PaymentBadges({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
      height: 90.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Card(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 20.0),
                  Image.asset(
                    'assets/images/visa-icon.png',
                    width: 50.0,
                  ),
                  SizedBox(width: 10.0),
                  Image.asset(
                    'assets/images/mastercard-icon.png',
                    width: 35.0,
                  ),
                  SizedBox(width: 10.0),
                  Image.asset(
                    'assets/images/mada-icon.png',
                    width: 50.0,
                  ),
                  SizedBox(width: 30.0),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            // decoration: BoxDecoration(
            //     border: Border.all(color: Colors.black87),
            //     color: Theme.of(context).accentColor,
            //     borderRadius: BorderRadius.circular(5.0)),
            child: InkWell(
              onTap: () {},
              child: Card(
                color: Colors.black87,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 70.0),
                    Image.asset(
                      'assets/images/apple-pay-icon.png',
                      width: 60.0,
                    ),
                    SizedBox(width: 70.0),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).accentColor,
                    Color(0xFF7193f5),
                  ]),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/baredex-logo.png',
                          width: 80.0,
                        ),
                        Text("Credit")
                      ],
                    ),
                    SizedBox(width: 30.0),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "6,98",
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.w600),
                        ),
                        Text("USD"),
                      ],
                    ),
                    SizedBox(width: 30.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
