import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://devapi.pildservice.com/pldsvc/madang/app")
abstract class RestClient{
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('https://httpbin.org/get')
  Future<String> namedExample(
      @Query('apikey') String apiKey,
      @Query('scope') String scope,
      @Query('type') String type,
      @Query('from') int from);

  @POST('https://devapi.pildservice.com/pldsvc/madang/app/version')
  Future<Map<String, String>> version(@Body() Map<String, String> data);

}