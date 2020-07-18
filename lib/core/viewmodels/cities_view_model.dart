import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/models/city_search_model.dart';
import 'package:baredex/core/services/api.dart';
import 'package:baredex/core/viewmodels/base_view_model.dart';
import 'package:baredex/locator.dart';

class CitiesListViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  Cities _citiesList = Cities();

  //getter
  Cities get citiesList => _citiesList;
  //Setter
  void setCotactList(Cities citiesList) {
    _citiesList = citiesList;
  }

  Future getCitiesListData(int cityCode, String searchTerm) async {
    setState(ViewState.Busy);

    _citiesList = await _api.searchCities(cityCode, searchTerm);

    setCotactList(_citiesList);

    setState(ViewState.Idle);

    return citiesList;
  }
}
