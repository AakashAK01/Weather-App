// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
mixin _$Location {
  String? get name => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  double? get lat => throw _privateConstructorUsedError;
  double? get lon => throw _privateConstructorUsedError;
  @JsonKey(name: 'tz_id')
  String? get tzId => throw _privateConstructorUsedError;
  @JsonKey(name: 'localtime_epoch')
  int? get localtimeEpoch => throw _privateConstructorUsedError;
  String? get localtime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationCopyWith<Location> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) =
      _$LocationCopyWithImpl<$Res, Location>;
  @useResult
  $Res call(
      {String? name,
      String? region,
      String? country,
      double? lat,
      double? lon,
      @JsonKey(name: 'tz_id') String? tzId,
      @JsonKey(name: 'localtime_epoch') int? localtimeEpoch,
      String? localtime});
}

/// @nodoc
class _$LocationCopyWithImpl<$Res, $Val extends Location>
    implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? region = freezed,
    Object? country = freezed,
    Object? lat = freezed,
    Object? lon = freezed,
    Object? tzId = freezed,
    Object? localtimeEpoch = freezed,
    Object? localtime = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lon: freezed == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double?,
      tzId: freezed == tzId
          ? _value.tzId
          : tzId // ignore: cast_nullable_to_non_nullable
              as String?,
      localtimeEpoch: freezed == localtimeEpoch
          ? _value.localtimeEpoch
          : localtimeEpoch // ignore: cast_nullable_to_non_nullable
              as int?,
      localtime: freezed == localtime
          ? _value.localtime
          : localtime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocationCopyWith<$Res> implements $LocationCopyWith<$Res> {
  factory _$$_LocationCopyWith(
          _$_Location value, $Res Function(_$_Location) then) =
      __$$_LocationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? region,
      String? country,
      double? lat,
      double? lon,
      @JsonKey(name: 'tz_id') String? tzId,
      @JsonKey(name: 'localtime_epoch') int? localtimeEpoch,
      String? localtime});
}

/// @nodoc
class __$$_LocationCopyWithImpl<$Res>
    extends _$LocationCopyWithImpl<$Res, _$_Location>
    implements _$$_LocationCopyWith<$Res> {
  __$$_LocationCopyWithImpl(
      _$_Location _value, $Res Function(_$_Location) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? region = freezed,
    Object? country = freezed,
    Object? lat = freezed,
    Object? lon = freezed,
    Object? tzId = freezed,
    Object? localtimeEpoch = freezed,
    Object? localtime = freezed,
  }) {
    return _then(_$_Location(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lon: freezed == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double?,
      tzId: freezed == tzId
          ? _value.tzId
          : tzId // ignore: cast_nullable_to_non_nullable
              as String?,
      localtimeEpoch: freezed == localtimeEpoch
          ? _value.localtimeEpoch
          : localtimeEpoch // ignore: cast_nullable_to_non_nullable
              as int?,
      localtime: freezed == localtime
          ? _value.localtime
          : localtime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Location implements _Location {
  _$_Location(
      {this.name,
      this.region,
      this.country,
      this.lat,
      this.lon,
      @JsonKey(name: 'tz_id') this.tzId,
      @JsonKey(name: 'localtime_epoch') this.localtimeEpoch,
      this.localtime});

  factory _$_Location.fromJson(Map<String, dynamic> json) =>
      _$$_LocationFromJson(json);

  @override
  final String? name;
  @override
  final String? region;
  @override
  final String? country;
  @override
  final double? lat;
  @override
  final double? lon;
  @override
  @JsonKey(name: 'tz_id')
  final String? tzId;
  @override
  @JsonKey(name: 'localtime_epoch')
  final int? localtimeEpoch;
  @override
  final String? localtime;

  @override
  String toString() {
    return 'Location(name: $name, region: $region, country: $country, lat: $lat, lon: $lon, tzId: $tzId, localtimeEpoch: $localtimeEpoch, localtime: $localtime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Location &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.tzId, tzId) || other.tzId == tzId) &&
            (identical(other.localtimeEpoch, localtimeEpoch) ||
                other.localtimeEpoch == localtimeEpoch) &&
            (identical(other.localtime, localtime) ||
                other.localtime == localtime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, region, country, lat, lon,
      tzId, localtimeEpoch, localtime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocationCopyWith<_$_Location> get copyWith =>
      __$$_LocationCopyWithImpl<_$_Location>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationToJson(
      this,
    );
  }
}

abstract class _Location implements Location {
  factory _Location(
      {final String? name,
      final String? region,
      final String? country,
      final double? lat,
      final double? lon,
      @JsonKey(name: 'tz_id') final String? tzId,
      @JsonKey(name: 'localtime_epoch') final int? localtimeEpoch,
      final String? localtime}) = _$_Location;

  factory _Location.fromJson(Map<String, dynamic> json) = _$_Location.fromJson;

  @override
  String? get name;
  @override
  String? get region;
  @override
  String? get country;
  @override
  double? get lat;
  @override
  double? get lon;
  @override
  @JsonKey(name: 'tz_id')
  String? get tzId;
  @override
  @JsonKey(name: 'localtime_epoch')
  int? get localtimeEpoch;
  @override
  String? get localtime;
  @override
  @JsonKey(ignore: true)
  _$$_LocationCopyWith<_$_Location> get copyWith =>
      throw _privateConstructorUsedError;
}
