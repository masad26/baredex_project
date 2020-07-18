import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/models/user_model.dart';
import 'package:baredex/core/services/api.dart';
import 'package:baredex/core/viewmodels/base_view_model.dart';
import 'package:baredex/locator.dart';

class UserViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  User _user = User();

  //Getter
  User get user => _user;

  //Setter
  void setUser(User user) {
    _user = user;
  }

  Future getUserData() async {
    setState(ViewState.Busy);
    _user = await _api.getUserData();
    setUser(_user);
    setState(ViewState.Idle);
  }
}
