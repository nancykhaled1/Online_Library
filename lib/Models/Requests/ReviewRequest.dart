/// bookId : "69148415cfcbb44fd76e54d3"
/// Comment : "nice book"
/// rating : "3"

class ReviewRequest {
  ReviewRequest({
      this.bookId, 
      this.comment, 
      this.rating,});

  ReviewRequest.fromJson(dynamic json) {
    bookId = json['bookId'];
    comment = json['Comment'];
    rating = json['rating'];
  }
  String? bookId;
  String? comment;
  String? rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bookId'] = bookId;
    map['Comment'] = comment;
    map['rating'] = rating;
    return map;
  }

}