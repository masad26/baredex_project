import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/models/getrate_model.dart';
import 'package:baredex/core/services/api.dart';
import 'package:baredex/core/viewmodels/base_view_model.dart';
import 'package:baredex/locator.dart';

class ShipmentRatesListViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  Getrate shipmentRates = Getrate();

  Future getShimentsData() async {
    setState(ViewState.Busy);
    shipmentRates = await _api.getShipmentsRate();
    setState(ViewState.Idle);
    return shipmentRates;
  }
}
