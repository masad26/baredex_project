class ShipmentPackages {
  List<Packages> packages;

  ShipmentPackages({this.packages});

  ShipmentPackages.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages = new List<Packages>();
      json['packages'].forEach((v) {
        packages.add(new Packages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packages != null) {
      data['packages'] = this.packages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Packages {
  double weight;
  double height;
  double width;
  double length;
  int quantity;
  int type;

  Packages(
      {this.weight,
      this.height,
      this.width,
      this.length,
      this.quantity,
      this.type});

  Packages.fromJson(Map<String, dynamic> json) {
    weight = json['weight'];
    height = json['height'];
    width = json['width'];
    length = json['length'];
    quantity = json['quantity'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['width'] = this.width;
    data['length'] = this.length;
    data['quantity'] = this.quantity;
    data['type'] = this.type;
    return data;
  }
}
