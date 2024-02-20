import 'package:json_annotation/json_annotation.dart';

part 'reverse_geocode_vo.g.dart';

// 네이버 지오코드 API 응답 데이터 클래스

@JsonSerializable(explicitToJson: true)
class ReverseGeocodeResponse{
  List<ReverseGeocodeVO> results;

  ReverseGeocodeResponse(this.results);

  factory ReverseGeocodeResponse.fromJson(Map<String, dynamic> json) => _$ReverseGeocodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReverseGeocodeResponseToJson(this);

}

@JsonSerializable()
class ReverseGeocodeVO{
  String name;
  ReverseGeocodeRegion region;
  ReverseGeocodeLand land;

  ReverseGeocodeVO(this.name, this.region, this.land);

  factory ReverseGeocodeVO.fromJson(Map<String, dynamic> json) => _$ReverseGeocodeVOFromJson(json);

  Map<String, dynamic> toJson() => _$ReverseGeocodeVOToJson(this);
}

@JsonSerializable()
class ReverseGeocodeRegion{
  ReverseGeocodeArea area0; // 국가코드
  ReverseGeocodeArea area1; // 시도
  ReverseGeocodeArea area2; // 시군구
  ReverseGeocodeArea area3; // 읍면동
  ReverseGeocodeArea area4; // 리

  ReverseGeocodeRegion(this.area0, this.area1, this.area2, this.area3, this.area4);

  factory ReverseGeocodeRegion.fromJson(Map<String, dynamic> json) => _$ReverseGeocodeRegionFromJson(json);

  Map<String, dynamic> toJson() => _$ReverseGeocodeRegionToJson(this);
}

@JsonSerializable()
class ReverseGeocodeArea{
  String name;
  ReverseGeocodeCoords coords;

  ReverseGeocodeArea(this.name, this.coords);

  factory ReverseGeocodeArea.fromJson(Map<String, dynamic> json) => _$ReverseGeocodeAreaFromJson(json);

  Map<String, dynamic> toJson() => _$ReverseGeocodeAreaToJson(this);
}

@JsonSerializable()
class ReverseGeocodeCoords{
  ReverseGeocodeCenter center;

  ReverseGeocodeCoords(this.center);

  factory ReverseGeocodeCoords.fromJson(Map<String, dynamic> json) => _$ReverseGeocodeCoordsFromJson(json);

  Map<String, dynamic> toJson() => _$ReverseGeocodeCoordsToJson(this);
}

@JsonSerializable()
class ReverseGeocodeCenter{
  String crs;
  double x;
  double y;

  ReverseGeocodeCenter(this.crs, this.x, this.y);

  factory ReverseGeocodeCenter.fromJson(Map<String, dynamic> json) => _$ReverseGeocodeCenterFromJson(json);

  Map<String, dynamic> toJson() => _$ReverseGeocodeCenterToJson(this);
}

@JsonSerializable()
class ReverseGeocodeLand{
  String? type; // 지번 주소인 경우 null, 도로명주소의 경우 도로명
  String? name; // 지번 주소인 경우 지적 타입, 도로명주소의 경우 null
  String number1; // 지번 주소일 경우 토지 본번호, 도로명 주소일 경우 도로명 상세주소
  String? number2; // 지번 주소일 경우 토지 부번호, 도로명 주소일 경우 null

  ReverseGeocodeLand(this.type, this.name, this.number1, this.number2);

  factory ReverseGeocodeLand.fromJson(Map<String, dynamic> json) => _$ReverseGeocodeLandFromJson(json);

  Map<String, dynamic> toJson() => _$ReverseGeocodeLandToJson(this);
}