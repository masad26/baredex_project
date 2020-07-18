import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/viewmodels/contact_list_view_model.dart';
import 'package:baredex/ui/screens/base_view.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Addresses extends StatefulWidget {
  static const routeName = '/addresses';
  @override
  _AddressesState createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  Logger log = getLogger("Addresses");
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          child: BaseView<ContactListViewModel>(
            onModelReady: (model) => model.getContactsListData(),
            builder: (context, model, child) => model.state == ViewState.Busy
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // fromUserId is not 0 show the Selcted Contact
                      // in a Card instead of the top section
                      topSection(),

                      //buildContainer() to Show the slected shipments input cards
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.0,
                              vertical: 2.0,
                            ),
                            child: contactCard(
                              "${model.contactList.data[index].firstName}",
                              "${model.contactList.data[index].lastName}",
                              "${model.contactList.data[index].city}",
                              "${model.contactList.data[index].country.name}",
                              model.contactList.data[index].id,
                            ),
                          );
                        },
                        itemCount: model.contactList.data.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
  // the Section to show the "FROM" and "TO" Contact inside gray card on top
  // om confirmation

  Widget topSection() {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Your Adresses",
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
    );
  }

  Widget contactCard(
      String firstName, String lastName, String city, String country, int id) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        child: ListTile(
            onTap: () {},
            leading: CircleAvatar(
              radius: 30.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Text(
                '${firstName[0]}${lastName[0]}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text('$firstName ' '$lastName'),
            subtitle: Text(
              "$city, $country",
              style: TextStyle(color: Colors.grey[500]),
            )),
      ),
    );
  }
}
