// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(String apiId, Map<String, dynamic> json) {
  Client client = Client(
    id: json['id'].toString(),
    apiId: apiId,
    stir: json['stir'].toString(),
    companyName: json['companyName'].toString(),
    eId: json['eId'].toString(),
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
