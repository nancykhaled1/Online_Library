/// success : true
/// data : {"message":"Book removed from favorites"}

class RemoveSavedBook {
  RemoveSavedBook({
      this.success, 
      this.data,});

  RemoveSavedBook.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? RemoveData.fromJson(json['data']) : null;
  }
  bool? success;
  RemoveData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// message : "Book removed from favorites"

class RemoveData {
  RemoveData({
      this.message,});

  RemoveData.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}