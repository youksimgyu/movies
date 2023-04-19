import 'dart:convert';

import 'package:movies/models/coming_soon_model.dart';
import 'package:movies/models/movie_detail_model.dart';
import 'package:movies/models/now_playing_model.dart';
import 'package:movies/models/popular_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  /*가장 인기있는 영화*/
  static const String popularMovieUrl =
      'https://movies-api.nomadcoders.workers.dev/popular';
  static Future<List<PopularModel>> getPopularMovies() async {
    List<PopularModel> popularMovieInstances = [];
    final url = Uri.parse(popularMovieUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> popularMovies = jsonDecode(response.body)['results'];
      for (var popularMovie in popularMovies) {
        final instance = PopularModel.fromJson(popularMovie);
        popularMovieInstances.add(instance);
      }
      return popularMovieInstances;
    }
    throw Error();
  }

  /*상영 중인 영화*/
  static const String nowPlayingMovieUrl =
      'https://movies-api.nomadcoders.workers.dev/now-playing';
  static Future<List<NowPlayingModel>> getNowPlayingMovies() async {
    List<NowPlayingModel> nowPlayingMoviesInstances = [];
    final url = Uri.parse(nowPlayingMovieUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> nowPlayingMoives =
          jsonDecode(response.body)['results'];
      for (var nowPlayingMoive in nowPlayingMoives) {
        final instance = NowPlayingModel.fromJson(nowPlayingMoive);
        nowPlayingMoviesInstances.add(instance);
      }
      return nowPlayingMoviesInstances;
    }
    throw Error();
  }

  /*곧 개봉하는 영화*/
  static const String commingSoonMovieUrl =
      'https://movies-api.nomadcoders.workers.dev/coming-soon';
  static Future<List<ComingSoonModel>> getCommingSoonMovies() async {
    List<ComingSoonModel> commingSoonMovieInstances = [];
    final url = Uri.parse(commingSoonMovieUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> commingSoonMoives =
          jsonDecode(response.body)['results'];
      for (var commingSoonMoive in commingSoonMoives) {
        final instance = ComingSoonModel.fromJson(commingSoonMoive);
        commingSoonMovieInstances.add(instance);
      }
      return commingSoonMovieInstances;
    }
    throw Error();
  }

  /*영화 디테일*/
  static const String movieDetailBaseUrl =
      'https://movies-api.nomadcoders.workers.dev/movie?id=';
  static Future<MovieDetailModel> getMovieDetailById(int id) async {
    final url = Uri.parse('$movieDetailBaseUrl$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movieDetail = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movieDetail);
    }
    throw Error();
  }
}
