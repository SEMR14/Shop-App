// ignore: camel_case_types
class HomePage_Model {
  bool? status;
  Null? message;
  Home_Data? data;

  HomePage_Model({this.status, this.message, this.data});

  HomePage_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Home_Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

// ignore: camel_case_types
class Home_Data {
  List<banners_model>? banners;
  List<products_model>? products;
  String? ad;

  Home_Data({this.banners, this.products, this.ad});

  Home_Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <banners_model>[];
      json['banners'].forEach((v) {
        banners!.add(banners_model.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <products_model>[];
      json['products'].forEach((v) {
        products!.add(products_model.fromJson(v));
      });
    }
    ad = json['ad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['ad'] = this.ad;
    return data;
  }
}

class banners_model {
  int? id;
  String? image;
  Null? category;
  Null? product;

  banners_model({this.id, this.image, this.category, this.product});

  banners_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['category'] = this.category;
    data['product'] = this.product;
    return data;
  }
}

// ignore: camel_case_types
class products_model {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  products_model(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description,
      this.images,
      this.inFavorites,
      this.inCart});

  products_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['images'] = this.images;
    data['in_favorites'] = this.inFavorites;
    data['in_cart'] = this.inCart;
    return data;
  }
}
