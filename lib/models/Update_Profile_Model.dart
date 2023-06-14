class Update_Profile_Model {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? image;

  Update_Profile_Model.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
  }
}
