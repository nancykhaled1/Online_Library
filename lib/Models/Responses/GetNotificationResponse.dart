/// success : true
/// data : {"message":"Notifications fetched successfully","notifications":[{"_id":"6926249964f8c46c58c838a3","user":"69247d9658540df5fe549dfd","notification":{"_id":"6926249864f8c46c58c838a1","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-25T21:50:16.956Z"},"read":false,"__v":0,"createdAt":"2025-11-25T21:50:17.200Z","updatedAt":"2025-11-25T21:50:17.200Z"}]}

class GetNotificationResponse {
  GetNotificationResponse({
      this.success, 
      this.data,});

  GetNotificationResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? NotificationData.fromJson(json['data']) : null;
  }
  bool? success;
  NotificationData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// message : "Notifications fetched successfully"
/// notifications : [{"_id":"6926249964f8c46c58c838a3","user":"69247d9658540df5fe549dfd","notification":{"_id":"6926249864f8c46c58c838a1","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-25T21:50:16.956Z"},"read":false,"__v":0,"createdAt":"2025-11-25T21:50:17.200Z","updatedAt":"2025-11-25T21:50:17.200Z"}]

class NotificationData {
  NotificationData({
      this.message, 
      this.notifications,});

  NotificationData.fromJson(dynamic json) {
    message = json['message'];
    if (json['notifications'] != null) {
      notifications = [];
      json['notifications'].forEach((v) {
        notifications?.add(Notifications.fromJson(v));
      });
    }
  }
  String? message;
  List<Notifications>? notifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (notifications != null) {
      map['notifications'] = notifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6926249964f8c46c58c838a3"
/// user : "69247d9658540df5fe549dfd"
/// notification : {"_id":"6926249864f8c46c58c838a1","title":"test","body":"This is a test notification from Postman","relatedId":null,"createdAt":"2025-11-25T21:50:16.956Z"}
/// read : false
/// __v : 0
/// createdAt : "2025-11-25T21:50:17.200Z"
/// updatedAt : "2025-11-25T21:50:17.200Z"

class Notifications {
  Notifications({
      this.id, 
      this.user, 
      this.notification, 
      this.read, 
      this.v, 
      this.createdAt, 
      this.updatedAt,});

  Notifications.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'];
    notification = json['notification'] != null ? Notification.fromJson(json['notification']) : null;
    read = json['read'];
    v = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? user;
  Notification? notification;
  bool? read;
  int? v;
  String? createdAt;
  String? updatedAt;

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