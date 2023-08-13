// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CallState _$$_CallStateFromJson(Map<String, dynamic> json) => _$_CallState(
      token: json['token'] as String? ?? '',
      doctorId: json['doctorId'] as String,
      channelName: json['channelName'] as String,
      patientId: json['patientId'] as String,
      callStates:
          $enumDecodeNullable(_$CallStatesEnumMap, json['callStates']) ??
              CallStates.nothing,
    );

Map<String, dynamic> _$$_CallStateToJson(_$_CallState instance) =>
    <String, dynamic>{
      'token': instance.token,
      'doctorId': instance.doctorId,
      'channelName': instance.channelName,
      'patientId': instance.patientId,
      'callStates': _$CallStatesEnumMap[instance.callStates]!,
    };

const _$CallStatesEnumMap = {
  CallStates.incomingCall: 'incomingCall',
  CallStates.ongoingCall: 'ongoingCall',
  CallStates.nothing: 'nothing',
  CallStates.calling: 'calling',
};
