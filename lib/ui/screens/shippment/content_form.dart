import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/models/content_form_model.dart';
import 'package:baredex/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

typedef OnDelete();

class ContentForm extends StatefulWidget {
  final Content content;
  final state = _ContentFormState();
  final OnDelete onDelete;

  ContentForm({Key key, this.content, this.onDelete}) : super(key: key);

  @override
  _ContentFormState createState() => state;
  bool isValid() => state.validate();
}

class _ContentFormState extends State<ContentForm> {
  final _formKey = GlobalKey<FormState>();
  Logger log = getLogger("InsertShippmentDetails");

  double totalValue = 0.0;
  int quatity = 1;
  double unitPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    log.w("build");
    return Center(
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  //color: Colors.red,
                  height: 30.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Item Name",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12.0,
                        ),
                      ),
                      OutlineButton(
                        color: Colors.black54,
                        onPressed: widget.onDelete,
                        child: Icon(Icons.remove),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                ),
                Container(
                  //color: Colors.blueGrey,
                  height: 40.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          initialValue: "Product Name",
                          onSaved: (val) => widget.content.title = val,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(16)
                          ],
                          validator: (value) =>
                              value.isEmpty ? "required" : null,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: UIHelper.focusedBorder,
                            focusedErrorBorder: UIHelper.errorBorder,
                            errorBorder: UIHelper.errorBorder,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(width: 7.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Quantity",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    quatity = int.parse(val);
                                    totalValue = unitPrice * quatity;
                                  });
                                },
                                textAlign: TextAlign.center,
                                initialValue:
                                    widget.content.quantity.toString(),
                                onSaved: (val) =>
                                    widget.content.quantity = int.parse(val),
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(16)
                                ],
                                validator: (value) =>
                                    value.isEmpty ? "required" : null,
                                decoration: UIHelper.inputDecorationWhite(''),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 7.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Value",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    unitPrice = double.parse(val);
                                    totalValue = unitPrice * quatity;
                                  });
                                },
                                initialValue:
                                    widget.content.unitPrice.toString(),
                                onSaved: (val) => widget.content.unitPrice =
                                    double.parse(val),
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(6)
                                ],
                                validator: (value) =>
                                    value.isEmpty || value == '0.0'
                                        ? "required"
                                        : null,
                                decoration:
                                    UIHelper.inputDecorationWhite('USD'),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 7.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Weight",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              TextFormField(
                                initialValue: widget.content.weight.toString(),
                                onSaved: (val) =>
                                    widget.content.weight = double.parse(val),
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(6)
                                ],
                                validator: (value) =>
                                    value.isEmpty || value == '0.0'
                                        ? "required"
                                        : null,
                                decoration: UIHelper.inputDecorationWhite('KG'),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 7.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Total Value",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12.0,
                                ),
                              ),
                              SizedBox(height: 13.0),
                              Text(
                                '$totalValue',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 25.0),
                              Text(
                                "USD",
                                style: TextStyle(
                                    fontSize: 11.0, color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 7.0),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = _formKey.currentState.validate();
    if (valid) _formKey.currentState.save();
    return valid;
  }
}
