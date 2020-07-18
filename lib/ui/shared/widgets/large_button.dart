import 'package:flutter/material.dart';

class LargeButton extends StatefulWidget {
  final String title;
  final Function onPressed;

  const LargeButton({
    Key key,
    @required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  _LargeButtonState createState() => _LargeButtonState();
}

class _LargeButtonState extends State<LargeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
      height: 50,
      child: FlatButton(
        onPressed: this.widget.onPressed,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        color: Theme.of(context).accentColor,
        disabledColor: Theme.of(context).accentColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(28.0),
            side: BorderSide(color: Colors.transparent)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              this.widget.title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
