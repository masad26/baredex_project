import 'package:flutter/material.dart';

class BaredexCircularIndicator extends StatelessWidget {
  const BaredexCircularIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 25.0,
          height: 25.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
