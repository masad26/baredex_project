import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/models/country_list_model.dart';
import 'package:baredex/core/services/api.dart';
import 'package:baredex/core/viewmodels/base_view_model.dart';
import 'package:baredex/locator.dart';

class CountryListViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  Countries _countryList = Countries();

  //getter
  Countries get countryList => _countryList;
  //Setter
  void setCotactList(Countries coutryList) {
    _countryList = _countryList;
  }

  Future getCountryListData() async {
    setState(ViewState.Busy);

    _countryList = await _api.getCountries();

    setCotactList(_countryList);

    setState(ViewState.Idle);
  }
}
