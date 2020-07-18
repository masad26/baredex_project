import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/viewmodels/contact_list_view_model.dart';
import 'package:baredex/ui/shared/shared.dart';
import 'package:baredex/ui/shared/widgets/recent_used_contacts.dart';
import 'package:baredex/ui/shared/widgets/selected_contact_card.dart';
import 'package:baredex/ui/shared/widgets/selected_contact_small_card.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class SelectFromContact extends StatefulWidget {
  static const routeName = '/selectFromContact';
  @override
  _SelectFromContactState createState() => _SelectFromContactState();
}

class _SelectFromContactState extends State<SelectFromContact> {
  Logger log = getLogger("SelectFromContact");
  static bool cardChecked = false;
  final ScrollController controller = ScrollController();
  // fromUser is set to Zero initaily so it will show the
  int fromUserId = 0;
  int selectedFromUserId = 0;
  int toUserId = 0;
  int selectedToUserId = 0;

  //check from Shared Prefrences if FromContact id is Saved

  // void checkSavedFromContact() async {
  //   log.i("inside checkSavedFromContact");

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var selectedFromContactId = prefs.getInt('selectedFromUserId');

  //   log.i("inside checkSavedFromContact $selectedFromContactId");

  //   if (selectedFromContactId != null) {
  //     selectedFromUserId = selectedFromContactId;
  //   }
  // }

  // void makeSavedFromContact(int contactId) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('selectedFromUserId', contactId);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   checkSavedFromContact();
  // }

  void makeFromUserIdClear() {
    setState(() {
      fromUserId = 0;
    });
  }

  void makeFromSelectedUserIdClear() async {
    setState(() {
      selectedFromUserId = 0;
    });
  }

  void makeSelectedFromUserId() {
    setState(() {
      selectedFromUserId = fromUserId;
    });
    setState(() {
      fromUserId = 0;
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
    if (selectedFromUserId == 0) {
      setState(() {
        fromUserId = selctedUserId;
      });
    } else if (selectedToUserId == 0) {
      setState(() {
        toUserId = selctedUserId;
      });
    }
  }

  void _saveFromContactandProceed() async {
    if (selectedFromUserId == 0) {
      makeSelectedFromUserId();
      await controller.animateTo(
        0,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
      Navigator.pushNamed(context, 'selctToContact',
          arguments: selectedFromUserId);
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
            Navigator.pushNamed(context, 'insertShipmentDetail');
          },
        ),
      ),
      floatingActionButton: fromUserId != 0
          ? FloatingActionButton.extended(
              onPressed: () {
                _saveFromContactandProceed();
              },
              icon: Text("Next"),
              label: Icon(Icons.arrow_forward),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          child: Consumer<ContactListViewModel>(
            builder: (context, model, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // fromUserId is not 0 show the Selcted Contact
                // in a Card instead of the top section

                fromUserId != 0
                    ? SelectedContactCard(
                        userId: fromUserId,
                        type: 'From ',
                        clearSlectedContact: makeFromUserIdClear,
                      )
                    : topSection(),

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
                LargeButton(
                  title: "Next",
                  onPressed: () async {
                    if (fromUserId == 0) {
                      GlobalSnackBar.show(
                          context, "Please Select From Contact to Proceed");
                    } else {
                      _saveFromContactandProceed();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // the Section to show the "FROM" and "TO" Contact inside gray card on top
  // om confirmation

  Column topSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SelectedContactSmallCard(
          userId: selectedFromUserId,
          type: 'From',
          clearSlectedContact: makeFromSelectedUserIdClear,
        ),
        RecentUsedContacts()
      ],
    );
  }

  Widget contactCard(
      String firstName, String lastName, String city, String country, int id) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
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
          trailing: id == fromUserId
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
