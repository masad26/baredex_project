import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/viewmodels/register_view_model.dart';
import 'package:baredex/ui/screens/base_view.dart';
import 'package:baredex/ui/shared/widgets/confirm_password_field.dart';
import 'package:flutter/material.dart';
import 'package:baredex/ui/shared/shared.dart';

class SignUpView extends StatefulWidget {
  static String passWordvalue;

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _fistNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String passValue;

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Builder(
          builder: (context) => SafeArea(
            child: SingleChildScrollView(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: 100.0),
                  Text(
                    "Sign Up",
                    style: pageHeaderStyle,
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
                                        return "Enter First Name";
                                      }
                                      if (value.length < 2) {
                                        return "Enter atleast 2 charactors";
                                      }
                                      return null;
                                    },
                                    decoration:
                                        UIHelper.inputDecoration('First Name')),
                              ),
                              SizedBox(width: 20.0),
                              Expanded(
                                child: TextFormField(
                                    controller: _lastNameController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Enter Last Name";
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
                                    controller: _phoneNumberController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Enter Phone Number";
                                      }
                                      if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                          .hasMatch(value)) {
                                        return 'Enter a valid Phone Number';
                                      }

                                      return null;
                                    },
                                    decoration: UIHelper.inputDecoration(
                                        'Phone Number')),
                              ),
                              SizedBox(width: 20.0),
                              Expanded(
                                child: TextFormField(
                                    controller: _emailController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Enter Email Address";
                                      }
                                      if (!RegExp(
                                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                          .hasMatch(value)) {
                                        return 'Enter a valid email Address';
                                      }

                                      return null;
                                    },
                                    decoration: UIHelper.inputDecoration(
                                        'Email Address')),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: PasswordFormField(
                                  controller: _passwordController,
                                  hintText: "Password",
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Expanded(
                                child: ConfirmPasswordFormField(
                                  controller: _confirmPasswordController,
                                  hintText: "Confirm Password",
                                  passwordValue: passValue,
                                ),
                              ),
                            ],
                          )
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
                                  'Sign Up now',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    passValue =
                                        _passwordController.text.toString();
                                  });

                                  if (!_formKey.currentState.validate()) {
                                    return;
                                  }
                                  var registerRequestData =
                                      await model.register(
                                    _fistNameController.text.toString(),
                                    _lastNameController.text.toString(),
                                    _emailController.text.toString(),
                                    _phoneNumberController.text.toString(),
                                    _passwordController.text.toString(),
                                    _confirmPasswordController.text.toString(),
                                  );

                                  if (registerRequestData.error) {
                                    GlobalSnackBar.show(
                                        context, registerRequestData.message);
                                  } else {
                                    GlobalSnackBar.show(
                                        context, registerRequestData.message);
                                  }
                                },
                              ),
                            ),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an account?",
                        style: inputLabelStyle,
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: Text(
                          "Login",
                          style: linkText,
                        ),
                      ),
                    ],
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
