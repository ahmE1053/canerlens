// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Doctor _$DoctorFromJson(Map<String, dynamic> json) {
  return _Doctor.fromJson(json);
}

/// @nodoc
mixin _$Doctor {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get speciality => throw _privateConstructorUsedError;
  String get aboutDoctor => throw _privateConstructorUsedError;
  CallState? get callState => throw _privateConstructorUsedError;
  String get fcmToken => throw _privateConstructorUsedError;
  DateTime get joinedOn => throw _privateConstructorUsedError;
  List<Review> get reviews => throw _privateConstructorUsedError;
  List<ChatInfo> get chatList => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  ClinicLocation get location => throw _privateConstructorUsedError;
  DoctorAvailability get availableOn => throw _privateConstructorUsedError;
  DoctorState get doctorState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DoctorCopyWith<Doctor> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorCopyWith<$Res> {
  factory $DoctorCopyWith(Doctor value, $Res Function(Doctor) then) =
      _$DoctorCopyWithImpl<$Res, Doctor>;
  @useResult
  $Res call(
      {String id,
      String name,
      String imageUrl,
      String speciality,
      String aboutDoctor,
      CallState? callState,
      String fcmToken,
      DateTime joinedOn,
      List<Review> reviews,
      List<ChatInfo> chatList,
      double rating,
      ClinicLocation location,
      DoctorAvailability availableOn,
      DoctorState doctorState});

  $CallStateCopyWith<$Res>? get callState;
  $ClinicLocationCopyWith<$Res> get location;
  $DoctorAvailabilityCopyWith<$Res> get availableOn;
}

/// @nodoc
class _$DoctorCopyWithImpl<$Res, $Val extends Doctor>
    implements $DoctorCopyWith<$Res> {
  _$DoctorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? speciality = null,
    Object? aboutDoctor = null,
    Object? callState = freezed,
    Object? fcmToken = null,
    Object? joinedOn = null,
    Object? reviews = null,
    Object? chatList = null,
    Object? rating = null,
    Object? location = null,
    Object? availableOn = null,
    Object? doctorState = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      speciality: null == speciality
          ? _value.speciality
          : speciality // ignore: cast_nullable_to_non_nullable
              as String,
      aboutDoctor: null == aboutDoctor
          ? _value.aboutDoctor
          : aboutDoctor // ignore: cast_nullable_to_non_nullable
              as String,
      callState: freezed == callState
          ? _value.callState
          : callState // ignore: cast_nullable_to_non_nullable
              as CallState?,
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      joinedOn: null == joinedOn
          ? _value.joinedOn
          : joinedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reviews: null == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<Review>,
      chatList: null == chatList
          ? _value.chatList
          : chatList // ignore: cast_nullable_to_non_nullable
              as List<ChatInfo>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as ClinicLocation,
      availableOn: null == availableOn
          ? _value.availableOn
          : availableOn // ignore: cast_nullable_to_non_nullable
              as DoctorAvailability,
      doctorState: null == doctorState
          ? _value.doctorState
          : doctorState // ignore: cast_nullable_to_non_nullable
              as DoctorState,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CallStateCopyWith<$Res>? get callState {
    if (_value.callState == null) {
      return null;
    }

    return $CallStateCopyWith<$Res>(_value.callState!, (value) {
      return _then(_value.copyWith(callState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClinicLocationCopyWith<$Res> get location {
    return $ClinicLocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DoctorAvailabilityCopyWith<$Res> get availableOn {
    return $DoctorAvailabilityCopyWith<$Res>(_value.availableOn, (value) {
      return _then(_value.copyWith(availableOn: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DoctorCopyWith<$Res> implements $DoctorCopyWith<$Res> {
  factory _$$_DoctorCopyWith(_$_Doctor value, $Res Function(_$_Doctor) then) =
      __$$_DoctorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String imageUrl,
      String speciality,
      String aboutDoctor,
      CallState? callState,
      String fcmToken,
      DateTime joinedOn,
      List<Review> reviews,
      List<ChatInfo> chatList,
      double rating,
      ClinicLocation location,
      DoctorAvailability availableOn,
      DoctorState doctorState});

  @override
  $CallStateCopyWith<$Res>? get callState;
  @override
  $ClinicLocationCopyWith<$Res> get location;
  @override
  $DoctorAvailabilityCopyWith<$Res> get availableOn;
}

/// @nodoc
class __$$_DoctorCopyWithImpl<$Res>
    extends _$DoctorCopyWithImpl<$Res, _$_Doctor>
    implements _$$_DoctorCopyWith<$Res> {
  __$$_DoctorCopyWithImpl(_$_Doctor _value, $Res Function(_$_Doctor) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? speciality = null,
    Object? aboutDoctor = null,
    Object? callState = freezed,
    Object? fcmToken = null,
    Object? joinedOn = null,
    Object? reviews = null,
    Object? chatList = null,
    Object? rating = null,
    Object? location = null,
    Object? availableOn = null,
    Object? doctorState = null,
  }) {
    return _then(_$_Doctor(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      speciality: null == speciality
          ? _value.speciality
          : speciality // ignore: cast_nullable_to_non_nullable
              as String,
      aboutDoctor: null == aboutDoctor
          ? _value.aboutDoctor
          : aboutDoctor // ignore: cast_nullable_to_non_nullable
              as String,
      callState: freezed == callState
          ? _value.callState
          : callState // ignore: cast_nullable_to_non_nullable
              as CallState?,
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      joinedOn: null == joinedOn
          ? _value.joinedOn
          : joinedOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reviews: null == reviews
          ? _value._reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<Review>,
      chatList: null == chatList
          ? _value._chatList
          : chatList // ignore: cast_nullable_to_non_nullable
              as List<ChatInfo>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as ClinicLocation,
      availableOn: null == availableOn
          ? _value.availableOn
          : availableOn // ignore: cast_nullable_to_non_nullable
              as DoctorAvailability,
      doctorState: null == doctorState
          ? _value.doctorState
          : doctorState // ignore: cast_nullable_to_non_nullable
              as DoctorState,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Doctor extends _Doctor {
  const _$_Doctor(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.speciality,
      required this.aboutDoctor,
      this.callState,
      this.fcmToken = '',
      required this.joinedOn,
      required final List<Review> reviews,
      final List<ChatInfo> chatList = const [],
      required this.rating,
      required this.location,
      required this.availableOn,
      required this.doctorState})
      : _reviews = reviews,
        _chatList = chatList,
        super._();

  factory _$_Doctor.fromJson(Map<String, dynamic> json) =>
      _$$_DoctorFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String imageUrl;
  @override
  final String speciality;
  @override
  final String aboutDoctor;
  @override
  final CallState? callState;
  @override
  @JsonKey()
  final String fcmToken;
  @override
  final DateTime joinedOn;
  final List<Review> _reviews;
  @override
  List<Review> get reviews {
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

  final List<ChatInfo> _chatList;
  @override
  @JsonKey()
  List<ChatInfo> get chatList {
    if (_chatList is EqualUnmodifiableListView) return _chatList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatList);
  }

  @override
  final double rating;
  @override
  final ClinicLocation location;
  @override
  final DoctorAvailability availableOn;
  @override
  final DoctorState doctorState;

  @override
  String toString() {
    return 'Doctor(id: $id, name: $name, imageUrl: $imageUrl, speciality: $speciality, aboutDoctor: $aboutDoctor, callState: $callState, fcmToken: $fcmToken, joinedOn: $joinedOn, reviews: $reviews, chatList: $chatList, rating: $rating, location: $location, availableOn: $availableOn, doctorState: $doctorState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Doctor &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.speciality, speciality) ||
                other.speciality == speciality) &&
            (identical(other.aboutDoctor, aboutDoctor) ||
                other.aboutDoctor == aboutDoctor) &&
            (identical(other.callState, callState) ||
                other.callState == callState) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.joinedOn, joinedOn) ||
                other.joinedOn == joinedOn) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews) &&
            const DeepCollectionEquality().equals(other._chatList, _chatList) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.availableOn, availableOn) ||
                other.availableOn == availableOn) &&
            (identical(other.doctorState, doctorState) ||
                other.doctorState == doctorState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      imageUrl,
      speciality,
      aboutDoctor,
      callState,
      fcmToken,
      joinedOn,
      const DeepCollectionEquality().hash(_reviews),
      const DeepCollectionEquality().hash(_chatList),
      rating,
      location,
      availableOn,
      doctorState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DoctorCopyWith<_$_Doctor> get copyWith =>
      __$$_DoctorCopyWithImpl<_$_Doctor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DoctorToJson(
      this,
    );
  }
}

abstract class _Doctor extends Doctor {
  const factory _Doctor(
      {required final String id,
      required final String name,
      required final String imageUrl,
      required final String speciality,
      required final String aboutDoctor,
      final CallState? callState,
      final String fcmToken,
      required final DateTime joinedOn,
      required final List<Review> reviews,
      final List<ChatInfo> chatList,
      required final double rating,
      required final ClinicLocation location,
      required final DoctorAvailability availableOn,
      required final DoctorState doctorState}) = _$_Doctor;
  const _Doctor._() : super._();

  factory _Doctor.fromJson(Map<String, dynamic> json) = _$_Doctor.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get imageUrl;
  @override
  String get speciality;
  @override
  String get aboutDoctor;
  @override
  CallState? get callState;
  @override
  String get fcmToken;
  @override
  DateTime get joinedOn;
  @override
  List<Review> get reviews;
  @override
  List<ChatInfo> get chatList;
  @override
  double get rating;
  @override
  ClinicLocation get location;
  @override
  DoctorAvailability get availableOn;
  @override
  DoctorState get doctorState;
  @override
  @JsonKey(ignore: true)
  _$$_DoctorCopyWith<_$_Doctor> get copyWith =>
      throw _privateConstructorUsedError;
}

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return _Review.fromJson(json);
}

/// @nodoc
mixin _$Review {
  double get rating => throw _privateConstructorUsedError;
  String get review => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewCopyWith<Review> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) then) =
      _$ReviewCopyWithImpl<$Res, Review>;
  @useResult
  $Res call({double rating, String review});
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res, $Val extends Review>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
    Object? review = null,
  }) {
    return _then(_value.copyWith(
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      review: null == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReviewCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$$_ReviewCopyWith(_$_Review value, $Res Function(_$_Review) then) =
      __$$_ReviewCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double rating, String review});
}

/// @nodoc
class __$$_ReviewCopyWithImpl<$Res>
    extends _$ReviewCopyWithImpl<$Res, _$_Review>
    implements _$$_ReviewCopyWith<$Res> {
  __$$_ReviewCopyWithImpl(_$_Review _value, $Res Function(_$_Review) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
    Object? review = null,
  }) {
    return _then(_$_Review(
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      review: null == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Review implements _Review {
  const _$_Review({required this.rating, required this.review});

  factory _$_Review.fromJson(Map<String, dynamic> json) =>
      _$$_ReviewFromJson(json);

  @override
  final double rating;
  @override
  final String review;

  @override
  String toString() {
    return 'Review(rating: $rating, review: $review)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Review &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.review, review) || other.review == review));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, rating, review);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReviewCopyWith<_$_Review> get copyWith =>
      __$$_ReviewCopyWithImpl<_$_Review>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReviewToJson(
      this,
    );
  }
}

abstract class _Review implements Review {
  const factory _Review(
      {required final double rating, required final String review}) = _$_Review;

  factory _Review.fromJson(Map<String, dynamic> json) = _$_Review.fromJson;

  @override
  double get rating;
  @override
  String get review;
  @override
  @JsonKey(ignore: true)
  _$$_ReviewCopyWith<_$_Review> get copyWith =>
      throw _privateConstructorUsedError;
}

DoctorAvailability _$DoctorAvailabilityFromJson(Map<String, dynamic> json) {
  return _DoctorAvailability.fromJson(json);
}

/// @nodoc
mixin _$DoctorAvailability {
  bool get online => throw _privateConstructorUsedError;
  bool get offline => throw _privateConstructorUsedError;
  List<OnlineAvailability>? get onlineAvailability =>
      throw _privateConstructorUsedError;
  List<OfflineAvailability>? get offlineAvailability =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DoctorAvailabilityCopyWith<DoctorAvailability> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorAvailabilityCopyWith<$Res> {
  factory $DoctorAvailabilityCopyWith(
          DoctorAvailability value, $Res Function(DoctorAvailability) then) =
      _$DoctorAvailabilityCopyWithImpl<$Res, DoctorAvailability>;
  @useResult
  $Res call(
      {bool online,
      bool offline,
      List<OnlineAvailability>? onlineAvailability,
      List<OfflineAvailability>? offlineAvailability});
}

/// @nodoc
class _$DoctorAvailabilityCopyWithImpl<$Res, $Val extends DoctorAvailability>
    implements $DoctorAvailabilityCopyWith<$Res> {
  _$DoctorAvailabilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? online = null,
    Object? offline = null,
    Object? onlineAvailability = freezed,
    Object? offlineAvailability = freezed,
  }) {
    return _then(_value.copyWith(
      online: null == online
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      offline: null == offline
          ? _value.offline
          : offline // ignore: cast_nullable_to_non_nullable
              as bool,
      onlineAvailability: freezed == onlineAvailability
          ? _value.onlineAvailability
          : onlineAvailability // ignore: cast_nullable_to_non_nullable
              as List<OnlineAvailability>?,
      offlineAvailability: freezed == offlineAvailability
          ? _value.offlineAvailability
          : offlineAvailability // ignore: cast_nullable_to_non_nullable
              as List<OfflineAvailability>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DoctorAvailabilityCopyWith<$Res>
    implements $DoctorAvailabilityCopyWith<$Res> {
  factory _$$_DoctorAvailabilityCopyWith(_$_DoctorAvailability value,
          $Res Function(_$_DoctorAvailability) then) =
      __$$_DoctorAvailabilityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool online,
      bool offline,
      List<OnlineAvailability>? onlineAvailability,
      List<OfflineAvailability>? offlineAvailability});
}

/// @nodoc
class __$$_DoctorAvailabilityCopyWithImpl<$Res>
    extends _$DoctorAvailabilityCopyWithImpl<$Res, _$_DoctorAvailability>
    implements _$$_DoctorAvailabilityCopyWith<$Res> {
  __$$_DoctorAvailabilityCopyWithImpl(
      _$_DoctorAvailability _value, $Res Function(_$_DoctorAvailability) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? online = null,
    Object? offline = null,
    Object? onlineAvailability = freezed,
    Object? offlineAvailability = freezed,
  }) {
    return _then(_$_DoctorAvailability(
      online: null == online
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      offline: null == offline
          ? _value.offline
          : offline // ignore: cast_nullable_to_non_nullable
              as bool,
      onlineAvailability: freezed == onlineAvailability
          ? _value._onlineAvailability
          : onlineAvailability // ignore: cast_nullable_to_non_nullable
              as List<OnlineAvailability>?,
      offlineAvailability: freezed == offlineAvailability
          ? _value._offlineAvailability
          : offlineAvailability // ignore: cast_nullable_to_non_nullable
              as List<OfflineAvailability>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_DoctorAvailability implements _DoctorAvailability {
  const _$_DoctorAvailability(
      {required this.online,
      required this.offline,
      final List<OnlineAvailability>? onlineAvailability,
      final List<OfflineAvailability>? offlineAvailability})
      : _onlineAvailability = onlineAvailability,
        _offlineAvailability = offlineAvailability;

  factory _$_DoctorAvailability.fromJson(Map<String, dynamic> json) =>
      _$$_DoctorAvailabilityFromJson(json);

  @override
  final bool online;
  @override
  final bool offline;
  final List<OnlineAvailability>? _onlineAvailability;
  @override
  List<OnlineAvailability>? get onlineAvailability {
    final value = _onlineAvailability;
    if (value == null) return null;
    if (_onlineAvailability is EqualUnmodifiableListView)
      return _onlineAvailability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<OfflineAvailability>? _offlineAvailability;
  @override
  List<OfflineAvailability>? get offlineAvailability {
    final value = _offlineAvailability;
    if (value == null) return null;
    if (_offlineAvailability is EqualUnmodifiableListView)
      return _offlineAvailability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DoctorAvailability(online: $online, offline: $offline, onlineAvailability: $onlineAvailability, offlineAvailability: $offlineAvailability)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DoctorAvailability &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.offline, offline) || other.offline == offline) &&
            const DeepCollectionEquality()
                .equals(other._onlineAvailability, _onlineAvailability) &&
            const DeepCollectionEquality()
                .equals(other._offlineAvailability, _offlineAvailability));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      online,
      offline,
      const DeepCollectionEquality().hash(_onlineAvailability),
      const DeepCollectionEquality().hash(_offlineAvailability));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DoctorAvailabilityCopyWith<_$_DoctorAvailability> get copyWith =>
      __$$_DoctorAvailabilityCopyWithImpl<_$_DoctorAvailability>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DoctorAvailabilityToJson(
      this,
    );
  }
}

abstract class _DoctorAvailability implements DoctorAvailability {
  const factory _DoctorAvailability(
          {required final bool online,
          required final bool offline,
          final List<OnlineAvailability>? onlineAvailability,
          final List<OfflineAvailability>? offlineAvailability}) =
      _$_DoctorAvailability;

  factory _DoctorAvailability.fromJson(Map<String, dynamic> json) =
      _$_DoctorAvailability.fromJson;

  @override
  bool get online;
  @override
  bool get offline;
  @override
  List<OnlineAvailability>? get onlineAvailability;
  @override
  List<OfflineAvailability>? get offlineAvailability;
  @override
  @JsonKey(ignore: true)
  _$$_DoctorAvailabilityCopyWith<_$_DoctorAvailability> get copyWith =>
      throw _privateConstructorUsedError;
}

OnlineAvailability _$OnlineAvailabilityFromJson(Map<String, dynamic> json) {
  return _OnlineAvailability.fromJson(json);
}

/// @nodoc
mixin _$OnlineAvailability {
  DateTime get day => throw _privateConstructorUsedError;
  List<TimeInDayOnline> get timesAvailable =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlineAvailabilityCopyWith<OnlineAvailability> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlineAvailabilityCopyWith<$Res> {
  factory $OnlineAvailabilityCopyWith(
          OnlineAvailability value, $Res Function(OnlineAvailability) then) =
      _$OnlineAvailabilityCopyWithImpl<$Res, OnlineAvailability>;
  @useResult
  $Res call({DateTime day, List<TimeInDayOnline> timesAvailable});
}

/// @nodoc
class _$OnlineAvailabilityCopyWithImpl<$Res, $Val extends OnlineAvailability>
    implements $OnlineAvailabilityCopyWith<$Res> {
  _$OnlineAvailabilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? timesAvailable = null,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timesAvailable: null == timesAvailable
          ? _value.timesAvailable
          : timesAvailable // ignore: cast_nullable_to_non_nullable
              as List<TimeInDayOnline>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OnlineAvailabilityCopyWith<$Res>
    implements $OnlineAvailabilityCopyWith<$Res> {
  factory _$$_OnlineAvailabilityCopyWith(_$_OnlineAvailability value,
          $Res Function(_$_OnlineAvailability) then) =
      __$$_OnlineAvailabilityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime day, List<TimeInDayOnline> timesAvailable});
}

/// @nodoc
class __$$_OnlineAvailabilityCopyWithImpl<$Res>
    extends _$OnlineAvailabilityCopyWithImpl<$Res, _$_OnlineAvailability>
    implements _$$_OnlineAvailabilityCopyWith<$Res> {
  __$$_OnlineAvailabilityCopyWithImpl(
      _$_OnlineAvailability _value, $Res Function(_$_OnlineAvailability) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? timesAvailable = null,
  }) {
    return _then(_$_OnlineAvailability(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timesAvailable: null == timesAvailable
          ? _value._timesAvailable
          : timesAvailable // ignore: cast_nullable_to_non_nullable
              as List<TimeInDayOnline>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_OnlineAvailability implements _OnlineAvailability {
  const _$_OnlineAvailability(
      {required this.day, required final List<TimeInDayOnline> timesAvailable})
      : _timesAvailable = timesAvailable;

  factory _$_OnlineAvailability.fromJson(Map<String, dynamic> json) =>
      _$$_OnlineAvailabilityFromJson(json);

  @override
  final DateTime day;
  final List<TimeInDayOnline> _timesAvailable;
  @override
  List<TimeInDayOnline> get timesAvailable {
    if (_timesAvailable is EqualUnmodifiableListView) return _timesAvailable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timesAvailable);
  }

  @override
  String toString() {
    return 'OnlineAvailability(day: $day, timesAvailable: $timesAvailable)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OnlineAvailability &&
            (identical(other.day, day) || other.day == day) &&
            const DeepCollectionEquality()
                .equals(other._timesAvailable, _timesAvailable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, day, const DeepCollectionEquality().hash(_timesAvailable));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OnlineAvailabilityCopyWith<_$_OnlineAvailability> get copyWith =>
      __$$_OnlineAvailabilityCopyWithImpl<_$_OnlineAvailability>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OnlineAvailabilityToJson(
      this,
    );
  }
}

abstract class _OnlineAvailability implements OnlineAvailability {
  const factory _OnlineAvailability(
          {required final DateTime day,
          required final List<TimeInDayOnline> timesAvailable}) =
      _$_OnlineAvailability;

  factory _OnlineAvailability.fromJson(Map<String, dynamic> json) =
      _$_OnlineAvailability.fromJson;

  @override
  DateTime get day;
  @override
  List<TimeInDayOnline> get timesAvailable;
  @override
  @JsonKey(ignore: true)
  _$$_OnlineAvailabilityCopyWith<_$_OnlineAvailability> get copyWith =>
      throw _privateConstructorUsedError;
}

TimeInDayOnline _$TimeInDayOnlineFromJson(Map<String, dynamic> json) {
  return _TimeInDayOnline.fromJson(json);
}

/// @nodoc
mixin _$TimeInDayOnline {
  String get timeOfDay => throw _privateConstructorUsedError;
  bool get available => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeInDayOnlineCopyWith<TimeInDayOnline> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeInDayOnlineCopyWith<$Res> {
  factory $TimeInDayOnlineCopyWith(
          TimeInDayOnline value, $Res Function(TimeInDayOnline) then) =
      _$TimeInDayOnlineCopyWithImpl<$Res, TimeInDayOnline>;
  @useResult
  $Res call({String timeOfDay, bool available});
}

/// @nodoc
class _$TimeInDayOnlineCopyWithImpl<$Res, $Val extends TimeInDayOnline>
    implements $TimeInDayOnlineCopyWith<$Res> {
  _$TimeInDayOnlineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeOfDay = null,
    Object? available = null,
  }) {
    return _then(_value.copyWith(
      timeOfDay: null == timeOfDay
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as String,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TimeInDayOnlineCopyWith<$Res>
    implements $TimeInDayOnlineCopyWith<$Res> {
  factory _$$_TimeInDayOnlineCopyWith(
          _$_TimeInDayOnline value, $Res Function(_$_TimeInDayOnline) then) =
      __$$_TimeInDayOnlineCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String timeOfDay, bool available});
}

/// @nodoc
class __$$_TimeInDayOnlineCopyWithImpl<$Res>
    extends _$TimeInDayOnlineCopyWithImpl<$Res, _$_TimeInDayOnline>
    implements _$$_TimeInDayOnlineCopyWith<$Res> {
  __$$_TimeInDayOnlineCopyWithImpl(
      _$_TimeInDayOnline _value, $Res Function(_$_TimeInDayOnline) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeOfDay = null,
    Object? available = null,
  }) {
    return _then(_$_TimeInDayOnline(
      timeOfDay: null == timeOfDay
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as String,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TimeInDayOnline implements _TimeInDayOnline {
  const _$_TimeInDayOnline({required this.timeOfDay, required this.available});

  factory _$_TimeInDayOnline.fromJson(Map<String, dynamic> json) =>
      _$$_TimeInDayOnlineFromJson(json);

  @override
  final String timeOfDay;
  @override
  final bool available;

  @override
  String toString() {
    return 'TimeInDayOnline(timeOfDay: $timeOfDay, available: $available)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimeInDayOnline &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            (identical(other.available, available) ||
                other.available == available));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, timeOfDay, available);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TimeInDayOnlineCopyWith<_$_TimeInDayOnline> get copyWith =>
      __$$_TimeInDayOnlineCopyWithImpl<_$_TimeInDayOnline>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TimeInDayOnlineToJson(
      this,
    );
  }
}

abstract class _TimeInDayOnline implements TimeInDayOnline {
  const factory _TimeInDayOnline(
      {required final String timeOfDay,
      required final bool available}) = _$_TimeInDayOnline;

  factory _TimeInDayOnline.fromJson(Map<String, dynamic> json) =
      _$_TimeInDayOnline.fromJson;

  @override
  String get timeOfDay;
  @override
  bool get available;
  @override
  @JsonKey(ignore: true)
  _$$_TimeInDayOnlineCopyWith<_$_TimeInDayOnline> get copyWith =>
      throw _privateConstructorUsedError;
}

OfflineAvailability _$OfflineAvailabilityFromJson(Map<String, dynamic> json) {
  return _OfflineAvailability.fromJson(json);
}

/// @nodoc
mixin _$OfflineAvailability {
  DateTime get day => throw _privateConstructorUsedError;
  String get timeFrom => throw _privateConstructorUsedError;
  String get timeTo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfflineAvailabilityCopyWith<OfflineAvailability> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfflineAvailabilityCopyWith<$Res> {
  factory $OfflineAvailabilityCopyWith(
          OfflineAvailability value, $Res Function(OfflineAvailability) then) =
      _$OfflineAvailabilityCopyWithImpl<$Res, OfflineAvailability>;
  @useResult
  $Res call({DateTime day, String timeFrom, String timeTo});
}

/// @nodoc
class _$OfflineAvailabilityCopyWithImpl<$Res, $Val extends OfflineAvailability>
    implements $OfflineAvailabilityCopyWith<$Res> {
  _$OfflineAvailabilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? timeFrom = null,
    Object? timeTo = null,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeFrom: null == timeFrom
          ? _value.timeFrom
          : timeFrom // ignore: cast_nullable_to_non_nullable
              as String,
      timeTo: null == timeTo
          ? _value.timeTo
          : timeTo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OfflineAvailabilityCopyWith<$Res>
    implements $OfflineAvailabilityCopyWith<$Res> {
  factory _$$_OfflineAvailabilityCopyWith(_$_OfflineAvailability value,
          $Res Function(_$_OfflineAvailability) then) =
      __$$_OfflineAvailabilityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime day, String timeFrom, String timeTo});
}

/// @nodoc
class __$$_OfflineAvailabilityCopyWithImpl<$Res>
    extends _$OfflineAvailabilityCopyWithImpl<$Res, _$_OfflineAvailability>
    implements _$$_OfflineAvailabilityCopyWith<$Res> {
  __$$_OfflineAvailabilityCopyWithImpl(_$_OfflineAvailability _value,
      $Res Function(_$_OfflineAvailability) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? timeFrom = null,
    Object? timeTo = null,
  }) {
    return _then(_$_OfflineAvailability(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeFrom: null == timeFrom
          ? _value.timeFrom
          : timeFrom // ignore: cast_nullable_to_non_nullable
              as String,
      timeTo: null == timeTo
          ? _value.timeTo
          : timeTo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OfflineAvailability implements _OfflineAvailability {
  const _$_OfflineAvailability(
      {required this.day, required this.timeFrom, required this.timeTo});

  factory _$_OfflineAvailability.fromJson(Map<String, dynamic> json) =>
      _$$_OfflineAvailabilityFromJson(json);

  @override
  final DateTime day;
  @override
  final String timeFrom;
  @override
  final String timeTo;

  @override
  String toString() {
    return 'OfflineAvailability(day: $day, timeFrom: $timeFrom, timeTo: $timeTo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OfflineAvailability &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.timeFrom, timeFrom) ||
                other.timeFrom == timeFrom) &&
            (identical(other.timeTo, timeTo) || other.timeTo == timeTo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, day, timeFrom, timeTo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OfflineAvailabilityCopyWith<_$_OfflineAvailability> get copyWith =>
      __$$_OfflineAvailabilityCopyWithImpl<_$_OfflineAvailability>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OfflineAvailabilityToJson(
      this,
    );
  }
}

abstract class _OfflineAvailability implements OfflineAvailability {
  const factory _OfflineAvailability(
      {required final DateTime day,
      required final String timeFrom,
      required final String timeTo}) = _$_OfflineAvailability;

  factory _OfflineAvailability.fromJson(Map<String, dynamic> json) =
      _$_OfflineAvailability.fromJson;

  @override
  DateTime get day;
  @override
  String get timeFrom;
  @override
  String get timeTo;
  @override
  @JsonKey(ignore: true)
  _$$_OfflineAvailabilityCopyWith<_$_OfflineAvailability> get copyWith =>
      throw _privateConstructorUsedError;
}

ClinicLocation _$ClinicLocationFromJson(Map<String, dynamic> json) {
  return _ClinicLocation.fromJson(json);
}

/// @nodoc
mixin _$ClinicLocation {
  String get location => throw _privateConstructorUsedError;
  List<double> get coordinates => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClinicLocationCopyWith<ClinicLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicLocationCopyWith<$Res> {
  factory $ClinicLocationCopyWith(
          ClinicLocation value, $Res Function(ClinicLocation) then) =
      _$ClinicLocationCopyWithImpl<$Res, ClinicLocation>;
  @useResult
  $Res call({String location, List<double> coordinates});
}

/// @nodoc
class _$ClinicLocationCopyWithImpl<$Res, $Val extends ClinicLocation>
    implements $ClinicLocationCopyWith<$Res> {
  _$ClinicLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? coordinates = null,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClinicLocationCopyWith<$Res>
    implements $ClinicLocationCopyWith<$Res> {
  factory _$$_ClinicLocationCopyWith(
          _$_ClinicLocation value, $Res Function(_$_ClinicLocation) then) =
      __$$_ClinicLocationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String location, List<double> coordinates});
}

/// @nodoc
class __$$_ClinicLocationCopyWithImpl<$Res>
    extends _$ClinicLocationCopyWithImpl<$Res, _$_ClinicLocation>
    implements _$$_ClinicLocationCopyWith<$Res> {
  __$$_ClinicLocationCopyWithImpl(
      _$_ClinicLocation _value, $Res Function(_$_ClinicLocation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? coordinates = null,
  }) {
    return _then(_$_ClinicLocation(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value._coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClinicLocation implements _ClinicLocation {
  const _$_ClinicLocation(
      {required this.location, required final List<double> coordinates})
      : _coordinates = coordinates;

  factory _$_ClinicLocation.fromJson(Map<String, dynamic> json) =>
      _$$_ClinicLocationFromJson(json);

  @override
  final String location;
  final List<double> _coordinates;
  @override
  List<double> get coordinates {
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coordinates);
  }

  @override
  String toString() {
    return 'ClinicLocation(location: $location, coordinates: $coordinates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClinicLocation &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality()
                .equals(other._coordinates, _coordinates));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, location, const DeepCollectionEquality().hash(_coordinates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClinicLocationCopyWith<_$_ClinicLocation> get copyWith =>
      __$$_ClinicLocationCopyWithImpl<_$_ClinicLocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClinicLocationToJson(
      this,
    );
  }
}

abstract class _ClinicLocation implements ClinicLocation {
  const factory _ClinicLocation(
      {required final String location,
      required final List<double> coordinates}) = _$_ClinicLocation;

  factory _ClinicLocation.fromJson(Map<String, dynamic> json) =
      _$_ClinicLocation.fromJson;

  @override
  String get location;
  @override
  List<double> get coordinates;
  @override
  @JsonKey(ignore: true)
  _$$_ClinicLocationCopyWith<_$_ClinicLocation> get copyWith =>
      throw _privateConstructorUsedError;
}
