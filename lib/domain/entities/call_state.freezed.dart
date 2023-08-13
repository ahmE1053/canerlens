// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CallState _$CallStateFromJson(Map<String, dynamic> json) {
  return _CallState.fromJson(json);
}

/// @nodoc
mixin _$CallState {
  String get token => throw _privateConstructorUsedError;
  String get doctorId => throw _privateConstructorUsedError;
  String get channelName => throw _privateConstructorUsedError;
  String get patientId => throw _privateConstructorUsedError;
  CallStates get callStates => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CallStateCopyWith<CallState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallStateCopyWith<$Res> {
  factory $CallStateCopyWith(CallState value, $Res Function(CallState) then) =
      _$CallStateCopyWithImpl<$Res, CallState>;
  @useResult
  $Res call(
      {String token,
      String doctorId,
      String channelName,
      String patientId,
      CallStates callStates});
}

/// @nodoc
class _$CallStateCopyWithImpl<$Res, $Val extends CallState>
    implements $CallStateCopyWith<$Res> {
  _$CallStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? doctorId = null,
    Object? channelName = null,
    Object? patientId = null,
    Object? callStates = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      doctorId: null == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String,
      channelName: null == channelName
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String,
      patientId: null == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as String,
      callStates: null == callStates
          ? _value.callStates
          : callStates // ignore: cast_nullable_to_non_nullable
              as CallStates,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CallStateCopyWith<$Res> implements $CallStateCopyWith<$Res> {
  factory _$$_CallStateCopyWith(
          _$_CallState value, $Res Function(_$_CallState) then) =
      __$$_CallStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String token,
      String doctorId,
      String channelName,
      String patientId,
      CallStates callStates});
}

/// @nodoc
class __$$_CallStateCopyWithImpl<$Res>
    extends _$CallStateCopyWithImpl<$Res, _$_CallState>
    implements _$$_CallStateCopyWith<$Res> {
  __$$_CallStateCopyWithImpl(
      _$_CallState _value, $Res Function(_$_CallState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? doctorId = null,
    Object? channelName = null,
    Object? patientId = null,
    Object? callStates = null,
  }) {
    return _then(_$_CallState(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      doctorId: null == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String,
      channelName: null == channelName
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String,
      patientId: null == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as String,
      callStates: null == callStates
          ? _value.callStates
          : callStates // ignore: cast_nullable_to_non_nullable
              as CallStates,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CallState implements _CallState {
  const _$_CallState(
      {this.token = '',
      required this.doctorId,
      required this.channelName,
      required this.patientId,
      this.callStates = CallStates.nothing});

  factory _$_CallState.fromJson(Map<String, dynamic> json) =>
      _$$_CallStateFromJson(json);

  @override
  @JsonKey()
  final String token;
  @override
  final String doctorId;
  @override
  final String channelName;
  @override
  final String patientId;
  @override
  @JsonKey()
  final CallStates callStates;

  @override
  String toString() {
    return 'CallState(token: $token, doctorId: $doctorId, channelName: $channelName, patientId: $patientId, callStates: $callStates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallState &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.channelName, channelName) ||
                other.channelName == channelName) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.callStates, callStates) ||
                other.callStates == callStates));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, token, doctorId, channelName, patientId, callStates);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CallStateCopyWith<_$_CallState> get copyWith =>
      __$$_CallStateCopyWithImpl<_$_CallState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CallStateToJson(
      this,
    );
  }
}

abstract class _CallState implements CallState {
  const factory _CallState(
      {final String token,
      required final String doctorId,
      required final String channelName,
      required final String patientId,
      final CallStates callStates}) = _$_CallState;

  factory _CallState.fromJson(Map<String, dynamic> json) =
      _$_CallState.fromJson;

  @override
  String get token;
  @override
  String get doctorId;
  @override
  String get channelName;
  @override
  String get patientId;
  @override
  CallStates get callStates;
  @override
  @JsonKey(ignore: true)
  _$$_CallStateCopyWith<_$_CallState> get copyWith =>
      throw _privateConstructorUsedError;
}
