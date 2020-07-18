class ContactCreated {
  bool error;
  String message;
  Data data;

  ContactCreated({this.error, this.message, this.data});

  ContactCreated.fromJson(Map<String, dynamic> json) {
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
  String firstName;
  String secondName;
  String lastName;
  String email;
  String countryId;
  String city;
  String mobile;
  String addressOne;
  String addressTwo;
  String postalCode;
  String state;
  String company;
  int userId;
  String updatedAt;
  String createdAt;
  int id;

  Data(
      {this.firstName,
      this.secondName,
      this.lastName,
      this.email,
      this.countryId,
      this.city,
      this.mobile,
      this.addressOne,
      this.addressTwo,
      this.postalCode,
      this.state,
      this.company,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    secondName = json['second_name'];
    lastName = json['last_name'];
    email = json['email'];
    countryId = json['country_id'];
    city = json['city'];
    mobile = json['mobile'];
    addressOne = json['address_one'];
    addressTwo = json['address_two'];
    postalCode = json['postal_code'];
    state = json['state'];
    company = json['company'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['second_name'] = this.secondName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['country_id'] = this.countryId;
    data['city'] = this.city;
    data['mobile'] = this.mobile;
    data['address_one'] = this.addressOne;
    data['address_two'] = this.addressTwo;
    data['postal_code'] = this.postalCode;
    data['state'] = this.state;
    data['company'] = this.company;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
