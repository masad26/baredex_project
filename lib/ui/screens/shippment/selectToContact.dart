import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/models/contact_list_model.dart';
import 'package:baredex/core/viewmodels/contact_list_view_model.dart';
import 'package:baredex/ui/shared/shared.dart';
import 'package:baredex/ui/shared/widgets/recent_used_contacts.dart';
import 'package:baredex/ui/shared/widgets/selected_contact_card.dart';
import 'package:baredex/ui/shared/widgets/selected_contact_small_card.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectToContact extends StatefulWidget {
  final int selectedFromUserId;
  SelectToContact(this.selectedFromUserId);

  static const routeName = '/selectFromContact';
  @override
  _SelectToContactState createState() => _SelectToContactState();
}

class _SelectToContactState extends State<SelectToContact> {
  final ScrollController controller = ScrollController();
  Logger log = getLogger("SelectToContact");
  static bool cardChecked = false;

  // fromUser is set to Zero initaily so it will show the
  int toUserId = 0;
  int selectedToUserId = 0;

  void makeFromUserIdClear() {
    setState(() {
      toUserId = 0;
    });
  }

  void makeSelectedToUserId() {
    setState(() {
      selectedToUserId = toUserId;
    });
    setState(() {
      toUserId = 0;
    });
  }

  void setContactid(int selctedUserId) {
    if (selectedToUserId == 0) {
      setState(() {
        toUserId = selctedUserId;
      });
    }
  }

  void setValueAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('fromId', widget.selectedFromUserId);
    prefs.setInt('toId', selectedToUserId);
  }

  void _saveToContactandProceed() async {
    if (selectedToUserId == 0) {
      makeSelectedToUserId();
      controller.animateTo(
        0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      setValueAndNavigate();
      Navigator.pushNamed(context, 'eachShipmentDetail');
    }
  }

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
            Navigator.pushNamed(context, 'selctFromContact');
          },
        ),
      ),
      //if toUserId is still 0 not selected by user
      // show nothinng, other wise show floating action button
      floatingActionButton: toUserId != 0 || selectedToUserId != 0
          ? FloatingActionButton.extended(
              onPressed: () {
                _saveToContactandProceed();
              },
              icon: Text("Next"),
              label: Icon(Icons.arrow_forward),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          child: Consumer<ContactListViewModel>(
            builder: (context, model, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // fromUserId is not 0 show the Selcted Contact
                  // in a Card instead of the top section

                  toUserId != 0
                      ? SelectedContactCard(
                          userId: toUserId,
                          type: 'To ',
                          clearSlectedContact: makeFromUserIdClear,
                        )
                      : topSection(context, model.contactList),

                  //buildContainer() to Show the slected shipments input cards
                  ListView.builder(
                    itemBuilder: (context, index) {
                      bool selected = false;
                      if (model.contactList.data[index].id ==
                          widget.selectedFromUserId) {
                        selected = true;
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.0,
                          vertical: 2.0,
                        ),
                        child: contactCard(
                          selected,
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
                  LargeButton(
                    title: "Next",
                    onPressed: () {
                      if (toUserId == 0 && selectedToUserId == 0) {
                        GlobalSnackBar.show(
                            context, "Please Select TO Contact to Proceed");
                      } else {
                        _saveToContactandProceed();
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Column topSection(BuildContext context, ContactList contactlist) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SelectedContactSmallCard(
          userId: widget.selectedFromUserId,
          type: 'From',
          clearSlectedContact: makeFromUserIdClear,
        ),
        SelectedContactSmallCard(
          userId: selectedToUserId,
          type: 'To',
          clearSlectedContact: makeFromUserIdClear,
        ),
        RecentUsedContacts()
      ],
    );
  }

  //contact card function
  Widget contactCard(bool selected, String firstName, String lastName,
      String city, String country, int id) {
    if (selected) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Card(
          color: Colors.grey[400],
          child: ListTile(
            onTap: () {},
            leading: CircleAvatar(
              radius: 30.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Text(
                '${firstName[0]}${lastName[0]}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            title: Text('$firstName ' '$lastName',
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600)),
            subtitle: Text(
              "$city, $country",
              style: TextStyle(color: Colors.black87),
            ),
            trailing: id == toUserId
                ? Icon(
                    Icons.check,
                    color: Theme.of(context).accentColor,
                    size: 32.0,
                  )
                : Icon(
                    Icons.check,
                    color: Colors.transparent,
                    size: 32.0,
                  ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Card(
          color: selected ? Colors.lightBlueAccent : null,
          child: ListTile(
            onTap: () => setContactid(id),
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
            ),
            trailing: id == toUserId
                ? Icon(
                    Icons.check,
                    color: Theme.of(context).accentColor,
                    size: 32.0,
                  )
                : Icon(
                    Icons.check,
                    color: Colors.transparent,
                    size: 32.0,
                  ),
          ),
        ),
      );
    }
  }
}
