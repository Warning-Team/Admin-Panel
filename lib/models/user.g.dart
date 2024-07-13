// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(String apiId, Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      apiId: apiId,
      name: json['name'] as String,
      surname: json['surname'] as String,
      phoneNumber: json['phoneNumber'] as String,
      workPlace: json['workPlace'] as String,
      login: json['login'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      uId: json['uId'] as String,
      imageUrl: json['imageUrl'] as String
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'phoneNumber': instance.phoneNumber,
      'workPlace': instance.workPlace,
      'login': instance.login,
      'password': instance.password,
      'role': instance.role,
      'uId': instance.uId,
      'imageUrl' : instance.imageUrl
    };
