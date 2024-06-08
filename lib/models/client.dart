import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
  int id;
  String stir;
  String compName;
  int eId;

  Client({
    required this.id,
    required this.stir,
    required this.compName,
    required this.eId,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return _$ClientFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ClientToJson(this);
  }
}
