import 'package:baredex/core/config/colors.dart';
import 'package:baredex/ui/shared/widgets/custom_icon_decoration.dart';
import 'package:flutter/material.dart';

class Event {
  final String time;
  final String task;
  final String country;
  final String city;
  bool date;

  Event(this.time, this.task, this.country, this.city, this.date);
}

final List<Event> _eventList = [
  Event("12:47 am", "Arrived Gazal warehouse JED-45", "Saudi Arabia",
      "Jeddha City", true),
  Event("5:05 pm", "Departed Gazal warehouse ABT-145", "Saudia Arabia",
      "Baha City", true),
  Event("2:44 pm", "Departed Gazal warehouse ABT-145", "Saudia Arabia",
      "Baha City", false),
  Event("12:01 pm", "Picked up by Saleh Saad", "", "", false),
  Event("11:54 am", "Shipment information sent to Saleh Saad", "", "", false),
  Event("11:54 am", "Muhammad Ali Created Shipment", "Saudia Arabia",
      "Baha City", false),
];

class ShipmentTracking extends StatefulWidget {
  @override
  _ShipmentTrackingState createState() => _ShipmentTrackingState();
}

class _ShipmentTrackingState extends State<ShipmentTracking> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 15;
    return ListView.builder(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: _eventList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 50),
                child: Column(
                  children: <Widget>[
                    _eventList[index].date
                        ? Container(
                            margin: EdgeInsets.only(bottom: 15.0),
                            child: _displayDate(),
                          )
                        : Container(
                            height: 50,
                          ),
                    _displayTime(_eventList[index].time),
                  ],
                ),
              ),
              _lineStyle(context, iconSize, index, _eventList.length),
              _displayContent(_eventList[index]),
            ],
          ),
        );
      },
    );
  }

  Widget _lineStyle(
      BuildContext context, double iconSize, int index, int listLength) {
    return Container(
      decoration: CustomIconDecoration(
          iconSize: iconSize,
          lineWidth: 1,
          firstData: index == 0 ?? true,
          lastData: index == listLength - 1 ?? true),
      child: index != listLength - 1
          ? Container(
              child: Icon(Icons.fiber_manual_record,
                  size: iconSize, color: Theme.of(context).accentColor),
            )
          : Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
                    child: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/profile.png")),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _displayContent(Event event) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(event.task,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 15.0)),
              event.country != ''
                  ? Container(
                      margin: EdgeInsets.only(top: 4.0),
                      child: Text(
                        '${event.country}, '
                        '${event.city}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayTime(String time) {
    return Container(
      width: 87,
      padding: EdgeInsets.only(left: 8.0),
      child: Text(time),
    );
  }

  Widget _displayDate() {
    return Container(
      child: Text(
        "Monday\nMay22, 2019",
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
