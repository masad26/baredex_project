class Contact {
  bool error;
  dynamic message;
  Data data;

  Contact({this.error, this.message, this.data});

  Contact.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
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
  Null deletedAt;
  String createdAt;
  String updatedAt;
  String company;

  Data(
      {this.id,
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
      this.company});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    countryId = json['country_id'];
    city = json['city'];
    firstName = json['first_name'];
    secondName = json['second_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
    addressOne = json['address_one'];
    addressTwo = json['address_two'];
    postalCode = json['postal_code'];
    state = json['state'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['country_id'] = this.countryId;
    data['city'] = this.city;
    data['first_name'] = this.firstName;
    data['second_name'] = this.secondName;
    data['last_name'] = this.lastName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['address_one'] = this.addressOne;
    data['address_two'] = this.addressTwo;
    data['postal_code'] = this.postalCode;
    data['state'] = this.state;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['company'] = this.company;
    return data;
  }
}
