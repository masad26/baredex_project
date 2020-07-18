class RegisterUser {
  bool error;
  String message;
  Data data;

  RegisterUser({this.error, this.message, this.data});

  RegisterUser.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['message'] is String) {
      message = json['message'];
    } else {
      message = "Email or Phone is already been taken";
    }
    data = json['data'] != null || json['data'] == []
        ? new Data.fromJson(json['data'])
        : null;
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
  String lastName;
  String mobile;
  String email;
  int roleId;
  String updatedAt;
  String createdAt;
  int id;

  Data(
      {this.firstName,
      this.lastName,
      this.mobile,
      this.email,
      this.roleId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
    roleId = json['role_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['role_id'] = this.roleId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
