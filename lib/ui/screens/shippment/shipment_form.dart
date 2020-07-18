import 'package:baredex/core/models/shipment_form_model.dart';
import 'package:baredex/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnDelete();

class ShipmentForm extends StatefulWidget {
  final Shipment shipment;
  final String shippmentType;
  final state = _ShipmentFormState();
  final OnDelete onDelete;

  ShipmentForm({Key key, this.shipment, this.shippmentType, this.onDelete})
      : super(key: key);

  @override
  _ShipmentFormState createState() => state;
  bool isValid() => state.validate();
}

class _ShipmentFormState extends State<ShipmentForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    widget.shipment.quantity = 1;
    var shipmentType = 1;
    if (widget.shippmentType == 'BOX') {
      shipmentType = 1;
    } else if (widget.shippmentType == 'BAG') {
      shipmentType = 2;
    } else if (widget.shippmentType == 'ENVELOPE') {
      shipmentType = 3;
    }
    widget.shipment.type = shipmentType;
    return Center(
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.shippmentType,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(width: 7.0),
                      Expanded(
                        child: TextFormField(
                          initialValue: widget.shipment.weight.toString(),
                          onSaved: (val) =>
                              widget.shipment.weight = double.parse(val),
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(6)
                          ],
                          validator: (value) => value.isEmpty || value == '0.0'
                              ? "required"
                              : null,
                          decoration: UIHelper.inputDecoration('Weight'),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                      SizedBox(width: 7.0),
                      Expanded(
                        child: TextFormField(
                          initialValue: widget.shipment.length.toString(),
                          onSaved: (val) =>
                              widget.shipment.length = double.parse(val),
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(6)
                          ],
                          validator: (value) => value.isEmpty || value == '0.0'
                              ? "required"
                              : null,
                          decoration: UIHelper.inputDecoration('Length'),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                      SizedBox(width: 7.0),
                      Expanded(
                        child: TextFormField(
                          initialValue: widget.shipment.width.toString(),
                          onSaved: (val) =>
                              widget.shipment.width = double.parse(val),
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(6)
                          ],
                          validator: (value) => value.isEmpty || value == '0.0'
                              ? "required"
                              : null,
                          decoration: UIHelper.inputDecoration('Width'),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                      SizedBox(width: 7.0),
                      Expanded(
                        child: TextFormField(
                          initialValue: widget.shipment.height.toString(),
                          onSaved: (val) =>
                              widget.shipment.height = double.parse(val),
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(6)
                          ],
                          validator: (value) => value.isEmpty || value == '0.0'
                              ? "required"
                              : null,
                          decoration: UIHelper.inputDecoration('Height'),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                      SizedBox(width: 7.0),
                    ]),
              ),
            ],
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
