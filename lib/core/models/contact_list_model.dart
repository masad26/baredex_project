// To parse this JSON data, do
//
//     final contactList = contactListFromJson(jsonString);

import 'dart:convert';

ContactList contactListFromJson(String str) =>
    ContactList.fromJson(json.decode(str));

String contactListToJson(ContactList data) => json.encode(data.toJson());

class ContactList {
  bool error;
  dynamic message;
  List<Datum> data;

  ContactList({
    this.error,
    this.message,
    this.data,
  });

  factory ContactList.fromJson(Map<String, dynamic> json) => ContactList(
        error: json["error"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  int userId;
  int countryId;
  String city;
  String firstName;
  String secondName;
  String lastName;
  String mobile;
  String email;
  String addressOne;
  String addressTwo;
  String postalCode;
  String state;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String company;
  Country country;

  Datum({
    this.id,
    this.userId,
    this.countryId,
    this.city,
    this.firstName,
    this.secondName,
    this.lastName,
    this.mobile,
    this.email,
    this.addressOne,
    this.addressTwo,
    this.postalCode,
    this.state,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.company,
    this.country,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        countryId: json["country_id"],
        city: json["city"],
        firstName: json["first_name"],
        secondName: json["second_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        email: json["email"],
        addressOne: json["address_one"],
        addressTwo: json["address_two"],
        postalCode: json["postal_code"],
        state: json["state"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        company: json["company"],
        country: Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "country_id": countryId,
        "city": city,
        "first_name": firstName,
        "second_name": secondName,
        "last_name": lastName,
        "mobile": mobile,
        "email": email,
        "address_one": addressOne,
        "address_two": addressTwo,
        "postal_code": postalCode,
        "state": state,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "company": company,
        "country": country.toJson(),
      };
}

class Country {
  int id;
  String iso;
  String name;
  String niceName;
  String iso3;
  int numCode;
  int phoneCode;
  dynamic zone;
  int direction;

  Country({
    this.id,
    this.iso,
    this.name,
    this.niceName,
    this.iso3,
    this.numCode,
    this.phoneCode,
    this.zone,
    this.direction,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        iso: json["iso"],
        name: json["name"],
        niceName: json["nice_name"],
        iso3: json["iso3"],
        numCode: json["num_code"],
        phoneCode: json["phone_code"],
        zone: json["zone"],
        direction: json["direction"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "iso": iso,
        "name": name,
        "nice_name": niceName,
        "iso3": iso3,
        "num_code": numCode,
        "phone_code": phoneCode,
        "zone": zone,
        "direction": direction,
      };
}
