import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/models/user_shipments_model.dart';
import 'package:baredex/core/services/api.dart';
import 'package:baredex/core/viewmodels/base_view_model.dart';
import 'package:baredex/locator.dart';

class ShipmentListViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  UserShipments userShipments = UserShipments();

  Future getShimentsData() async {
    setState(ViewState.Busy);
    userShipments = await _api.getUserShipmentsData();
    setState(ViewState.Idle);
  }
}
