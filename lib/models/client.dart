import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
<<<<<<< HEAD
  
=======
 String apiId;
>>>>>>> 20389ab6ed5dfca4635f186d57396848568e8341
  int id;
  String stir;
  String companyName;
  String phoneNumber;
  int eId;

  Client({
    required this.id,
    required this.apiId,
    required this.stir,
    required this.companyName,
    required this.eId,
    required this.phoneNumber,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return _$ClientFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ClientToJson(this);
  }
}
