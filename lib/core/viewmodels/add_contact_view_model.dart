import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/models/contact_created_mdel.dart';
import 'package:baredex/core/services/api.dart';
import 'package:baredex/core/viewmodels/base_view_model.dart';
import 'package:baredex/locator.dart';

class AddContactViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  String errorMessage;

  ContactCreated contactCreated = ContactCreated();

  Future<ContactCreated> addConact(
    String firstName,
    String secondname,
    String lastName,
    String companyName,
    String phoneNumber,
    String email,
    String countryId,
    String cityName,
    String addressOne,
    String addressTwo,
    String postalCode,
  ) async {
    setState(ViewState.Busy);
    ContactCreated submitAddContact = await _api.performAddUserConatact(
      firstName,
      secondname,
      lastName,
      companyName,
      phoneNumber,
      email,
      countryId,
      cityName,
      addressOne,
      addressTwo,
      postalCode,
    );
    // Handle potential error here too.
    setState(ViewState.Idle);
    return submitAddContact;
  }
}
