import 'package:baredex/core/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      color: Theme.of(context).accentColor,
      child: Column(
        children: <Widget>[
          Consumer<UserViewModel>(
            builder: (context, user, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 45),
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage('${user.user.data.userImage}'),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: user.user.data.userImage == null
                      ? Text(
                          '${user.user.data.firstName[0]} ${user.user.data.lastName[0]}',
                          style: TextStyle(
                              fontSize: 55.0, fontWeight: FontWeight.bold),
                        )
                      : Text(""),
                ),
                SizedBox(height: 15.0),
                Text(
                  '${user.user.data.firstName} ${user.user.data.lastName}',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  '716.00',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 0.0),
                Text(
                  'USD',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87.withOpacity(.7),
                  ),
                ),
                SizedBox(height: 5.0),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Add credit',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.location_on,
                  color: Theme.of(context).accentColor,
                )),
            title: Text('1230 King Abdulaziz Rd'),
            subtitle: Text(
              "Home",
              style: TextStyle(color: Colors.indigo),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.location_on,
                  color: Theme.of(context).accentColor,
                )),
            title: Text(
              '1542 Alslam Street',
              style: TextStyle(fontFamily: 'Roboto'),
            ),
            subtitle: Text(
              "Work",
              style: TextStyle(color: Colors.indigo),
            ),
          ),
        ],
      ),
    );
  }
}
