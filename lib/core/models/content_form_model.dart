class Content {
  String title;
  double unitPrice;
  int quantity;
  double weight;

  Content({
    this.title,
    this.unitPrice = 0.00,
    this.quantity = 1,
    this.weight = 0.00,
  });

  Content.fromJson(Map<String, dynamic> json) {
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
