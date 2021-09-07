
import 'package:dio/dio.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/models/movie_items.dart';
import 'package:movie_app/core/services/api_service.dart';


class APIRepository {
  ApiProvider _apiProvider=ApiProvider(Dio(), baseUrl: Constants.BASE_URL);

  Future<MovieItems> getPopularMovies(String type,  String key) async {
    MovieItems? _popularMovies = await _apiProvider.getMovies(type, key);
   return _popularMovies;
  }

  Future<MovieItems> getTopRatedMovies(String type,  String key) async {
    MovieItems? _topRatedMovies= await _apiProvider.getMovies(type, key);
   return _topRatedMovies;
  }

  Future<MovieItems> getUpcomingMovies(String type, String key) async {
    MovieItems? _upcomingMovies= await _apiProvider.getMovies(type, key);
    return _upcomingMovies;
  }
}