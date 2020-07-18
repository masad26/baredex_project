import 'package:baredex/core/viewmodels/contact_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedContactCard extends StatelessWidget {
  final int userId;
  final String type;
  final Function clearSlectedContact;

  SelectedContactCard({this.userId, this.type, this.clearSlectedContact});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ContactListViewModel>(
        builder: (context, model, child) {
          var selctedFromContacted =
              model.contactList.data.singleWhere((e) => e.id == userId);

          return Padding(
            padding: const EdgeInsets.all(.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      color: Colors.grey[200],
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: clearSlectedContact,
                            child: Text(
                              'Clear',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 10.0),
                                    Text(
                                      "From: ",
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 25.0,
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                      child: Wrap(
                                        children: <Widget>[
                                          Text(
                                            '${selctedFromContacted.firstName[0]}${selctedFromContacted.lastName[0]}',
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            softWrap: true,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(
                                      '${selctedFromContacted.firstName} ${selctedFromContacted.secondName}\n ${selctedFromContacted.lastName}',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  Text(
                                    '${selctedFromContacted.addressOne}',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    '${selctedFromContacted.addressTwo}',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    '${selctedFromContacted.mobile}',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
