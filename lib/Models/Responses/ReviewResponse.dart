/// success : true
/// data : {"message":"Review added","review":{"bookId":"691a468ba5c283182c4de7de","userId":"691740a6c824bbdb62ac1cf2","rating":3,"_id":"691b285028146284cb63ed30","createdAt":"2025-11-17T13:51:12.409Z","updatedAt":"2025-11-17T13:51:12.409Z","__v":0}}

class ReviewResponse {
  ReviewResponse({
      this.success, 
      this.data,});

  ReviewResponse.fromJson(dynamic json) {
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

/// message : "Review added"
/// review : {"bookId":"691a468ba5c283182c4de7de","userId":"691740a6c824bbdb62ac1cf2","rating":3,"_id":"691b285028146284cb63ed30","createdAt":"2025-11-17T13:51:12.409Z","updatedAt":"2025-11-17T13:51:12.409Z","__v":0}

class Data {
  Data({
      this.message, 
      this.review,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    review = json['review'] != null ? Review.fromJson(json['review']) : null;
  }
  String? message;
  Review? review;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (review != null) {
      map['review'] = review?.toJson();
    }
    return map;
  }

}

/// bookId : "691a468ba5c283182c4de7de"
/// userId : "691740a6c824bbdb62ac1cf2"
/// rating : 3
/// _id : "691b285028146284cb63ed30"
/// createdAt : "2025-11-17T13:51:12.409Z"
/// updatedAt : "2025-11-17T13:51:12.409Z"
/// __v : 0

class Review {
  Review({
      this.bookId, 
      this.userId, 
      this.rating, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Review.fromJson(dynamic json) {
    bookId = json['bookId'];
    userId = json['userId'];
    rating = json['rating'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? bookId;
  String? userId;
  int? rating;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bookId'] = bookId;
    map['userId'] = userId;
    map['rating'] = rating;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}