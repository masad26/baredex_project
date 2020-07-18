class Getrate {
  bool error;
  String message;
  List<Data> data;

  Getrate({this.error, this.message, this.data});

  Getrate.fromJson(Map<String, dynamic> json) {
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
  String logo;
  double totalWeight;
  String vendor;
  String serviceType;
  String serviceName;
  double charge;
  String currency;
  String delivery;
  String cutOfTime;
  String saveAmount;
  String shipmentDate;
  String reference;
  String rateResponse;

  Data(
      {this.logo,
      this.totalWeight,
      this.vendor,
      this.serviceType,
      this.serviceName,
      this.charge,
      this.currency,
      this.delivery,
      this.cutOfTime,
      this.saveAmount,
      this.shipmentDate,
      this.reference,
      this.rateResponse});

  Data.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    totalWeight = json['total_weight'].toDouble();
    vendor = json['vendor'];
    serviceType = json['service_type'];
    serviceName = json['service_name'];
    charge = json['charge'].toDouble();
    currency = json['currency'];
    delivery = json['delivery'];
    cutOfTime = json['cutOfTime'];
    saveAmount = json['save_amount'];
    shipmentDate = json['shipment_date'];
    reference = json['reference'];
    rateResponse = json['rate_response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['total_weight'] = this.totalWeight;
    data['vendor'] = this.vendor;
    data['service_type'] = this.serviceType;
    data['service_name'] = this.serviceName;
    data['charge'] = this.charge;
    data['currency'] = this.currency;
    data['delivery'] = this.delivery;
    data['cutOfTime'] = this.cutOfTime;
    data['save_amount'] = this.saveAmount;
    data['shipment_date'] = this.shipmentDate;
    data['reference'] = this.reference;
    data['rate_response'] = this.rateResponse;
    return data;
  }
}
