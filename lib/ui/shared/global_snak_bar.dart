import 'package:flutter/material.dart';

class GlobalSnackBar {
  final String message;

  const GlobalSnackBar({
    @required this.message,
  });

  static show(
    BuildContext context,
    String message,
  ) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        elevation: 1.0,
        behavior: SnackBarBehavior.fixed,
        content: Text(
          message,
          style: TextStyle(color: Colors.black87),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.yellow[300],
      ),
    );
  }
}
