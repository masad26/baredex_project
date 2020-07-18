// To parse this JSON data, do
//
//     final requestRateModel = requestRateModelFromJson(jsonString);

import 'dart:convert';

RequestRateModel requestRateModelFromJson(String str) =>
    RequestRateModel.fromJson(json.decode(str));

String requestRateModelToJson(RequestRateModel data) =>
    json.encode(data.toJson());

class RequestRateModel {
  List<Package> packages;
  double weight;
  Addresses addresses;

  RequestRateModel({
    this.packages,
    this.weight,
    this.addresses,
  });

  factory RequestRateModel.fromJson(Map<String, dynamic> json) =>
      RequestRateModel(
        packages: List<Package>.from(
            json["packages"].map((x) => Package.fromJson(x))),
        weight: json["weight"].toDouble(),
        addresses: Addresses.fromJson(json["addresses"]),
      );

  Map<String, dynamic> toJson() => {
        "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
        "weight": weight,
        "addresses": addresses.toJson(),
      };
}

class Addresses {
  int origin;
  int destination;

  Addresses({
    this.origin,
    this.destination,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) => Addresses(
        origin: json["origin"],
        destination: json["destination"],
      );

  Map<String, dynamic> toJson() => {
        "origin": origin,
        "destination": destination,
      };
}

class Package {
  double weight;
  double height;
  double width;
  double length;
  int quantity;
  int type;

  Package({
    this.weight,
    this.height,
    this.width,
    this.length,
    this.quantity,
    this.type,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        weight: json["weight"].toDouble(),
        height: json["height"].toDouble(),
        width: json["width"].toDouble(),
        length: json["length"].toDouble(),
        quantity: json["quantity"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "height": height,
        "width": width,
        "length": length,
        "quantity": quantity,
        "type": type,
      };
}
