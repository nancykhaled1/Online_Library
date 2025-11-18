/// success : true
/// data : {"message":"Book added to favorites","favorite":{"userId":"691740a6c824bbdb62ac1cf2","bookId":"691a468ba5c283182c4de7de","_id":"691bb9b283dd8054c0f6a8b7","createdAt":"2025-11-18T00:11:30.183Z","updatedAt":"2025-11-18T00:11:30.183Z","__v":0}}

class SaveBookResponse {
  SaveBookResponse({
      this.success, 
      this.data,});

  SaveBookResponse.fromJson(dynamic json) {
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

/// message : "Book added to favorites"
/// favorite : {"userId":"691740a6c824bbdb62ac1cf2","bookId":"691a468ba5c283182c4de7de","_id":"691bb9b283dd8054c0f6a8b7","createdAt":"2025-11-18T00:11:30.183Z","updatedAt":"2025-11-18T00:11:30.183Z","__v":0}

class Data {
  Data({
      this.message, 
      this.favorite,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    favorite = json['favorite'] != null ? Favorite.fromJson(json['favorite']) : null;
  }
  String? message;
  Favorite? favorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (favorite != null) {
      map['favorite'] = favorite?.toJson();
    }
    return map;
  }

}

/// userId : "691740a6c824bbdb62ac1cf2"
/// bookId : "691a468ba5c283182c4de7de"
/// _id : "691bb9b283dd8054c0f6a8b7"
/// createdAt : "2025-11-18T00:11:30.183Z"
/// updatedAt : "2025-11-18T00:11:30.183Z"
/// __v : 0

class Favorite {
  Favorite({
      this.userId, 
      this.bookId, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Favorite.fromJson(dynamic json) {
    userId = json['userId'];
    bookId = json['bookId'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? userId;
  String? bookId;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['bookId'] = bookId;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}