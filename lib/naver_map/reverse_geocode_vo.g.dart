// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reverse_geocode_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReverseGeocodeResponse _$ReverseGeocodeResponseFromJson(
        Map<String, dynamic> json) =>
    ReverseGeocodeResponse(
      (json['results'] as List<dynamic>)
          .map((e) => ReverseGeocodeVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReverseGeocodeResponseToJson(
        ReverseGeocodeResponse instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
    };

ReverseGeocodeVO _$ReverseGeocodeVOFromJson(Map<String, dynamic> json) =>
    ReverseGeocodeVO(
      json['name'] as String,
      ReverseGeocodeRegion.fromJson(json['region'] as Map<String, dynamic>),
      ReverseGeocodeLand.fromJson(json['land'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReverseGeocodeVOToJson(ReverseGeocodeVO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'region': instance.region,
      'land': instance.land,
    };

ReverseGeocodeRegion _$ReverseGeocodeRegionFromJson(
        Map<String, dynamic> json) =>
    ReverseGeocodeRegion(
      ReverseGeocodeArea.fromJson(json['area0'] as Map<String, dynamic>),
      ReverseGeocodeArea.fromJson(json['area1'] as Map<String, dynamic>),
      ReverseGeocodeArea.fromJson(json['area2'] as Map<String, dynamic>),
      ReverseGeocodeArea.fromJson(json['area3'] as Map<String, dynamic>),
      ReverseGeocodeArea.fromJson(json['area4'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReverseGeocodeRegionToJson(
        ReverseGeocodeRegion instance) =>
    <String, dynamic>{
      'area0': instance.area0,
      'area1': instance.area1,
      'area2': instance.area2,
      'area3': instance.area3,
      'area4': instance.area4,
    };

ReverseGeocodeArea _$ReverseGeocodeAreaFromJson(Map<String, dynamic> json) =>
    ReverseGeocodeArea(
      json['name'] as String,
      ReverseGeocodeCoords.fromJson(json['coords'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReverseGeocodeAreaToJson(ReverseGeocodeArea instance) =>
    <String, dynamic>{
      'name': instance.name,
      'coords': instance.coords,
    };

ReverseGeocodeCoords _$ReverseGeocodeCoordsFromJson(
        Map<String, dynamic> json) =>
    ReverseGeocodeCoords(
      ReverseGeocodeCenter.fromJson(json['center'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReverseGeocodeCoordsToJson(
        ReverseGeocodeCoords instance) =>
    <String, dynamic>{
      'center': instance.center,
    };

ReverseGeocodeCenter _$ReverseGeocodeCenterFromJson(
        Map<String, dynamic> json) =>
    ReverseGeocodeCenter(
      json['crs'] as String,
      (json['x'] as num).toDouble(),
      (json['y'] as num).toDouble(),
    );

Map<String, dynamic> _$ReverseGeocodeCenterToJson(
        ReverseGeocodeCenter instance) =>
    <String, dynamic>{
      'crs': instance.crs,
      'x': instance.x,
      'y': instance.y,
    };

ReverseGeocodeLand _$ReverseGeocodeLandFromJson(Map<String, dynamic> json) =>
    ReverseGeocodeLand(
      json['type'] as String?,
      json['name'] as String?,
      json['number1'] as String,
      json['number2'] as String?,
    );

Map<String, dynamic> _$ReverseGeocodeLandToJson(ReverseGeocodeLand instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'number1': instance.number1,
      'number2': instance.number2,
    };
