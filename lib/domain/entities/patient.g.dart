// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Patient _$$_PatientFromJson(Map<String, dynamic> json) => _$_Patient(
      id: json['id'] as String,
      name: json['name'] as String,
      fcmToken: json['fcmToken'] as String? ?? '',
      joinedOn: DateTime.parse(json['joinedOn'] as String),
      chatList: (json['chatList'] as List<dynamic>)
          .map((e) => ChatInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      appointments: (json['appointments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      favoriteDoctors: (json['favoriteDoctors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      callState: json['callState'] == null
          ? null
          : CallState.fromJson(json['callState'] as Map<String, dynamic>),
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      imageUrl: json['imageUrl'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$_PatientToJson(_$_Patient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fcmToken': instance.fcmToken,
      'joinedOn': instance.joinedOn.toIso8601String(),
      'chatList': instance.chatList.map((e) => e.toJson()).toList(),
      'appointments': instance.appointments,
      'favoriteDoctors': instance.favoriteDoctors,
      'callState': instance.callState?.toJson(),
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'email': instance.email,
    };
