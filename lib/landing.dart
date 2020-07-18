import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/config.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  Logger log = getLogger("Landing");

  void _checkUserLoggedinStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');

    log.e(accessToken);

    if (accessToken == null) {
      Navigator.pushNamed(context, 'login');
    } else {
      Navigator.pushNamed(context, '/');
    }
  }

  @override
  void initState() {
    _checkUserLoggedinStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
