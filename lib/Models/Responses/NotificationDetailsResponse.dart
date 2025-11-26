/// success : true
/// data : {"message":"Notification fetched successfully","notification":{"_id":"6926249964f8c46c58c838a3","user":"69247d9658540df5fe549dfd","notification":{"_id":"6926249864f8c46c58c838a1","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-25T21:50:16.956Z"},"read":true,"__v":0,"createdAt":"2025-11-25T21:50:17.200Z","updatedAt":"2025-11-25T22:04:32.496Z","readAt":"2025-11-25T22:04:32.496Z"}}

class NotificationDetailsResponse {
  NotificationDetailsResponse({
      this.success, 
      this.data,});

  NotificationDetailsResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? DataDetails.fromJson(json['data']) : null;
  }
  bool? success;
  DataDetails? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// message : "Notification fetched successfully"
/// notification : {"_id":"6926249964f8c46c58c838a3","user":"69247d9658540df5fe549dfd","notification":{"_id":"6926249864f8c46c58c838a1","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-25T21:50:16.956Z"},"read":true,"__v":0,"createdAt":"2025-11-25T21:50:17.200Z","updatedAt":"2025-11-25T22:04:32.496Z","readAt":"2025-11-25T22:04:32.496Z"}

class DataDetails {
  DataDetails({
      this.message, 
      this.notification,});

  DataDetails.fromJson(dynamic json) {
    message = json['message'];
    notification = json['notification'] != null ? NotificationDetails.fromJson(json['notification']) : null;
  }
  String? message;
  NotificationDetails? notification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (notification != null) {
      map['notification'] = notification?.toJson();
    }
    return map;
  }

}

/// _id : "6926249964f8c46c58c838a3"
/// user : "69247d9658540df5fe549dfd"
/// notification : {"_id":"6926249864f8c46c58c838a1","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-25T21:50:16.956Z"}
/// read : true
/// __v : 0
/// createdAt : "2025-11-25T21:50:17.200Z"
/// updatedAt : "2025-11-25T22:04:32.496Z"
/// readAt : "2025-11-25T22:04:32.496Z"

class NotificationDetails {
  NotificationDetails({
      this.id, 
      this.user, 
      this.notification, 
      this.read, 
      this.v, 
      this.createdAt, 
      this.updatedAt, 
      this.readAt,});

  NotificationDetails.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'];
    notification = json['notification'] != null ? Notification.fromJson(json['notification']) : null;
    read = json['read'];
    v = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    readAt = json['readAt'];
  }
  String? id;
  String? user;
  Notification? notification;
  bool? read;
  int? v;
  String? createdAt;
  String? updatedAt;
  String? readAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user'] = user;
    if (notification != null) {
      map['notification'] = notification?.toJson();
    }
    map['read'] = read;
    map['__v'] = v;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['readAt'] = readAt;
    return map;
  }

}

/// _id : "6926249864f8c46c58c838a1"
/// title : "test"
/// body : "This is a test notification from Postman"
/// relatedId : null
/// createdAt : "2025-11-25T21:50:16.956Z"

class Notification {
  Notification({
      this.id, 
      this.title, 
      this.body, 
      this.relatedId, 
      this.createdAt,});

  Notification.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    body = json['body'];
    relatedId = json['relatedId'];
    createdAt = json['createdAt'];
  }
  String? id;
  String? title;
  String? body;
  dynamic relatedId;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['body'] = body;
    map['relatedId'] = relatedId;
    map['createdAt'] = createdAt;
    return map;
  }

}