// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Appointment _$$_AppointmentFromJson(Map<String, dynamic> json) =>
    _$_Appointment(
      id: json['id'] as String,
      day: json['day'] as String,
      time: json['time'] as String,
      forAnotherPatient: json['forAnotherPatient'] as bool,
      didLeaveReview: json['didLeaveReview'] as bool,
      didLeaveCancellationReason: json['didLeaveCancellationReason'] as bool,
      phoneNumber: json['phoneNumber'] as String,
      appointmentState:
          $enumDecode(_$AppointmentStateEnumMap, json['appointmentState']),
      appointmentLocation: $enumDecode(
          _$AppointmentLocationEnumMap, json['appointmentLocation']),
      additionalInfo: json['additionalInfo'] as String,
      doctorId: json['doctorId'] as String,
      timeLeft: Duration(microseconds: json['timeLeft'] as int),
    );

Map<String, dynamic> _$$_AppointmentToJson(_$_Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'time': instance.time,
      'forAnotherPatient': instance.forAnotherPatient,
      'didLeaveReview': instance.didLeaveReview,
      'didLeaveCancellationReason': instance.didLeaveCancellationReason,
      'phoneNumber': instance.phoneNumber,
      'appointmentState': _$AppointmentStateEnumMap[instance.appointmentState]!,
      'appointmentLocation':
          _$AppointmentLocationEnumMap[instance.appointmentLocation]!,
      'additionalInfo': instance.additionalInfo,
      'doctorId': instance.doctorId,
      'timeLeft': instance.timeLeft.inMicroseconds,
    };

const _$AppointmentStateEnumMap = {
  AppointmentState.coming: 'coming',
  AppointmentState.done: 'done',
  AppointmentState.absent: 'absent',
};

const _$AppointmentLocationEnumMap = {
  AppointmentLocation.online: 'online',
  AppointmentLocation.atClinic: 'atClinic',
};
