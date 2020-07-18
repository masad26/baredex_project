import 'package:flutter/material.dart';

class SmallButton extends StatefulWidget {
  final String title;
  final Function onPressed;

  const SmallButton({
    Key key,
    @required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  _SmallButtonState createState() => _SmallButtonState();
}

class _SmallButtonState extends State<SmallButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
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
