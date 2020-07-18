class Cities {
  bool error;
  String message;
  List<City> data;

  Cities({this.error, this.message, this.data});

  Cities.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<City>();
      json['data'].forEach((v) {
        data.add(new City.fromJson(v));
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

class City {
  String cityName;
  String postCode;

  City({this.cityName, this.postCode});

  City.fromJson(Map<String, dynamic> json) {
    cityName = json['city_name'];
    postCode = json['post_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_name'] = this.cityName;
    data['post_code'] = this.postCode;
    return data;
  }
}
