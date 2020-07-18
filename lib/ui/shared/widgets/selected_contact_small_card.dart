import 'package:baredex/core/viewmodels/contact_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedContactSmallCard extends StatelessWidget {
  final int userId;
  final String type;
  final Function clearSlectedContact;

  SelectedContactSmallCard({this.userId, this.type, this.clearSlectedContact});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ContactListViewModel>(
        builder: (context, model, child) {
          var contact;
          if (userId != 0) {
            contact = model.contactList.data.singleWhere((e) => e.id == userId);
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Card(
                elevation: 0,
                color: Colors.black12,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(7.0),
                  child: Container(
                    width: double.infinity,
                    //color: Colors.pink,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          //color: Colors.teal,
                          height: 60.0,
                          width: 50.0,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 38.0,
                                child: Text('$type'),
                              ),
                            ],
                          ),
                        ),
                        contact != null
                            ? Container(
                                //color: Colors.deepPurple,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    SizedBox(width: 5.0),
                                    CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                      child: Text(
                                        '${contact.firstName[0]}${contact.lastName[0]}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${contact.firstName} '
                                              '${contact.lastName}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            Text(
                                              "${contact.city},\n${contact.country.name}",
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 12.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
