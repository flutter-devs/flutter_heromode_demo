import 'package:flutter/cupertino.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/models/movie_items.dart';
import 'package:movie_app/core/repositories/api_repository.dart';
import 'package:movie_app/core/services/api_service.dart';

class HomeViewModel extends ChangeNotifier {

  APIRepository _apiRepository=APIRepository();
  MovieItems? _popularMovies;
  MovieItems? _upcomingMovies;
  MovieItems? _topRatedMovies;
  bool _isPopularLoading= false;
  bool _isUpcomingLoading= false;
  bool _isTopRatedLoading= false;
  bool _isHeroModeEnable= true;


  bool get isHeroModeEnable => _isHeroModeEnable;

  set isHeroModeEnable(bool value) {
    _isHeroModeEnable = value;
    notifyListeners();
  }

  MovieItems? get popularMovies => _popularMovies;

  set popularMovies(MovieItems? value) {
    _popularMovies = value;
    notifyListeners();
  }

  MovieItems? get upcomingMovies => _upcomingMovies;

  set upcomingMovies(MovieItems? value) {
    _upcomingMovies = value;
    notifyListeners();
  }

  MovieItems? get topRatedMovies => _topRatedMovies;

  set topRatedMovies(MovieItems? value) {
    _topRatedMovies = value;
    notifyListeners();
  }

  Future<void> getPopularMovies() async {
    _isPopularLoading = true;
    notifyListeners();
    _popularMovies = await _apiRepository.getPopularMovies(Constants.FILTER_POPULAR, Constants.API_KEY);
    _isPopularLoading = false;
    notifyListeners();
  }

  Future<void> getTopRatedMovies() async {
    _isUpcomingLoading = true;
    notifyListeners();
    _topRatedMovies = await _apiRepository.getTopRatedMovies(Constants.FILTER_TOP_RATED, Constants.API_KEY);
    _isUpcomingLoading = false;
    notifyListeners();
  }

  Future<void> getUpcomingMovies() async {
    _isTopRatedLoading = true;
    notifyListeners();
    _upcomingMovies = await _apiRepository.getUpcomingMovies(Constants.FILTER_UPCOMING, Constants.API_KEY);
    _isTopRatedLoading = false;
    notifyListeners();
  }


  bool get isPopularLoading => _isPopularLoading;

  set isPopularLoading(bool value) {
    _isPopularLoading = value;
  }

  bool get isUpcomingLoading => _isUpcomingLoading;

  set isUpcomingLoading(bool value) {
    _isUpcomingLoading = value;
  }

  bool get isTopRatedLoading => _isTopRatedLoading;

  set isTopRatedLoading(bool value) {
    _isTopRatedLoading = value;
  }
}
