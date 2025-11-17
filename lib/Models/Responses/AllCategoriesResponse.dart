/// success : true
/// data : {"message":"Categories fetched successfully.","categories":[{"_id":"6919d302a5c283182c4de7c5","name":"Technology","parentId":null,"createdAt":"2025-11-16T13:34:58.950Z","updatedAt":"2025-11-16T13:34:58.950Z","__v":0},{"_id":"691a4fc5a5c283182c4de7ec","name":"Education","parentId":null,"createdAt":"2025-11-16T22:27:17.273Z","updatedAt":"2025-11-16T22:27:17.273Z","__v":0},{"_id":"691b5a0a28146284cb63eda7","name":"Books","parentId":null,"createdAt":"2025-11-17T17:23:22.796Z","updatedAt":"2025-11-17T17:23:22.796Z","__v":0},{"_id":"691b5a2128146284cb63eda9","name":"Novels","parentId":null,"createdAt":"2025-11-17T17:23:45.104Z","updatedAt":"2025-11-17T17:23:45.104Z","__v":0},{"_id":"691b7d849e366d61f7897b75","name":"nnnnnnnnnnn","parentId":{"_id":"691b5a2128146284cb63eda9","name":"Novels"},"createdAt":"2025-11-17T19:54:44.707Z","updatedAt":"2025-11-17T19:54:44.707Z","__v":0}],"parents":[{"_id":"691b5a2128146284cb63eda9","name":"Novels","parentId":null,"createdAt":"2025-11-17T17:23:45.104Z","updatedAt":"2025-11-17T17:23:45.104Z","__v":0}]}

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

/// message : "Categories fetched successfully."
/// categories : [{"_id":"6919d302a5c283182c4de7c5","name":"Technology","parentId":null,"createdAt":"2025-11-16T13:34:58.950Z","updatedAt":"2025-11-16T13:34:58.950Z","__v":0},{"_id":"691a4fc5a5c283182c4de7ec","name":"Education","parentId":null,"createdAt":"2025-11-16T22:27:17.273Z","updatedAt":"2025-11-16T22:27:17.273Z","__v":0},{"_id":"691b5a0a28146284cb63eda7","name":"Books","parentId":null,"createdAt":"2025-11-17T17:23:22.796Z","updatedAt":"2025-11-17T17:23:22.796Z","__v":0},{"_id":"691b5a2128146284cb63eda9","name":"Novels","parentId":null,"createdAt":"2025-11-17T17:23:45.104Z","updatedAt":"2025-11-17T17:23:45.104Z","__v":0},{"_id":"691b7d849e366d61f7897b75","name":"nnnnnnnnnnn","parentId":{"_id":"691b5a2128146284cb63eda9","name":"Novels"},"createdAt":"2025-11-17T19:54:44.707Z","updatedAt":"2025-11-17T19:54:44.707Z","__v":0}]
/// parents : [{"_id":"691b5a2128146284cb63eda9","name":"Novels","parentId":null,"createdAt":"2025-11-17T17:23:45.104Z","updatedAt":"2025-11-17T17:23:45.104Z","__v":0}]

class Data {
  Data({
      this.message, 
      this.categories, 
      this.parents,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    if (json['parents'] != null) {
      parents = [];
      json['parents'].forEach((v) {
        parents?.add(Parents.fromJson(v));
      });
    }
  }
  String? message;
  List<Categories>? categories;
  List<Parents>? parents;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    if (parents != null) {
      map['parents'] = parents?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "691b5a2128146284cb63eda9"
/// name : "Novels"
/// parentId : null
/// createdAt : "2025-11-17T17:23:45.104Z"
/// updatedAt : "2025-11-17T17:23:45.104Z"
/// __v : 0

class Parents {
  Parents({
      this.id, 
      this.name, 
      this.parentId, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Parents.fromJson(dynamic json) {
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