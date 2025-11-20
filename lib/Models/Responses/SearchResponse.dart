/// success : true
/// data : {"books":[{"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","categoryId":"691b7d849e366d61f7897b75","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:17:46.596Z","updatedAt":"2025-11-18T15:17:46.596Z","__v":0,"averageRating":5},{"_id":"691c8eb9b4adb1589feb5249","name":"Book","categoryId":"691c8e69b4adb1589feb523b","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479223/books/qnkofkb7u7smy39amtcn.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479223/books/gallery/jjxucmvtkt7aiu5ggdk0.png"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:20:25.167Z","updatedAt":"2025-11-18T15:20:25.167Z","__v":0,"averageRating":null}]}

class SearchResponse {
  SearchResponse({
      this.success, 
      this.data,});

  SearchResponse.fromJson(dynamic json) {
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

/// books : [{"_id":"691c8e1ab4adb1589feb5238","name":"Education Book","categoryId":"691b7d849e366d61f7897b75","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:17:46.596Z","updatedAt":"2025-11-18T15:17:46.596Z","__v":0,"averageRating":5},{"_id":"691c8eb9b4adb1589feb5249","name":"Book","categoryId":"691c8e69b4adb1589feb523b","mainImage":"https://res.cloudinary.com/diubywm4o/image/upload/v1763479223/books/qnkofkb7u7smy39amtcn.png","gallery":["https://res.cloudinary.com/diubywm4o/image/upload/v1763479223/books/gallery/jjxucmvtkt7aiu5ggdk0.png"],"numberOfCopies":10,"numberInStock":10,"borrowedBy":0,"publisher":"Publisher Name","writer":"Writer Name","language":"English","publishYear":2022,"edition":"First","Synopsis":"This is a sample book.","numPages":250,"condition":"old","weight":500,"createdAt":"2025-11-18T15:20:25.167Z","updatedAt":"2025-11-18T15:20:25.167Z","__v":0,"averageRating":null}]

class Data {
  Data({
      this.books,});

  Data.fromJson(dynamic json) {
    if (json['books'] != null) {
      books = [];
      json['books'].forEach((v) {
        books?.add(SearchBooks.fromJson(v));
      });
    }
  }
  List<SearchBooks>? books;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (books != null) {
      map['books'] = books?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "691c8e1ab4adb1589feb5238"
/// name : "Education Book"
/// categoryId : "691b7d849e366d61f7897b75"
/// mainImage : "https://res.cloudinary.com/diubywm4o/image/upload/v1763479065/books/chdzelz8kmupshp6doyt.png"
/// gallery : ["https://res.cloudinary.com/diubywm4o/image/upload/v1763479066/books/gallery/y3bee0pvhanede3skz8d.png"]
/// numberOfCopies : 10
/// numberInStock : 10
/// borrowedBy : 0
/// publisher : "Publisher Name"
/// writer : "Writer Name"
/// language : "English"
/// publishYear : 2022
/// edition : "First"
/// Synopsis : "This is a sample book."
/// numPages : 250
/// condition : "old"
/// weight : 500
/// createdAt : "2025-11-18T15:17:46.596Z"
/// updatedAt : "2025-11-18T15:17:46.596Z"
/// __v : 0
/// averageRating : 5

class SearchBooks {
  SearchBooks({
      this.id, 
      this.name, 
      this.categoryId, 
      this.mainImage, 
      this.gallery, 
      this.numberOfCopies, 
      this.numberInStock, 
      this.borrowedBy, 
      this.publisher, 
      this.writer, 
      this.language, 
      this.publishYear, 
      this.edition, 
      this.synopsis, 
      this.numPages, 
      this.condition, 
      this.weight, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.averageRating,});

  SearchBooks.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    categoryId = json['categoryId'];
    mainImage = json['mainImage'];
    gallery = json['gallery'] != null ? json['gallery'].cast<String>() : [];
    numberOfCopies = json['numberOfCopies'];
    numberInStock = json['numberInStock'];
    borrowedBy = json['borrowedBy'];
    publisher = json['publisher'];
    writer = json['writer'];
    language = json['language'];
    publishYear = json['publishYear'];
    edition = json['edition'];
    synopsis = json['Synopsis'];
    numPages = json['numPages'];
    condition = json['condition'];
    weight = json['weight'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    averageRating = json['averageRating'];
  }
  String? id;
  String? name;
  String? categoryId;
  String? mainImage;
  List<String>? gallery;
  int? numberOfCopies;
  int? numberInStock;
  int? borrowedBy;
  String? publisher;
  String? writer;
  String? language;
  int? publishYear;
  String? edition;
  String? synopsis;
  int? numPages;
  String? condition;
  int? weight;
  String? createdAt;
  String? updatedAt;
  int? v;
  int? averageRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['categoryId'] = categoryId;
    map['mainImage'] = mainImage;
    map['gallery'] = gallery;
    map['numberOfCopies'] = numberOfCopies;
    map['numberInStock'] = numberInStock;
    map['borrowedBy'] = borrowedBy;
    map['publisher'] = publisher;
    map['writer'] = writer;
    map['language'] = language;
    map['publishYear'] = publishYear;
    map['edition'] = edition;
    map['Synopsis'] = synopsis;
    map['numPages'] = numPages;
    map['condition'] = condition;
    map['weight'] = weight;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['averageRating'] = averageRating;
    return map;
  }

}