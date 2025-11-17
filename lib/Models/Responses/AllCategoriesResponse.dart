/// success : true
/// data : {"categories":[{"_id":"6919d302a5c283182c4de7c5","name":"Technology","parentId":null,"createdAt":"2025-11-16T13:34:58.950Z","updatedAt":"2025-11-16T13:34:58.950Z","__v":0}]}

class AllCategoriesResponse {
  AllCategoriesResponse({
      this.success, 
      this.data,});

  AllCategoriesResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// categories : [{"_id":"6919d302a5c283182c4de7c5","name":"Technology","parentId":null,"createdAt":"2025-11-16T13:34:58.950Z","updatedAt":"2025-11-16T13:34:58.950Z","__v":0}]

class Data {
  Data({
      this.categories,});

  Data.fromJson(dynamic json) {
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
  }
  List<Categories>? categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6919d302a5c283182c4de7c5"
/// name : "Technology"
/// parentId : null
/// createdAt : "2025-11-16T13:34:58.950Z"
/// updatedAt : "2025-11-16T13:34:58.950Z"
/// __v : 0

class Categories {
  Categories({
      this.id, 
      this.name, 
      this.parentId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Categories.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    parentId = json['parentId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? name;
  dynamic parentId;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['parentId'] = parentId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}