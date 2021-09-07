import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/models/movie_items.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Constants.BASE_URL)
abstract class ApiProvider {
  factory ApiProvider(Dio dio, {String baseUrl}) = _ApiProvider;

  @GET("/{type}?api_key={apiKey}")
  Future<MovieItems> getMovies(
      @Path('type') String type, @Path('apiKey') String apiKey);
}
