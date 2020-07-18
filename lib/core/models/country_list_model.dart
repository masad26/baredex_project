class Countries {
  bool error;
  String message;
  List<Data> data;

  Countries({this.error, this.message, this.data});

  Countries.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String niceName;
  String iso;
  int phoneCode;

  Data({this.id, this.niceName, this.iso, this.phoneCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    niceName = json['nice_name'];
    iso = json['iso'];
    phoneCode = json['phone_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nice_name'] = this.niceName;
    data['iso'] = this.iso;
    data['phone_code'] = this.phoneCode;
    return data;
  }
}
