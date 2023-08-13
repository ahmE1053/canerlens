// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return _Appointment.fromJson(json);
}

/// @nodoc
mixin _$Appointment {
  String get id => throw _privateConstructorUsedError;
  String get day => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  bool get forAnotherPatient => throw _privateConstructorUsedError;
  bool get didLeaveReview => throw _privateConstructorUsedError;
  bool get didLeaveCancellationReason => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  AppointmentState get appointmentState => throw _privateConstructorUsedError;
  AppointmentLocation get appointmentLocation =>
      throw _privateConstructorUsedError;
  String get additionalInfo => throw _privateConstructorUsedError;
  String get doctorId => throw _privateConstructorUsedError;
  Duration get timeLeft => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentCopyWith<Appointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentCopyWith<$Res> {
  factory $AppointmentCopyWith(
          Appointment value, $Res Function(Appointment) then) =
      _$AppointmentCopyWithImpl<$Res, Appointment>;
  @useResult
  $Res call(
      {String id,
      String day,
      String time,
      bool forAnotherPatient,
      bool didLeaveReview,
      bool didLeaveCancellationReason,
      String phoneNumber,
      AppointmentState appointmentState,
      AppointmentLocation appointmentLocation,
      String additionalInfo,
      String doctorId,
      Duration timeLeft});
}

/// @nodoc
class _$AppointmentCopyWithImpl<$Res, $Val extends Appointment>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? day = null,
    Object? time = null,
    Object? forAnotherPatient = null,
    Object? didLeaveReview = null,
    Object? didLeaveCancellationReason = null,
    Object? phoneNumber = null,
    Object? appointmentState = null,
    Object? appointmentLocation = null,
    Object? additionalInfo = null,
    Object? doctorId = null,
    Object? timeLeft = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      forAnotherPatient: null == forAnotherPatient
          ? _value.forAnotherPatient
          : forAnotherPatient // ignore: cast_nullable_to_non_nullable
              as bool,
      didLeaveReview: null == didLeaveReview
          ? _value.didLeaveReview
          : didLeaveReview // ignore: cast_nullable_to_non_nullable
              as bool,
      didLeaveCancellationReason: null == didLeaveCancellationReason
          ? _value.didLeaveCancellationReason
          : didLeaveCancellationReason // ignore: cast_nullable_to_non_nullable
              as bool,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentState: null == appointmentState
          ? _value.appointmentState
          : appointmentState // ignore: cast_nullable_to_non_nullable
              as AppointmentState,
      appointmentLocation: null == appointmentLocation
          ? _value.appointmentLocation
          : appointmentLocation // ignore: cast_nullable_to_non_nullable
              as AppointmentLocation,
      additionalInfo: null == additionalInfo
          ? _value.additionalInfo
          : additionalInfo // ignore: cast_nullable_to_non_nullable
              as String,
      doctorId: null == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String,
      timeLeft: null == timeLeft
          ? _value.timeLeft
          : timeLeft // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppointmentCopyWith<$Res>
    implements $AppointmentCopyWith<$Res> {
  factory _$$_AppointmentCopyWith(
          _$_Appointment value, $Res Function(_$_Appointment) then) =
      __$$_AppointmentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String day,
      String time,
      bool forAnotherPatient,
      bool didLeaveReview,
      bool didLeaveCancellationReason,
      String phoneNumber,
      AppointmentState appointmentState,
      AppointmentLocation appointmentLocation,
      String additionalInfo,
      String doctorId,
      Duration timeLeft});
}

