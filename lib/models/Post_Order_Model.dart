class Post_Order_Model {
  bool? status;
  String? message;
  Data? data;

  Post_Order_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] == null ? null : Data.fromJson(json['data']);
  }
}

class Data {
  dynamic paymentMethod;
  dynamic cost;
  dynamic vat;
  dynamic discount;
  dynamic points;
  dynamic total;
  int? id;

  Data.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    cost = json['cost'];
    vat = json['vat'];
    discount = json['discount'];
    points = json['points'];
    total = json['total'];
    id = json['id'];
  }
}
