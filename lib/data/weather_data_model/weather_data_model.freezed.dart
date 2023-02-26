// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WeatherDataModel _$WeatherDataModelFromJson(Map<String, dynamic> json) {
  return _WeatherDataModel.fromJson(json);
}

/// @nodoc
mixin _$WeatherDataModel {
  Location? get location => throw _privateConstructorUsedError;
  Current? get current => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherDataModelCopyWith<WeatherDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherDataModelCopyWith<$Res> {
  factory $WeatherDataModelCopyWith(
          WeatherDataModel value, $Res Function(WeatherDataModel) then) =
      _$WeatherDataModelCopyWithImpl<$Res, WeatherDataModel>;
  @useResult
  $Res call({Location? location, Current? current});

  $LocationCopyWith<$Res>? get location;
  $CurrentCopyWith<$Res>? get current;
}

/// @nodoc
class _$WeatherDataModelCopyWithImpl<$Res, $Val extends WeatherDataModel>
    implements $WeatherDataModelCopyWith<$Res> {
  _$WeatherDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
    Object? current = freezed,
  }) {
    return _then(_value.copyWith(
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location?,
      current: freezed == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as Current?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrentCopyWith<$Res>? get current {
    if (_value.current == null) {
      return null;
    }

    return $CurrentCopyWith<$Res>(_value.current!, (value) {
      return _then(_value.copyWith(current: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WeatherDataModelCopyWith<$Res>
    implements $WeatherDataModelCopyWith<$Res> {
  factory _$$_WeatherDataModelCopyWith(
          _$_WeatherDataModel value, $Res Function(_$_WeatherDataModel) then) =
      __$$_WeatherDataModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Location? location, Current? current});

  @override
  $LocationCopyWith<$Res>? get location;
  @override
  $CurrentCopyWith<$Res>? get current;
}

/// @nodoc
class __$$_WeatherDataModelCopyWithImpl<$Res>
    extends _$WeatherDataModelCopyWithImpl<$Res, _$_WeatherDataModel>
    implements _$$_WeatherDataModelCopyWith<$Res> {
  __$$_WeatherDataModelCopyWithImpl(
      _$_WeatherDataModel _value, $Res Function(_$_WeatherDataModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
    Object? current = freezed,
  }) {
    return _then(_$_WeatherDataModel(
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location?,
      current: freezed == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as Current?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WeatherDataModel implements _WeatherDataModel {
  _$_WeatherDataModel({this.location, this.current});

  factory _$_WeatherDataModel.fromJson(Map<String, dynamic> json) =>
      _$$_WeatherDataModelFromJson(json);

  @override
  final Location? location;
  @override
  final Current? current;

  @override
  String toString() {
    return 'WeatherDataModel(location: $location, current: $current)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WeatherDataModel &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.current, current) || other.current == current));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, location, current);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WeatherDataModelCopyWith<_$_WeatherDataModel> get copyWith =>
      __$$_WeatherDataModelCopyWithImpl<_$_WeatherDataModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WeatherDataModelToJson(
      this,
    );
  }
}

abstract class _WeatherDataModel implements WeatherDataModel {
  factory _WeatherDataModel(
      {final Location? location, final Current? current}) = _$_WeatherDataModel;

  factory _WeatherDataModel.fromJson(Map<String, dynamic> json) =
      _$_WeatherDataModel.fromJson;

  @override
  Location? get location;
  @override
  Current? get current;
  @override
  @JsonKey(ignore: true)
  _$$_WeatherDataModelCopyWith<_$_WeatherDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}
