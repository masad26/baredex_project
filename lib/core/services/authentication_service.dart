import 'dart:async';
import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/models/login_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';
import '../../locator.dart';

class AuthenticationService {
  Logger log = getLogger("AuthenticationService");
  Api _api = locator<Api>();

  StreamController<Login> loginController = StreamController<Login>();

  Future<Login> login(String email, String password) async {
    var loggedinUser = await _api.performLogin(email, password);

    bool hasUser;
    Login loginData;

    if (loggedinUser.error) {
      hasUser = false;
    } else {
      hasUser = true;
    }

    if (hasUser) {
      loginController.add(loggedinUser);
      loginData = loggedinUser;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('accessToken', loggedinUser.data.accessToken);
      prefs.setBool('isLoggedIn', true);
    } else {
      loginController.add(loggedinUser);
      loginData = loggedinUser;
    }

    return loginData;
  }

  Future<bool> logout() async {
    var isLoggedOutUser = await _api.performLogout();

    if (isLoggedOutUser) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
    }
    return isLoggedOutUser;
  }
}
