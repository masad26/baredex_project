class Shipment {
  double weight;
  double height;
  double width;
  double length;
  int quantity;
  int type;

  Shipment({
    this.weight = 0.00,
    this.height = 0.00,
    this.width = 0.00,
    this.length = 0.00,
    this.quantity = 1,
    this.type = 1,
  });

  Shipment.fromJson(Map<String, dynamic> json) {
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
