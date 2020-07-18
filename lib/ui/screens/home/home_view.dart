import 'package:badges/badges.dart';
import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/viewmodels/contact_list_view_model.dart';
import 'package:baredex/core/viewmodels/contries_view_model.dart';
import 'package:baredex/core/viewmodels/shipment_list_view_model.dart';
import 'package:baredex/core/viewmodels/user_view_model.dart';
import 'package:baredex/ui/screens/base_view.dart';
import 'package:baredex/ui/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  Logger log = getLogger("HomeView");
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Provider.of<UserViewModel>(context, listen: false).getUserData();
    Provider.of<ContactListViewModel>(context, listen: false)
        .getContactsListData();
    Provider.of<CountryListViewModel>(context, listen: false)
        .getCountryListData();
  }

  bool _shipmentStatus(DateTime deliverTime) {
    var now = new DateTime.now();
    var deliveryTime = DateTime.parse(deliverTime.toString());

    if (now.isBefore(deliveryTime)) {
      log.i(now);
      log.i("Delivery time is ahead of today");
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    updateStatusBarColor(context);
    return Scaffold(
      key: _drawerKey,
      backgroundColor: theme.scaffoldBackgroundColor,
      drawer: Drawer(
        child: AppDrawer(),
      ),
      body: BaseView<ShipmentListViewModel>(
          onModelReady: (model) => model.getShimentsData(),
          builder: (context, model, child) {
            var shipmintList;

            if (model.state != ViewState.Busy) {
              shipmintList = model.userShipments.data.data;
            }

            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  leading: buildprifleAvatarOpenDrawer(),
                  actions: appBarActions(context),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  pinned: true,
                  floating: false,
                  expandedHeight: 120.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('Home'),
                  ),
                ),
                model.state == ViewState.Busy
                    ? buildLoadingSpinnerSliver()
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            // var fromUser = shipmintList[index].origin;
                            // var toUser = shipmintList[index].destination;
                            // var fromName = fromUser.firstName +
                            //     " " +
                            //     fromUser.secondName +
                            //     " " +
                            //     fromUser.lastName;

                            // var toName = toUser.firstName +
                            //     " " +
                            //     toUser.secondName +
                            //     " " +
                            //     toUser.lastName;

                            // return shippmentCard(
                            //   shipmentId: shipmintList[index].id,
                            //   venderName: shipmintList[index].vendorName,
                            //   fromUserName: fromName,
                            //   toUserName: toName,
                            //   deliveryTime: DateTime.parse(
                            //       shipmintList[index].deliverTime),
                            //   delivered: true,
                            //   trackNumber: shipmintList[index].trackNumber,
                            // );

                            var now = new DateTime.now();
                            var deliveryTime =
                                DateTime.parse(shipmintList[index].deliverTime);

                            if (now.isBefore(deliveryTime)) {
                              log.i(now);
                              log.i("Delivery time is ahead of today");
                            }

                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: buildLeadingIconWithBadge(
                                        _shipmentStatus(deliveryTime)),
                                    title: Text(
                                      'From, ${StringUtils.capitalize(shipmintList[index].origin.firstName)} ${StringUtils.capitalize(shipmintList[index].origin.lastName)}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    subtitle: _shipmentStatus(deliveryTime)
                                        ? Text(
                                            "Delivered",
                                            style: TextStyle(
                                                color: Color(0xFF13ad93),
                                                fontSize: 12),
                                          )
                                        : Text(
                                            "In Transit",
                                            style:
                                                TextStyle(color: Colors.indigo),
                                          ),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            );
                          },
                          childCount: shipmintList.length,
                        ),
                      ),
              ],
            );
          }),
    );
  }

  SliverList buildLoadingSpinnerSliver() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        },
        childCount: 1,
      ),
    );
  }

  SliverList buildPlaceHolderSliver() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container();
        },
        childCount: 1,
      ),
    );
  }

  List<Widget> appBarActions(BuildContext context) {
    return <Widget>[
      Container(
        margin: EdgeInsets.only(right: 10),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.search,
            size: 35,
          ),
          color: Theme.of(context).accentColor,
          onPressed: () {},
        ),
      ),
      Container(
        margin: EdgeInsets.only(right: 20),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).accentColor,
          radius: 15,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, 'insertShipmentDetail');
            },
          ),
        ),
      )
    ];
  }

  Padding buildprifleAvatarOpenDrawer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => _drawerKey.currentState.openDrawer(),
        child: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage("assets/images/profile.png"),
            ),
          ),
        ),
      ),
    );
  }

  Widget shippmentCard(
      {int shipmentId,
      String venderName,
      String fromUserName,
      String toUserName,
      DateTime deliveryTime,
      bool delivered,
      String trackNumber}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                'singleShipmentDetail',
                arguments: shipmentId,
              );
            },
            leading: buildLeadingIconWithBadge(true),
            //title: Text('$venderName from, $senderName'),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$venderName',
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                RichText(
                  text: TextSpan(
                      text: 'From: ',
                      style: TextStyle(color: Colors.grey[500]),
                      children: <TextSpan>[
                        TextSpan(
                          text: '$fromUserName',
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ]),
                ),
                SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                      text: 'To: ',
                      style: TextStyle(color: Colors.grey[500]),
                      children: <TextSpan>[
                        TextSpan(
                          text: '$toUserName',
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ]),
                ),
              ],
            ),
            subtitle: _shipmentStatus(deliveryTime)
                ? Text(
                    "Delivered",
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 12),
                  )
                : Text(
                    "Arriving in ${DateTime.now().difference(deliveryTime).inDays} Days",
                    style: TextStyle(color: Colors.indigo),
                  ),
          ),
          Divider()
        ],
      ),
    );
  }

  Badge buildLeadingIconWithBadge(bool delivered) {
    return Badge(
      showBadge: delivered,
      badgeColor: Color(0xFF13ad93),
      position: BadgePosition.bottomRight(right: 2),
      badgeContent: Icon(
        Icons.check,
        color: Colors.white,
        size: 10,
      ),
      child: Container(
        width: 50.0,
        height: 50.0,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          backgroundImage: AssetImage("assets/images/profile.png"),
        ),
      ),
    );
  }

  Widget buildHeadingText({String headingText}) {
    return Padding(
      padding: EdgeInsets.only(right: 160.0),
      child: Text(
        headingText,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 27.0,
          fontWeight: FontWeight.w500,
          color: Colors.black87.withOpacity(0.9),
        ),
      ),
    );
  }
}
