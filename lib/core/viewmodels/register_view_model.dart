import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/models/register_user_model.dart';
import 'package:baredex/core/services/api.dart';
import 'package:baredex/core/viewmodels/base_view_model.dart';
import 'package:baredex/locator.dart';

class RegisterViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  String errorMessage;

  RegisterUser registerUser = RegisterUser();

  Future<RegisterUser> register(String firstName, String lastName, String email,
      String mobileNumber, String password, String string) async {
    setState(ViewState.Busy);
    registerUser = await _api.performRegisterUser(
        firstName, lastName, email, mobileNumber, password);
    // Handle potential error here too.
    setState(ViewState.Idle);
    return registerUser;
  }
}
