import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/viewmodels/login_view_model.dart';
import 'package:baredex/ui/screens/base_view.dart';
import 'package:baredex/ui/shared/widgets/drawer_header.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Logger log = getLogger("AppDrawer");

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  DrawerHeaderWidget(),
                  SizedBox(height: 10),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, 'addresses');
                    },
                    title: Text('Your Adresses'),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text('Settings'),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text(
                      'Help',
                    ),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () async {
                      var logoutSuccess = await model.logout();
                      if (logoutSuccess) {
                        Navigator.pushNamed(context, 'login');
                      }
                    },
                    title: model.state == ViewState.Busy
                        ? Center(
                            child: SizedBox(
                              width: 25.0,
                              height: 25.0,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Text(
                            'Logout',
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ],
        ),
      ),
    );
  }
}
