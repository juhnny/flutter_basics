import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics/naver_map/reverse_geocode_vo.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

// todo 이걸 노출하는 거 괜찮을까?
String clientId = "f977punyhw";

void main() async{
  // 네이버 지도 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
    clientId: clientId,
    onAuthFailed: (ex){
      print("********* 네이버맵 인증오류 : $ex *********");
    }
  );
  runApp(MyMap());
}

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap>{

  late NaverMapController mapController;

  void createMarkers(){
    setState(() {
      // 세개의 오버레이 생성
      final marker1 = NMarker(id: '1', position: NLatLng(37.5664056, 126.9777222));
      final marker2 = NMarker(id: '2', position: NLatLng(37.5664056, 126.9778222));
      marker2.setOnTapListener((marker) {
        print("${marker.caption?.text}");
        print("${marker.subCaption}");
        print("${marker.position.latitude}");
        print("${marker.info.payload}");
        final onMarkerInfoWindow = NInfoWindow.onMarker(id: marker.info.id, text: "인포윈도우 텍스트");
        marker.openInfoWindow(onMarkerInfoWindow);
      });
      final marker3 = NMarker(id: '3', position: NLatLng(37.5664056, 126.9779222));

      final circle = NCircleOverlay(id: '1', center: NLatLng(37.5664056, 126.9778222), radius: 100.0);

      // 지도에 하나씩 추가
      mapController.addOverlay(marker1);
      // 혹은 한번에 추가할 경우 (여러개를 추가할 때에는 이 방법을 사용하는 것을 권장합니다.)
      mapController.addOverlayAll({marker2, marker3, circle}); // Set<NOverlay> 타입을 인자로 받습니다.

      // 특정 id를 가진 지도에서 제거
      // mapController.deleteOverlay(NOverlayInfo(type: NOverlayType.marker, id: '2'));
      // 혹은 특정 종류의 오버레이만 제거
      // mapController.clearOverlays(type: NOverlayType.circleOverlay);
      // 혹은 모든 오버레이 제거
      // mapController.clearOverlays();

    });
  }

  void createMarker(NLatLng latLng){
    setState(() {
      // 세개의 오버레이 생성
      final marker1 = NMarker(id: '1', position: latLng);
      marker1.setOnTapListener((marker) {
        print("${marker.caption?.text}");
        print("${marker.subCaption}");
        print("${marker.position.latitude}");
        print("${marker.info.payload}");

        final onMarkerInfoWindow = NInfoWindow.onMarker(id: marker.info.id, text: "인포윈도우 텍스트");
        marker.openInfoWindow(onMarkerInfoWindow);
      });

      final marker2 = NMarker(id: '2', position: latLng);
      marker2.setIcon(NOverlayImage.fromAssetImage('images/big.jpeg'));

      // 지도에 하나씩 추가
      mapController.addOverlay(marker1);
      mapController.addOverlay(marker2);

      reverseGeocode(latLng);
    });
  }

  // 지오코드 API를 이용해 좌표를 주소로 변환한다.
  Future<void> reverseGeocode(NLatLng latLng) async {
    print('reverseGeocode');
    var dio = Dio(BaseOptions(
      baseUrl: "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/",
      connectTimeout: Duration(seconds: 5),
      sendTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
      headers: {
        "X-NCP-APIGW-API-KEY-ID": 'f977punyhw',
        "X-NCP-APIGW-API-KEY": '5btGyhinl8cfly7pU28SHWOTc3QPpOQmaIGZuhCw',
      },
    ));
    dio.interceptors.add(LogInterceptor(
        logPrint: (object){
          debugPrint(object.toString());
        }
    ));
    var response = await dio.get(
      'gc',
      queryParameters: {
        'request': "coordsToaddr",
        'coords': "${latLng.longitude},${latLng.latitude}",
        'sourcecrs': "epsg:4326",
        'orders': "addr,roadaddr",
        'output': "json",
      }
    );
    String result = response.data.toString();
    print(result);

    if(response.statusCode == 200) {
      ReverseGeocodeResponse reverseGcResponse = ReverseGeocodeResponse.fromJson(response.data);

      for(ReverseGeocodeVO reverseGeocodeVO in reverseGcResponse.results) {
        if(reverseGeocodeVO.name == "addr"){ // 지번 주소
          String sido = reverseGeocodeVO.region.area1.name; // 시도
          String sigungu = reverseGeocodeVO.region.area2.name; // 시군구
          String eupmyeondong = reverseGeocodeVO.region.area3.name; // 읍면동
          String ri = reverseGeocodeVO.region.area4.name; // 리
          String num1 = reverseGeocodeVO.land.number1; // 토지 본번호
          String? num2 = reverseGeocodeVO.land.number2; // 토지 부번호
          String addr = "$sido $sigungu $eupmyeondong $ri".trim();
          String beonji = "$num1 $num2".trim();
          print('지번주소: $addr $beonji');

        } else if(reverseGeocodeVO.name == "roadaddr"){ // 도로명 주소
          String sido = reverseGeocodeVO.region.area1.name; // 시도
          String sigungu = reverseGeocodeVO.region.area2.name; // 시군구
          String? roadName = reverseGeocodeVO.land.name; // 토지 본번호
          String roadNameDatail = reverseGeocodeVO.land.number1; // 토지 부번호
          String roadAddr = "$sido $sigungu $roadName $roadNameDatail".trim();
          print('도로명주소: $roadAddr');
        }
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NaverMap(
          options: const NaverMapViewOptions(
            contentPadding: EdgeInsets.only(bottom: 0.0), // 지도 내 표시되는 콘텐츠의 패딩. UI 요소가 지도를 덮을 때 지도의 UI를 이동시키고 카메라를 중앙에 위치시키기 위해 사용.
            initialCameraPosition: NCameraPosition(
                target: NLatLng(37.5664056, 126.9778222),
                zoom: 16,
                bearing: 0, // 카메라가 바라보는 방향. 정북 방향을 바라볼 때를 기준으로 0~360까지 증가
                tilt: 0
            ),
            locationButtonEnable: true, // 현재위치 버튼 표시
            // tiltGesturesEnable: false, // 틸트 제스처 비활성화
            minZoom: 8, // 최소 줌 레벨. default is 0
            maxZoom: 18, // 최대 줌 레벨. default is 21
            // maxTilt: 45, // 최대 틸트 각도. default is 63
            extent: NLatLngBounds( // 지도 영역을 한반도 인근으로 제한
              southWest: NLatLng(31.43, 122.37),
              northEast: NLatLng(44.35, 132.0),
            ),
          ),
          forceGesture: false, // 지도에 전달되는 제스처 이벤트의 우선순위를 가장 높게 설정할지 여부를 지정합니다.
          onMapReady: (controller){
            print('onMapReady');
            mapController = controller;
          },
          onMapTapped: (point, latLng) {
            print('onMapTapped - point: ${point.payload}, latLng: ${latLng.latitude}, ${latLng.longitude}');
            createMarker(latLng);
            // createMarkers();

          },
          onSymbolTapped: (symbol) {
            print('onSymbolTapped - symbol: ${symbol.caption}, ${symbol.position.latitude}, ${symbol.position.longitude}');
          },
          onCameraChange: (position, reason) {
            print('onCameraChange');
          },
          onCameraIdle: () {
            print('onCameraIdle');
          },
          onSelectedIndoorChanged: (indoor) {
            print('onSelectedIndoorChanged');
          },
        ) ,
      ),
    );
  }
}
