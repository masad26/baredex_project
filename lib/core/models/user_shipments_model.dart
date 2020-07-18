class UserShipments {
  bool error;
  String message;
  Data data;

  UserShipments({this.error, this.message, this.data});

  UserShipments.fromJson(Map<String, dynamic> json) {
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
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  double total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Datum>();
      json['data'].forEach((v) {
        data.add(new Datum.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Datum {
  int id;
  String trackNumber;
  int fromAddressId;
  int toAddressId;
  int statusId;
  double totalWeight;
  String vendorName;
  double totalPrice;
  String deliverTime;
  String commercialInvoicePath;
  String waybillPath;
  Origin origin;
  Origin destination;
  Status status;

  Datum(
      {this.id,
      this.trackNumber,
      this.fromAddressId,
      this.toAddressId,
      this.statusId,
      this.totalWeight,
      this.vendorName,
      this.totalPrice,
      this.deliverTime,
      this.commercialInvoicePath,
      this.waybillPath,
      this.origin,
      this.destination,
      this.status});

  Datum.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackNumber = json['track_number'];
    fromAddressId = json['from_address_id'];
    toAddressId = json['to_address_id'];
    statusId = json['status_id'];
    totalWeight = json['total_weight'].toDouble();
    vendorName = json['vendor_name'];
    totalPrice = json['total_price'].toDouble();
    deliverTime = json['deliver_time'];
    commercialInvoicePath = json['commercial_invoice_path'];
    waybillPath = json['waybill_path'];
    origin =
        json['origin'] != null ? new Origin.fromJson(json['origin']) : null;
    destination = json['destination'] != null
        ? new Origin.fromJson(json['destination'])
        : null;
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['track_number'] = this.trackNumber;
    data['from_address_id'] = this.fromAddressId;
    data['to_address_id'] = this.toAddressId;
    data['status_id'] = this.statusId;
    data['total_weight'] = this.totalWeight;
    data['vendor_name'] = this.vendorName;
    data['total_price'] = this.totalPrice;
    data['deliver_time'] = this.deliverTime;
    data['commercial_invoice_path'] = this.commercialInvoicePath;
    data['waybill_path'] = this.waybillPath;
    if (this.origin != null) {
      data['origin'] = this.origin.toJson();
    }
    if (this.destination != null) {
      data['destination'] = this.destination.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    return data;
  }
}

class Origin {
  int id;
  String city;
  String firstName;
  String secondName;
  String lastName;
  int countryId;
  Country country;

  Origin(
      {this.id,
      this.city,
      this.firstName,
      this.secondName,
      this.lastName,
      this.countryId,
      this.country});

  Origin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    firstName = json['first_name'];
    secondName = json['second_name'];
    lastName = json['last_name'];
    countryId = json['country_id'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    data['first_name'] = this.firstName;
    data['second_name'] = this.secondName;
    data['last_name'] = this.lastName;
    data['country_id'] = this.countryId;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    return data;
  }
}

class Country {
  int id;
  String name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Status {
  int id;
  String label;

  Status({this.id, this.label});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    return data;
  }
}
