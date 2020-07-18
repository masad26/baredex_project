import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

updateStatusBarColor(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Theme.of(context).accentColor,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
  ));
}
