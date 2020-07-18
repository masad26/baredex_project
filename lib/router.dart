import 'package:baredex/landing.dart';
import 'package:baredex/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const String initialRoute = "landing";
//const String initialRoute = "addNewContactSubmit";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'landing':
        return MaterialPageRoute(builder: (_) => Landing());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'signup':
        return MaterialPageRoute(builder: (_) => SignUpView());
      case 'singleShipmentDetail':
        return MaterialPageRoute(
            builder: (_) => SingleShipmentDetail(settings.arguments));
      case 'shipmentTimelineTracking':
        return MaterialPageRoute(builder: (_) => ShippmentTimeline());
      case 'insertShipmentDetail':
        //var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => InsertShippmentDetails());
      case 'eachShipmentDetail':
        return MaterialPageRoute(builder: (_) => EachShippmentDetails());
      case 'selctFromContact':
        return MaterialPageRoute(builder: (_) => SelectFromContact());
      case 'addresses':
        return MaterialPageRoute(builder: (_) => Addresses());
      case 'addNewContact':
        return MaterialPageRoute(builder: (_) => AddNewContact());
      case 'addNewContactSubmit':
        return MaterialPageRoute(
            builder: (_) => AddNewContactSubmit(settings.arguments));
      case 'selctToContact':
        return MaterialPageRoute(
            builder: (_) => SelectToContact(settings.arguments));
      case 'requestShipment':
        return MaterialPageRoute(builder: (_) => PaymentView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
