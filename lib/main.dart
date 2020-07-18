import 'package:baredex/core/config/theme.dart';
import 'package:baredex/core/models/login_model.dart';
import 'package:baredex/core/services/authentication_service.dart';
import 'package:baredex/core/viewmodels/cities_view_model.dart';
import 'package:baredex/core/viewmodels/contact_list_view_model.dart';
import 'package:baredex/core/viewmodels/contries_view_model.dart';
import 'package:baredex/core/viewmodels/user_view_model.dart';
import 'package:baredex/locator.dart';
import 'package:baredex/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Login>(
          create: (BuildContext context) =>
              locator<AuthenticationService>().loginController.stream,
        ),
        ChangeNotifierProvider<UserViewModel>(
          create: (BuildContext context) => UserViewModel(),
        ),
        ChangeNotifierProvider<ContactListViewModel>(
          create: (BuildContext context) => ContactListViewModel(),
        ),
        ChangeNotifierProvider<CountryListViewModel>(
          create: (BuildContext context) => CountryListViewModel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Baredex',
        theme: theme,
        initialRoute: initialRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
