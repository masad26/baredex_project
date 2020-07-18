class ShipmentContent {
  String title;
  String unitPrice;
  String quantity;
  String weight;

  ShipmentContent({this.title, this.unitPrice, this.quantity, this.weight});

  ShipmentContent.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    unitPrice = json['unit_price'];
    quantity = json['quantity'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['unit_price'] = this.unitPrice;
    data['quantity'] = this.quantity;
    data['weight'] = this.weight;
    return data;
  }
}
