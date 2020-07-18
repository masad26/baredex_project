class Login {
  bool error;
  String message;
  Data data;

  Login({this.error, this.message, this.data});

  Login.fromJson(Map<String, dynamic> json) {
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
  String accessToken;
  bool emailVerified;
  bool mobileVerified;
  String tokenType;
  String expiresAt;

  Data(
      {this.accessToken,
      this.emailVerified,
      this.mobileVerified,
      this.tokenType,
      this.expiresAt});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    emailVerified = json['email_verified'];
    mobileVerified = json['mobile_verified'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['email_verified'] = this.emailVerified;
    data['mobile_verified'] = this.mobileVerified;
    data['token_type'] = this.tokenType;
    data['expires_at'] = this.expiresAt;
    return data;
  }
}