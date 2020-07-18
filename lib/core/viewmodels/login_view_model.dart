import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/models/login_model.dart';
import 'package:baredex/core/services/authentication_service.dart';
import 'package:baredex/core/viewmodels/base_view_model.dart';
import 'package:baredex/locator.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String errorMessage;

  Login loginData = Login();

  Future<Login> login(String email, String password) async {
    setState(ViewState.Busy);
    loginData = await _authenticationService.login(email, password);
    // Handle potential error here too.
    setState(ViewState.Idle);
    return loginData;
  }

  Future<bool> logout() async {
    setState(ViewState.Busy);
    var success = await _authenticationService.logout();

    setState(ViewState.Idle);
    return success;
  }
}
