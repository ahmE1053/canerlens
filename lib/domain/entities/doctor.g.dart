// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Doctor _$$_DoctorFromJson(Map<String, dynamic> json) => _$_Doctor(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      speciality: json['speciality'] as String,
      aboutDoctor: json['aboutDoctor'] as String,
      callState: json['callState'] == null
          ? null
          : CallState.fromJson(json['callState'] as Map<String, dynamic>),
      fcmToken: json['fcmToken'] as String? ?? '',
      joinedOn: DateTime.parse(json['joinedOn'] as String),
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      chatList: (json['chatList'] as List<dynamic>?)
              ?.map((e) => ChatInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      rating: (json['rating'] as num).toDouble(),
      location: ClinicLocation.fromJson(
          (json['location'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, e as Object),
      )),
      availableOn: DoctorAvailability.fromJson(
          json['availableOn'] as Map<String, dynamic>),
      doctorState: $enumDecode(_$DoctorStateEnumMap, json['doctorState']),
    );

Map<String, dynamic> _$$_DoctorToJson(_$_Doctor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'speciality': instance.speciality,
      'aboutDoctor': instance.aboutDoctor,
      'callState': instance.callState?.toJson(),
      'fcmToken': instance.fcmToken,
      'joinedOn': instance.joinedOn.toIso8601String(),
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
      'chatList': instance.chatList.map((e) => e.toJson()).toList(),
      'rating': instance.rating,
      'location': instance.location.toJson(),
      'availableOn': instance.availableOn.toJson(),
      'doctorState': _$DoctorStateEnumMap[instance.doctorState]!,
    };

const _$DoctorStateEnumMap = {
  DoctorState.busy: 'busy',
  DoctorState.available: 'available',
  DoctorState.offline: 'offline',
};

_$_Review _$$_ReviewFromJson(Map<String, dynamic> json) => _$_Review(
      rating: (json['rating'] as num).toDouble(),
      review: json['review'] as String,
    );

Map<String, dynamic> _$$_ReviewToJson(_$_Review instance) => <String, dynamic>{
      'rating': instance.rating,
      'review': instance.review,
    };

_$_DoctorAvailability _$$_DoctorAvailabilityFromJson(
        Map<String, dynamic> json) =>
    _$_DoctorAvailability(
      online: json['online'] as bool,
      offline: json['offline'] as bool,
      onlineAvailability: (json['onlineAvailability'] as List<dynamic>?)
          ?.map((e) => OnlineAvailability.fromJson(e as Map<String, dynamic>))
          .toList(),
      offlineAvailability: (json['offlineAvailability'] as List<dynamic>?)
          ?.map((e) => OfflineAvailability.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_DoctorAvailabilityToJson(
        _$_DoctorAvailability instance) =>
    <String, dynamic>{
      'online': instance.online,
      'offline': instance.offline,
      'onlineAvailability':
          instance.onlineAvailability?.map((e) => e.toJson()).toList(),
      'offlineAvailability':
          instance.offlineAvailability?.map((e) => e.toJson()).toList(),
    };

_$_OnlineAvailability _$$_OnlineAvailabilityFromJson(
        Map<String, dynamic> json) =>
    _$_OnlineAvailability(
      day: DateTime.parse(json['day'] as String),
      timesAvailable: (json['timesAvailable'] as List<dynamic>)
          .map((e) => TimeInDayOnline.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_OnlineAvailabilityToJson(
        _$_OnlineAvailability instance) =>
    <String, dynamic>{
      'day': instance.day.toIso8601String(),
      'timesAvailable': instance.timesAvailable.map((e) => e.toJson()).toList(),
    };

_$_TimeInDayOnline _$$_TimeInDayOnlineFromJson(Map<String, dynamic> json) =>
    _$_TimeInDayOnline(
      timeOfDay: json['timeOfDay'] as String,
      available: json['available'] as bool,
    );

Map<String, dynamic> _$$_TimeInDayOnlineToJson(_$_TimeInDayOnline instance) =>
    <String, dynamic>{
      'timeOfDay': instance.timeOfDay,
      'available': instance.available,
    };

_$_OfflineAvailability _$$_OfflineAvailabilityFromJson(
        Map<String, dynamic> json) =>
    _$_OfflineAvailability(
      day: DateTime.parse(json['day'] as String),
      timeFrom: json['timeFrom'] as String,
      timeTo: json['timeTo'] as String,
    );

Map<String, dynamic> _$$_OfflineAvailabilityToJson(
        _$_OfflineAvailability instance) =>
    <String, dynamic>{
      'day': instance.day.toIso8601String(),
      'timeFrom': instance.timeFrom,
      'timeTo': instance.timeTo,
    };

_$_ClinicLocation _$$_ClinicLocationFromJson(Map<String, dynamic> json) =>
    _$_ClinicLocation(
      location: json['location'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$$_ClinicLocationToJson(_$_ClinicLocation instance) =>
    <String, dynamic>{
      'location': instance.location,
      'coordinates': instance.coordinates,
    };
