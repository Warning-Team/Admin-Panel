

import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
  String apiId;
  String id;
  String stir;
  String companyName;
  String phoneNumber;
  String eId;

  Client({
    required this.id,
    required this.apiId,
    required this.stir,
    required this.companyName,
    required this.eId,
    required this.phoneNumber,
  });

  factory Client.fromJson(String apiId, Map<String, dynamic> json) {
    return _$ClientFromJson(apiId, json);
  }

  Map<String, dynamic> toJson() {
    return _$ClientToJson(this);
  }
}
