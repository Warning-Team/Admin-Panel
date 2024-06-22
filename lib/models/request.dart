class Request {
  int id;
  int eId;
  int cId;
  DateTime date;
  String description;
  List<String> imgUrls;

  Request({
    required this.id,
    required this.eId,
    required this.cId,
    required this.date,
    required this.description,
    required this.imgUrls,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],
      eId: json['eId'],
      cId: json['cId'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      imgUrls: List<String>.from(json['imgUrls']),
    );
  }
}
