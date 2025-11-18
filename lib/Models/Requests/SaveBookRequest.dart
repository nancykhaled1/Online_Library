/// bookId : "69148415cfcbb44fd76e54d3"

class SaveBookRequest {
  SaveBookRequest({
      this.bookId,});

  SaveBookRequest.fromJson(dynamic json) {
    bookId = json['bookId'];
  }
  String? bookId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bookId'] = bookId;
    return map;
  }

}