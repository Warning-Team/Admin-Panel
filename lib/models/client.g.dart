// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(String apiId, Map<String, dynamic> json) {
  Client client = Client(
    id: json['id'],
    apiId: apiId,
    stir: json['stir'],
    companyName: json['companyName'].toString(),
    eId: json['eId'],
    phoneNumber: (json['phoneNumber'] as String),
  );
  return client;
}

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'stir': instance.stir,
      'companyName': instance.companyName,
      'eId': instance.eId,
      'phoneNumber': instance.phoneNumber,
    };
