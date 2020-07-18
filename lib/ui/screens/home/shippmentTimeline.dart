import 'package:baredex/core/data/data.dart';
import 'package:baredex/ui/screens/home/shipment_tracking.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class ShippmentTimeline extends StatefulWidget {
  @override
  _ShippmentTimelineState createState() => _ShippmentTimelineState();
}

class _ShippmentTimelineState extends State<ShippmentTimeline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45.0),
                topRight: Radius.circular(45.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Icon(
                    FontAwesomeIcons.angleDown,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                  child: Text(
                    "Arriving in 3 Days",
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                ShipmentTracking(),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Tracking Number: 8123712387",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                        color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "DHL Express",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Page View Widget
class ShippmentTimelineChild extends StatefulWidget {
  static const String routeName = '/shippmentTimeline';

  @override
  _ShippmentTimelineChildState createState() => _ShippmentTimelineChildState();
}

class _ShippmentTimelineChildState extends State<ShippmentTimelineChild> {
  final PageController pageController =
      PageController(initialPage: 1, keepPage: true);
  int pageIx = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [timelineModel(TimelinePosition.Left)];

    return Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          onPageChanged: (i) => setState(() => pageIx = i),
          controller: pageController,
          children: pages,
        ));
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: doodles.length,
      physics: BouncingScrollPhysics(),
      position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final doodle = doodles[i];
    final textTheme = Theme.of(context).textTheme;
    return TimelineModel(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(doodle.time, style: textTheme.caption),
              Text(
                doodle.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 15.0),
              ),
              Text(
                doodle.content,
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        position: TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == doodles.length,
        iconBackground: doodle.iconBackground,
        icon: doodle.icon);
  }
}
