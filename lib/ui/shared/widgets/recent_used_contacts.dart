import 'package:baredex/ui/shared/widgets/small_button.dart';
import 'package:flutter/material.dart';

class RecentUsedContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Most Recent",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'addNewContact');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text("Add New Contact"),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
          height: 160.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              buildRecentContact("assets/images/ali-hasan.png"),
              buildRecentContact("assets/images/stevan.png"),
              buildRecentContact("assets/images/sara.png"),
              buildRecentContact("assets/images/nnena.png"),
            ],
          ),
        ),
      ],
    );
  }

  // build recent Contact Function

  Widget buildRecentContact(String imageName) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imageName),
              )),
        ),
      ),
      SizedBox(height: 3.0),
      Text(
        "Ali Hassan",
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      ),
      Text(
        "Baha, KSA",
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      )
    ]);
  }
}