/// @nodoc
class __$$_AppointmentCopyWithImpl<$Res>
    extends _$AppointmentCopyWithImpl<$Res, _$_Appointment>
    implements _$$_AppointmentCopyWith<$Res> {
  __$$_AppointmentCopyWithImpl(
      _$_Appointment _value, $Res Function(_$_Appointment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? day = null,
    Object? time = null,
    Object? forAnotherPatient = null,
    Object? didLeaveReview = null,
    Object? didLeaveCancellationReason = null,
    Object? phoneNumber = null,
    Object? appointmentState = null,
    Object? appointmentLocation = null,
    Object? additionalInfo = null,
    Object? doctorId = null,
    Object? timeLeft = null,
  }) {
    return _then(_$_Appointment(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      forAnotherPatient: null == forAnotherPatient
          ? _value.forAnotherPatient
          : forAnotherPatient // ignore: cast_nullable_to_non_nullable
              as bool,
      didLeaveReview: null == didLeaveReview
          ? _value.didLeaveReview
          : didLeaveReview // ignore: cast_nullable_to_non_nullable
              as bool,
      didLeaveCancellationReason: null == didLeaveCancellationReason
          ? _value.didLeaveCancellationReason
          : didLeaveCancellationReason // ignore: cast_nullable_to_non_nullable
              as bool,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentState: null == appointmentState
          ? _value.appointmentState
          : appointmentState // ignore: cast_nullable_to_non_nullable
              as AppointmentState,
      appointmentLocation: null == appointmentLocation
          ? _value.appointmentLocation
          : appointmentLocation // ignore: cast_nullable_to_non_nullable
              as AppointmentLocation,
      additionalInfo: null == additionalInfo
          ? _value.additionalInfo
          : additionalInfo // ignore: cast_nullable_to_non_nullable
              as String,
      doctorId: null == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String,
      timeLeft: null == timeLeft
          ? _value.timeLeft
          : timeLeft // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Appointment implements _Appointment {
  const _$_Appointment(
      {required this.id,
      required this.day,
      required this.time,
      required this.forAnotherPatient,
      required this.didLeaveReview,
      required this.didLeaveCancellationReason,
      required this.phoneNumber,
      required this.appointmentState,
      required this.appointmentLocation,
      required this.additionalInfo,
      required this.doctorId,
      required this.timeLeft});

  factory _$_Appointment.fromJson(Map<String, dynamic> json) =>
      _$$_AppointmentFromJson(json);

  @override
  final String id;
  @override
  final String day;
  @override
  final String time;
  @override
  final bool forAnotherPatient;
  @override
  final bool didLeaveReview;
  @override
  final bool didLeaveCancellationReason;
  @override
  final String phoneNumber;
  @override
  final AppointmentState appointmentState;
  @override
  final AppointmentLocation appointmentLocation;
  @override
  final String additionalInfo;
  @override
  final String doctorId;
  @override
  final Duration timeLeft;

  @override
  String toString() {
    return 'Appointment(id: $id, day: $day, time: $time, forAnotherPatient: $forAnotherPatient, didLeaveReview: $didLeaveReview, didLeaveCancellationReason: $didLeaveCancellationReason, phoneNumber: $phoneNumber, appointmentState: $appointmentState, appointmentLocation: $appointmentLocation, additionalInfo: $additionalInfo, doctorId: $doctorId, timeLeft: $timeLeft)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Appointment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.forAnotherPatient, forAnotherPatient) ||
                other.forAnotherPatient == forAnotherPatient) &&
            (identical(other.didLeaveReview, didLeaveReview) ||
                other.didLeaveReview == didLeaveReview) &&
            (identical(other.didLeaveCancellationReason,
                    didLeaveCancellationReason) ||
                other.didLeaveCancellationReason ==
                    didLeaveCancellationReason) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.appointmentState, appointmentState) ||
                other.appointmentState == appointmentState) &&
            (identical(other.appointmentLocation, appointmentLocation) ||
                other.appointmentLocation == appointmentLocation) &&
            (identical(other.additionalInfo, additionalInfo) ||
                other.additionalInfo == additionalInfo) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.timeLeft, timeLeft) ||
                other.timeLeft == timeLeft));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      day,
      time,
      forAnotherPatient,
      didLeaveReview,
      didLeaveCancellationReason,
      phoneNumber,
      appointmentState,
      appointmentLocation,
      additionalInfo,
      doctorId,
      timeLeft);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppointmentCopyWith<_$_Appointment> get copyWith =>
      __$$_AppointmentCopyWithImpl<_$_Appointment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppointmentToJson(
      this,
    );
  }
}

abstract class _Appointment implements Appointment {
  const factory _Appointment(
      {required final String id,
      required final String day,
      required final String time,
      required final bool forAnotherPatient,
      required final bool didLeaveReview,
      required final bool didLeaveCancellationReason,
      required final String phoneNumber,
      required final AppointmentState appointmentState,
      required final AppointmentLocation appointmentLocation,
      required final String additionalInfo,
      required final String doctorId,
      required final Duration timeLeft}) = _$_Appointment;

  factory _Appointment.fromJson(Map<String, dynamic> json) =
      _$_Appointment.fromJson;

  @override
  String get id;
  @override
  String get day;
  @override
  String get time;
  @override
  bool get forAnotherPatient;
  @override
  bool get didLeaveReview;
  @override
  bool get didLeaveCancellationReason;
  @override
  String get phoneNumber;
  @override
  AppointmentState get appointmentState;
  @override
  AppointmentLocation get appointmentLocation;
  @override
  String get additionalInfo;
  @override
  String get doctorId;
  @override
  Duration get timeLeft;
  @override
  @JsonKey(ignore: true)
  _$$_AppointmentCopyWith<_$_Appointment> get copyWith =>
      throw _privateConstructorUsedError;
}
