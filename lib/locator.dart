import 'package:baredex/core/services/authentication_service.dart';
import 'package:baredex/core/services/api.dart';
import 'package:baredex/core/viewmodels/add_contact_view_model.dart';
import 'package:baredex/core/viewmodels/cities_view_model.dart';
import 'package:baredex/core/viewmodels/contact_list_view_model.dart';
import 'package:baredex/core/viewmodels/login_view_model.dart';
import 'package:baredex/core/viewmodels/register_view_model.dart';
import 'package:baredex/core/viewmodels/shipment_list_view_model.dart';
import 'package:baredex/core/viewmodels/shipments_rates_view_model.dart';
import 'package:baredex/core/viewmodels/shipments_request_view_model.dart';
import 'package:baredex/core/viewmodels/user_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => Api());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => UserViewModel());
  locator.registerFactory(() => RegisterViewModel());
  locator.registerFactory(() => ShipmentListViewModel());
  locator.registerFactory(() => ContactListViewModel());
  locator.registerFactory(() => ShipmentRatesListViewModel());
  locator.registerFactory(() => CitiesListViewModel());
  locator.registerFactory(() => AddContactViewModel());
  locator.registerFactory(() => ShipmentRequestViewModel());
}
