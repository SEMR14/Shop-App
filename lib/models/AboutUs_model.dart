class AboutUs_Model {
  bool? status;
  Data? data;

  AboutUs_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  String? about;
  String? terms;

  Data.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    terms = json['terms'];
  }
}
