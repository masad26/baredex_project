import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/models/shipment_request_response_model.dart';
import 'package:baredex/core/services/api.dart';
import 'package:baredex/core/viewmodels/base_view_model.dart';
import 'package:baredex/locator.dart';

class ShipmentRequestViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  ShipmentRequestResponse shipmentRates = ShipmentRequestResponse();

  Future makeShipmentRequest(int serviceIndex) async {
    setState(ViewState.Busy);
    ShipmentRequestResponse shipmentRequestResponse =
        await _api.requestShipment(serviceIndex);
    setState(ViewState.Idle);
    return shipmentRequestResponse;
  }
}
