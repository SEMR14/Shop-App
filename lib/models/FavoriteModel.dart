class favorite_model {
  bool? status;
  String? message;

  favorite_model.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
