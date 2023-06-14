class CategoriesModel {
  bool? status;
  CategoriesData? data;

  CategoriesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesData.fromjson(json['data']);
  }
}

class CategoriesData {
  int? current_page;
  List<CategoriesDataList> dataList = [];
  CategoriesData.fromjson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((Element) {
      dataList.add(CategoriesDataList.fromjson(Element));
    });
  }
}

class CategoriesDataList {
  int? id;
  String? name;
  String? image;

  CategoriesDataList.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
