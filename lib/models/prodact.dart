class CoursesProdect {
  String? title;
  double? price;
  String? proImageUrl;

  int? _id;
  int? coursesId;

  CoursesProdect(dynamic obj) {
    _id = obj['id'];
    coursesId = obj['CoursesId'];

    title = obj['title'];
    price = obj['price'];
    proImageUrl = obj['proImageUrl'];
  }
  CoursesProdect.formMap(Map<String, dynamic> data) {
    _id = data['id'];
    coursesId = data['CoursesId'];

    title = data['title'];
    price = data['price'];
    proImageUrl = data['proImageUrl'];
  }
  Map<String, dynamic> toMap() => {
        'id': _id,
        'CoursesId': coursesId,
        'title': title,
        'price': price,
        'proImageUrl': proImageUrl,
      };
}

class CustomVisa {
  String? cvvNumber;
  String? exDate;
  String? type;
  String? visaNumber;
  int? _id;
  CustomVisa(dynamic obj) {
    _id = obj['id'];
    cvvNumber = obj['cvvNumber'];
    exDate = obj['exDate'];
    type = obj['type'];
    visaNumber = obj['visaNumber'];
  }
  CustomVisa.formMap(Map<String, dynamic> data) {
    _id = data['id'];
    cvvNumber = data['cvvNumber'];
    exDate = data['exDate'];
    type = data['type'];
    visaNumber = data['visaNumber'];
  }
  Map<String, dynamic> toMap() => {
        'id': _id,
        'cvvNumber': cvvNumber,
        'exDate': exDate,
        'visaNumber': visaNumber,
        'type': type,
      };
}
