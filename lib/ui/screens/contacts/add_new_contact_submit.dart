import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/models/city_search_model.dart';
import 'package:baredex/core/viewmodels/add_contact_view_model.dart';
import 'package:baredex/core/viewmodels/cities_view_model.dart';
import 'package:baredex/core/viewmodels/contries_view_model.dart';
import 'package:baredex/ui/screens/base_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:flutter/material.dart';
import 'package:baredex/ui/shared/shared.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewContactSubmit extends StatefulWidget {
  final int selectedCountryCode;
  AddNewContactSubmit(this.selectedCountryCode);

  static String passWordvalue;

  @override
  _AddNewContactSubmitState createState() => _AddNewContactSubmitState();
}

class _AddNewContactSubmitState extends State<AddNewContactSubmit> {
  Logger log = getLogger("Add New Contact Submitted");
  List<City> cities = List<City>();

  final TextEditingController _addressLineOneController =
      TextEditingController();
  final TextEditingController _addressLineTwoController =
      TextEditingController();

  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _citySearchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String firstName;
  String secondName;
  String lastName;
  String companyName;
  String phoneNumber;
  String email;

  String _mySelection;
  String slectedCityZipCode = '00000';
  String addresseCountryname;
  int addresseCountryid;

  @override
  void initState() {
    super.initState();
    getprevouseFormData();
    log.i(widget.selectedCountryCode);
  }

  void getprevouseFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    firstName = prefs.getString("firstName");
    secondName = prefs.getString("secondName");
    lastName = prefs.getString("lastName");
    companyName = prefs.getString("companyName");
    phoneNumber = prefs.getString("phoneNumber");
    email = prefs.getString("email");
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AddContactViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Navigator.pushNamed(context, 'addNewContact');
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
                                child: Consumer<CountryListViewModel>(
                                    builder: (context, model, child) {
                                  model.countryList.data.forEach((f) {
                                    if (f.phoneCode ==
                                        widget.selectedCountryCode) {
                                      addresseCountryname =
                                          f.niceName.toString();
                                      addresseCountryid = f.id;
                                    }
                                  });

                                  return Container(
                                      height: 45.0,
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[400]),
                                      child: Text("$addresseCountryname"));
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: _cityController,
                                  decoration:
                                      UIHelper.inputDecoration('Select City'),
                                  onTap: () =>
                                      _onAlertWithCustomContentPressed(context),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: _zipCodeController,
                                  decoration:
                                      UIHelper.inputDecoration('Zip Code'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                    controller: _addressLineOneController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Required";
                                      }
                                      if (value.length < 2) {
                                        return "Enter atleast 2 charactors";
                                      }
                                      return null;
                                    },
                                    decoration: UIHelper.inputDecoration(
                                        'Street Address')),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(height: 10.0),
                              Expanded(
                                child: TextFormField(
                                    controller: _addressLineTwoController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Required";
                                      }
                                      if (value.length < 2) {
                                        return "Enter atleast 2 charactors";
                                      }
                                      return null;
                                    },
                                    decoration: UIHelper.inputDecoration(
                                        'Building, Apartment, Suite')),
                              ),
                              SizedBox(height: 10.0),
                            ],
                          ),
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
                                    return;
                                  }

                                  var contactCreated = await model.addConact(
                                    firstName,
                                    secondName,
                                    lastName,
                                    companyName,
                                    phoneNumber,
                                    email,
                                    addresseCountryid.toString(),
                                    _cityController.text,
                                    _addressLineOneController.text,
                                    _addressLineTwoController.text,
                                    slectedCityZipCode,
                                  );

                                  if (contactCreated.error) {
                                    GlobalSnackBar.show(
                                        context, contactCreated.message);
                                  } else {
                                    Navigator.pushNamed(context, 'addresses');
                                  }
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

// Alert custom content
  _onAlertWithCustomContentPressed(context) {
    Alert(
        context: context,
        title: "City",
        content: Container(
          padding: EdgeInsets.only(top: 10),
          width: 400,
          height: 400,
          child: BaseView<CitiesListViewModel>(
            onModelReady: (model) =>
                model.getCitiesListData(addresseCountryid, "a"),
            builder: (context, model, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 50.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _citySearchController,
                            onChanged: (value) {
                              model.getCitiesListData(
                                addresseCountryid,
                                value.toString().toLowerCase(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  model.state == ViewState.Busy
                      ? BaredexCircularIndicator()
                      : ListView.builder(
                          itemCount: model.citiesList.data.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(
                                '${model.citiesList.data[index].cityName}'),
                            trailing: Text(
                                '${model.citiesList.data[index].postCode ?? ''}'),
                            onTap: () {
                              setState(() {
                                _mySelection =
                                    model.citiesList.data[index].cityName;
                                slectedCityZipCode =
                                    model.citiesList.data[index].postCode ??
                                        '000';
                              });
                              _cityController.text = _mySelection;
                              _zipCodeController.text = slectedCityZipCode;
                              Navigator.pop(context);
                            },
                          ),
                          shrinkWrap: true,
                        ),
                ],
              );
            },
          ),
        ),
        buttons: []).show();
  }
}
