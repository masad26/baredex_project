import 'dart:convert';
import 'package:baredex/core/config/config.dart';
import 'package:baredex/core/models/city_search_model.dart';
import 'package:baredex/core/models/contact_created_mdel.dart';
import 'package:baredex/core/models/contact_list_model.dart';
import 'package:baredex/core/models/contact_model.dart';
import 'package:baredex/core/models/content_form_model.dart';
import 'package:baredex/core/models/country_list_model.dart';
import 'package:baredex/core/models/getrate_model.dart';
import 'package:baredex/core/models/login_model.dart';
//import 'package:baredex/core/models/packages_model.dart';
import 'package:baredex/core/models/register_user_model.dart';
import 'package:baredex/core/models/shipment_request_response_model.dart';
import 'package:baredex/core/models/shipmet_service_model.dart';
//import 'package:baredex/core/models/request_rate_model.dart';
import 'package:baredex/core/models/user_model.dart';
import 'package:baredex/core/models/user_shipments_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Logger log = getLogger("Api Service");

  static const String base_url = "https://arabic.baredex.com";
  static String originCity = '';
  static String destinationCity = '';

  var client = new http.Client();

  Future<Login> performLogin(String email, String password) async {
    final response =
        await http.post(base_url + '/api/auth/login', headers: <String, String>{
      'content-type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest'
    }, body: {
      // 'email': 'imezied@gmail.com',
      // 'password': 'islamislam',
      'email': email,
      'password': password,
    });
    var responseData = json.decode(response.body);

    // log.i(response.statusCode);
    // log.i(response.body);

    if (response.statusCode != 200) {
      //log.i("There is something error");
      // log.e("error message :" + json.encode(responseData['error']));
      return Login(error: true, message: "SignIn Error! try Again", data: null);
    } else {
      log.i("You Have logged in Successfully");
      return Login.fromJson(responseData);
    }
  }

  Future<bool> performLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');

    final response = await client.get(
      base_url + '/api/logout',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    //log.i(response.statusCode);

    var logoutSuccess;

    if (response.statusCode == 200) {
      logoutSuccess = true;
    } else {
      logoutSuccess = true;
    }
    return logoutSuccess;
  }

  Future performRegisterUser(String firstName, String lastName, String email,
      String mobileNumber, String password) async {
    final response = await http
        .post(base_url + '/api/auth/register', headers: <String, String>{
      'content-type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest'
    }, body: {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "mobile": mobileNumber,
      "password": password
    });
    var responseData = json.decode(response.body);

    log.i(response.statusCode);
    log.i(response.body);

    if (response.statusCode == 200) {
      log.i("User Registered Successfully");
      return RegisterUser.fromJson(responseData);
    }
    if (response.statusCode == 422) {
      //log.i("inside status code 422");
      return RegisterUser(
        error: true,
        message: json.encode(responseData['message']),
      );
    } else {
      //log.i("There is something error");
      //log.e("error message :" + json.encode(responseData['error']));
      return RegisterUser(
          error: true, message: "SignIn Error! try Again", data: null);
    }
  }

  /// get the Logged in User Data
  Future<User> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');

    //log.i(accessToken);

    final response = await client.get(
      base_url + '/api/user',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    var responseData = json.decode(response.body);

    //log.i(response.statusCode);

    if (response.statusCode != 200) {
      //log.i("There is something error");
      //log.e("error message :" + json.encode(responseData['error']));
      return User(error: true, message: "Error Feteching the Data", data: null);
    } else {
      log.i("User Data has fetched Successfully");
      return User.fromJson(responseData);
    }
  }

  /// get the Logged in User Data
  Future<Countries> getCountries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');

    //log.i(accessToken);

    final response = await client.get(
      base_url + '/api/countries',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    var responseData = json.decode(response.body);

    log.i(response.statusCode);
    log.i(response.body);

    if (response.statusCode != 200) {
      //log.i("There is something error");
      //log.e("error message :" + json.encode(responseData['error']));
      return Countries(
          error: true, message: "Error Feteching the Data", data: null);
    } else {
      log.i("Countries List fetched Successfully");
      return Countries.fromJson(responseData);
    }
  }

  /// Search cities
  Future<Cities> searchCities(int countryId, String searchTerm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');

    //log.i(accessToken);
    //countryId = 13;
    //searchTerm = 'au';

    final response = await client.get(
      base_url + '/api/cities?country_id=$countryId&city_name=$searchTerm',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    var responseData = json.decode(response.body);

    log.i(response.statusCode);
    log.i(response.body);

    if (response.statusCode != 200) {
      //log.i("There is something error");
      //log.e("error message :" + json.encode(responseData['error']));
      return Cities(
          error: true, message: "Error Feteching the Data", data: null);
    } else {
      log.i("Cities List fetched Successfully");
      return Cities.fromJson(responseData);
    }
  }

  Future performAddUserConatact(
    String firstName,
    String secondName,
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');

    final response = await http.post(
      base_url + '/api/address-book',
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
      body: {
        "first_name": firstName,
        "second_name": secondName,
        "last_name": lastName,
        "email": email,
        "country_id": countryId,
        "city": cityName,
        "mobile": phoneNumber,
        "address_one": addressOne,
        "address_two": addressTwo,
        "postal_code": postalCode,
        "state": "XX",
        "company": companyName
      },
    );
    var responseData = json.decode(response.body);

    log.i(response.statusCode);
    log.i(response.body);

    if (response.statusCode == 200) {
      log.i("Contact added Successfully");
      return ContactCreated.fromJson(responseData);
    }
    if (response.statusCode == 422) {
      //log.i("inside status code 422");
      return ContactCreated(
        error: true,
        message: json.encode(responseData['message']),
      );
    } else {
      return ContactCreated(
          error: true, message: "Add Contact Error! try Again", data: null);
    }
  }

  // get the User shippments Data
  Future<UserShipments> getUserShipmentsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');

    //log.i(accessToken);

    final response = await client.get(
      base_url + '/api/user-shipments',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    var responseData = json.decode(response.body);

    //log.i(response.statusCode);

    if (response.statusCode != 200) {
      log.i("There is something error");
      log.e("error message :" + json.encode(responseData['error']));
      return UserShipments(
          error: true, message: "Error Feteching the Data", data: null);
    } else {
      log.i("Shipments Data has fetched Successfully");
      return UserShipments.fromJson(responseData);
    }
  }

  // get the User shippments Data
  Future<ContactList> getContactListData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');

    //log.i("Inside getContactListData");
    //log.i(accessToken);

    final response = await client.get(
      base_url + '/api/address-book',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    var responseData = json.decode(response.body);

    //log.i(response.statusCode);

    if (response.statusCode != 200) {
      log.i("There is something error");
      log.e("error message :" + json.encode(responseData['error']));
      return ContactList(
          error: true, message: "Error Feteching the Data", data: null);
    } else {
      log.i("User Contact List Data has fetched Successfully");
      //log.w(json.encode(responseData));
      final contactList = ContactList.fromJson(responseData);
      return contactList;
    }
  }

  // get the User shippments Data
  Future<Contact> getContactData(String contactId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');

    //log.i(accessToken);

    final response = await client.get(
      base_url + '/api/address-book/' + contactId,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    var responseData = json.decode(response.body);

    //log.i(response.statusCode);

    if (response.statusCode != 200) {
      log.i("There is something error");
      log.e("error message :" + json.encode(responseData['error']));
      return Contact(
          error: true, message: "Error Feteching the Data", data: null);
    } else {
      log.i("User Data has fetched Successfully");
      final contact = Contact.fromJson(responseData);
      return contact;
    }
  }

  // getShipment Rate

  Future getShipmentsRate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');
    var origin = prefs.getInt('fromId');
    var destination = prefs.getInt('toId');
    var totalWeight = prefs.getDouble('totalWeight');
    var packages = jsonDecode(prefs.getString('packages'));

    log.i(accessToken);
    log.i(origin);
    log.i(destination);
    log.i(totalWeight);
    log.i(packages);
    log.i("message: inside getShipmentsRate");

    //getting Origin City Name
    var originResponse = await getContactData(origin.toString());
    Contact originContact = originResponse;
    originCity = originContact.data.city;
    log.i(originContact.data.city);

    //getting Destination City Name
    var destinationResponse = await getContactData(destination.toString());
    Contact destinationContact = destinationResponse;
    destinationCity = destinationContact.data.city;
    log.i(destinationContact.data.city);

    var body = {
      "packages": packages,
      "weight": totalWeight,
      "addresses": {"origin": origin, "destination": destination}
    };

    final response = await http.post(
      base_url + '/api/get-rate',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(body),
    );
    var responseData = json.decode(response.body);

    //log.i(response.statusCode);
    log.i(response.body);

    if (response.statusCode == 200) {
      log.i("Shipment Rate fetched Successfully");
      return Getrate.fromJson(responseData);
    } else {
      return Getrate(error: true, message: responseData['message'], data: null);
    }
  }

  Future requestShipment(int serviceIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');
    var origin = prefs.getInt('fromId');
    var destination = prefs.getInt('toId');
    var totalWeight = prefs.getDouble('totalWeight');
    var packages = jsonDecode(prefs.getString('packages'));
    var contents = jsonDecode(prefs.getString('contents'));
    var slectedService = jsonDecode(prefs.getString('service'));

    // // List<Content> contents = List<Content>();
    // Service shipmentService = Service.fromJson(slectedService);

    // log.i(accessToken);
    // log.i(origin);
    // log.i(destination);
    // log.i(totalWeight);
    // log.i(packages);
    // log.i(contents);
    // log.i(shipmentService);
    // log.i("message: inside RequestShipment");

    final response = await http.post(
      base_url + '/api/request-shipment',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "packages": packages,
        "contents": contents,
        "insured": 1,
        "weight": 100,
        "addresses": {"origin": origin, "destination": destination},
        "service": slectedService
      }),
    );
    var responseData = json.decode(response.body);

    //log.i(response.statusCode);
    log.i(response.body);

    if (response.statusCode == 200) {
      log.i("Shipment Request Made Successfully");
      return ShipmentRequestResponse.fromJson(responseData);
    } else {
      return ShipmentRequestResponse(
          error: true, message: "Error try Again", data: null);
    }
  }
}
