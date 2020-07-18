import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String authToken = "auth_token";

//set data into shared preferences like this
  Future<void> setAuthToken(String authToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.authToken, authToken);
  }

//get value from shared preferences
  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String authToken;
    authToken = pref.getString(this.authToken) ?? null;
    return authToken;
  }
}
