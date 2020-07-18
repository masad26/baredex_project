import 'package:baredex/core/enums/viewstate.dart';
import 'package:baredex/core/models/contact_list_model.dart';
import 'package:baredex/core/services/api.dart';
import 'package:baredex/core/viewmodels/base_view_model.dart';
import 'package:baredex/locator.dart';

class ContactListViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  ContactList _contactList = ContactList();

  //getter
  ContactList get contactList => _contactList;
  //Setter
  void setCotactList(ContactList contactList) {
    _contactList = contactList;
  }

  Future getContactsListData() async {
    setState(ViewState.Busy);

    _contactList = await _api.getContactListData();

    setCotactList(_contactList);

    setState(ViewState.Idle);
  }
}
