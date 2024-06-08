// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(String apiId, Map<String, dynamic> json) => Client(
      id: (json['id'] as num).toInt(),
      apiId: apiId,
      stir: json['stir'] as String,
      companyName: json['compName'] as String,
      eId: (json['eId'] as num).toInt(),
      phoneNumber: (json['phoneNumber'] as String),
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'stir': instance.stir,
      'compName': instance.companyName,
      'eId': instance.eId,
      'phoneNumber': instance.phoneNumber,
    };
