/// success : true
/// data : {"message":"Category fetched successfully.","category":{"_id":"691b5a2128146284cb63eda9","name":"Novels","parentId":null,"createdAt":"2025-11-17T17:23:45.104Z","updatedAt":"2025-11-17T17:23:45.104Z","__v":0},"children":[{"_id":"691b7d849e366d61f7897b75","name":"nnnnnnnnnnn"}]}

class CategoryByIdResponse {
  CategoryByIdResponse({
      this.success, 
      this.data,});

  CategoryByIdResponse.fromJson(dynamic json) {
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

/// message : "Category fetched successfully."
/// category : {"_id":"691b5a2128146284cb63eda9","name":"Novels","parentId":null,"createdAt":"2025-11-17T17:23:45.104Z","updatedAt":"2025-11-17T17:23:45.104Z","__v":0}
/// children : [{"_id":"691b7d849e366d61f7897b75","name":"nnnnnnnnnnn"}]

class Data {
  Data({
      this.message, 
      this.category, 
      this.children,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children?.add(Children.fromJson(v));
      });
    }
  }
  String? message;
  Category? category;
  List<Children>? children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (children != null) {
      map['children'] = children?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "691b7d849e366d61f7897b75"
/// name : "nnnnnnnnnnn"

class Children {
  Children({
      this.id, 
      this.name,});

  Children.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }

}

/// _id : "691b5a2128146284cb63eda9"
/// name : "Novels"
/// parentId : null
/// createdAt : "2025-11-17T17:23:45.104Z"
/// updatedAt : "2025-11-17T17:23:45.104Z"
/// __v : 0

class Category {
  Category({
      this.id, 
      this.name, 
      this.parentId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Category.fromJson(dynamic json) {
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