// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: (json['id'] as num).toInt(),
      stir: json['stir'] as String,
      compName: json['compName'] as String,
      eId: (json['eId'] as num).toInt(),
      phoneNumber: (json['phoneNumber'] as String),
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'stir': instance.stir,
      'compName': instance.compName,
      'eId': instance.eId,
      'phoneNumber': instance.phoneNumber,
    };
