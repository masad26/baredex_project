import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/viewmodels/contries_view_model.dart';
import 'package:baredex/core/viewmodels/register_view_model.dart';
import 'package:baredex/ui/screens/base_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:flutter/material.dart';
import 'package:baredex/ui/shared/shared.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewContact extends StatefulWidget {
  static String passWordvalue;

  @override
  _AddNewContactState createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {
  Logger log = getLogger("Add New Contact");

  final TextEditingController _fistNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey _toolTipKey = GlobalKey();
  String _myCodeSelection;
  bool countryCodeEmptyError = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        body: Builder(
          builder: (context) => SafeArea(
            child: SingleChildScrollView(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  //BaredexLogoHeader(),
                  SizedBox(height: 80.0),
                  Text(
                    "Add Your New Address",
                    style: addContactHeaderStyle,
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 60.0),
                    color: Colors.white,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                    controller: _fistNameController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Required";
                                      }
                                      if (value.length < 2) {
                                        return "Enter atleast 2 charactors";
                                      }
                                      return null;
                                    },
                                    decoration:
                                        UIHelper.inputDecoration('First Name')),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: TextFormField(
                                    controller: _secondNameController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Required";
                                      }
                                      if (value.length < 2) {
                                        return "Enter atleast 1 charactors";
                                      }
                                      return null;
                                    },
                                    decoration: UIHelper.inputDecoration(
                                        'Second Name')),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: TextFormField(
                                    controller: _lastNameController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Required";
                                      }
                                      if (value.length < 2) {
                                        return "Enter atleast 2 charactors";
                                      }
                                      return null;
                                    },
                                    decoration:
                                        UIHelper.inputDecoration('Last Name')),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  controller: _companyNameController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Required";
                                    }
                                    if (value.length < 2) {
                                      return "Enter atleast 2 charactors";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: '',
                                    helperText: "Company Name",
                                    enabledBorder: UIHelper.enabledBorder,
                                    focusedBorder: UIHelper.focusedBorder,
                                    focusedErrorBorder: UIHelper.errorBorder,
                                    errorBorder: UIHelper.errorBorder,
                                    suffixIcon: GestureDetector(
                                      onTap: () async {
                                        final dynamic tooltip =
                                            _toolTipKey.currentState;
                                        tooltip.ensureTooltipVisible();
                                        await Future.delayed(
                                            Duration(seconds: 3));
                                        tooltip.ensureTooltipHide();
                                      },
                                      child: Tooltip(
                                        key: _toolTipKey,
                                        padding: EdgeInsets.all(8.0),
                                        showDuration: Duration(seconds: 2),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).accentColor,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            backgroundColor:
                                                Theme.of(context).accentColor),
                                        message:
                                            'If you do NOT have a company name, please add your first and last name',
                                        child: Icon(
                                          Icons.info,
                                          color: Theme.of(context).accentColor,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 20.0),
                                    Consumer<CountryListViewModel>(
                                      builder: (context, model, child) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: countryCodeEmptyError
                                                  ? Colors.red
                                                  : Colors.grey[500],
                                            ),
                                          ),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                          isDense: true,
                                          isExpanded: true,
                                          hint: Text(""),
                                          value: _myCodeSelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _myCodeSelection = newValue;
                                              countryCodeEmptyError = false;
                                            });
                                            log.w("$_myCodeSelection");
                                          },
                                          items: model.countryList.data
                                              .map((value) {
                                            return DropdownMenuItem(
                                              value: value.phoneCode.toString(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'assets/images/flags/${value.iso.toLowerCase()}.png',
                                                    height: 18.0,
                                                  ),
                                                  Text(
                                                    "${value.id}",
                                                    style: TextStyle(
                                                        color:
                                                            inputLabelHintColors,
                                                        fontSize: 14.0),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    countryCodeEmptyError
                                        ? Text(
                                            "Required",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.red[600],
                                            ),
                                          )
                                        : Text(
                                            "Code",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: inputLabelHintColors,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  controller: _phoneNumberController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Required";
                                    }
                                    if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                        .hasMatch(value)) {
                                      return 'Enter a valid Phone Number';
                                    }

                                    return null;
                                  },
                                  decoration:
                                      UIHelper.inputDecoration('Phone Number'),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                    controller: _emailController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Required";
                                      }
                                      if (!RegExp(
                                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                          .hasMatch(value)) {
                                        return 'Not valid email';
                                      }

                                      return null;
                                    },
                                    decoration: UIHelper.inputDecoration(
                                        'Email Address')),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: model.state == ViewState.Busy
                        ? BaredexCircularIndicator()
                        : Container(
                            margin: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 10.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50.0,
                              child: FlatButton(
                                color: Theme.of(context).accentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                ),
                                child: Text(
                                  'Next',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () async {
                                  if (!_formKey.currentState.validate()) {
                                    if (_myCodeSelection == null) {
                                      setState(() {
                                        countryCodeEmptyError = true;
                                      });
                                      return;
                                    }
                                    return;
                                  }
                                  if (_myCodeSelection == null) {
                                    setState(() {
                                      countryCodeEmptyError = true;
                                    });
                                    return;
                                  }

                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString("firstName",
                                      _fistNameController.text.toString());
                                  prefs.setString("secondName",
                                      _secondNameController.text.toString());
                                  prefs.setString("lastName",
                                      _lastNameController.text.toString());
                                  prefs.setString("companyName",
                                      _companyNameController.text.toString());
                                  prefs.setString("phoneNumber",
                                      '+$_myCodeSelection${_phoneNumberController.text.toString()}');
                                  prefs.setString("email",
                                      _emailController.text.toString());
                                  Navigator.pushNamed(
                                      context, 'addNewContactSubmit',
                                      arguments: int.parse(_myCodeSelection));
                                },
                              ),
                            ),
                          ),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
