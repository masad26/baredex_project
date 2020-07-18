import 'dart:convert';

import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/viewmodels/login_view_model.dart';
import 'package:baredex/ui/screens/base_view.dart';
import 'package:baredex/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:baredex/core/config/config.dart';

class LoginView extends StatefulWidget {
  static const String routeName = "/login";
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Logger log = getLogger("Login");

  bool obsecureText = true;

  ModalRoute<dynamic> _route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route?.removeScopedWillPopCallback(_onWillPop);
    _route = ModalRoute.of(context);
    _route?.addScopedWillPopCallback(_onWillPop);
  }

  @override
  void dispose() {
    _route?.removeScopedWillPopCallback(_onWillPop);
    super.dispose();
  }

  Future<bool> _onWillPop() => Future.value(false);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return BaseView<LoginViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Builder(
          builder: (context) => SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 100.0),
                    Text(
                      "Sign In",
                      style: pageHeaderStyle,
                    ),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 60.0),
                      color: Colors.white,
                      child: Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter Email Address";
                                  }
                                  if (!RegExp(
                                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email Address';
                                  }

                                  return null;
                                },
                                decoration:
                                    UIHelper.inputDecoration('Email Address'),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              PasswordFormField(
                                controller: _passwordController,
                                hintText: "Password",
                              )
                            ],
                          ),
                        ]),
                      ),
                    ),
                    Center(
                      child: model.state == ViewState.Busy
                          ? BaredexCircularIndicator()
                          : Container(
                              margin:
                                  EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 10.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: FlatButton(
                                  color: Theme.of(context).accentColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                  ),
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () async {
                                    if (!_formKey.currentState.validate()) {
                                      return;
                                    }
                                    var loginSuccessData = await model.login(
                                        _emailController.text.toString(),
                                        _passwordController.text.toString());

                                    if (loginSuccessData.error) {
                                      GlobalSnackBar.show(
                                          context, loginSuccessData.message);
                                    } else {
                                      Navigator.pushNamed(context, '/');
                                    }
                                  },
                                ),
                              ),
                            ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "You do not have a Baredex account ?",
                          style: TextStyle(
                            color: Color(0xFFF9b9b9b),
                          ),
                        ),
                        FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'signup');
                            },
                            child: Text(
                              "Register",
                              style: linkText,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
