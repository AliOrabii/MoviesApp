import 'dart:convert';

import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/core/network/api_constance.dart';
import 'package:clean_architecture/core/network/error_message.dart';
import 'package:clean_architecture/tvs/data/models/movie_model.dart';
import 'package:clean_architecture/tvs/domain/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getTopRatedMovies();

  Future<List<MovieModel>> getSimilarMovies(int id);

  Future<MovieDetaillls> getMovieDetails(int id);
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    var response = await Dio().get(ApiConstance.nowPlayingMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map(
          (e) => MovieModel.fromJson(e),
        ),
      );
      // movies.forEach((element) {
      //   print(element.title);
      //   print(element.id);
      //   print(element.overview);
      //   print(element.releaseDate);
      //   print(element.adult);
      // });
      //return movies;
    } else {
      throw ServerException(
        errorMessage: ErrorMessage.fromJson(
          response.data,
        ),
      );
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await Dio().get(ApiConstance.PopularMoviesPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map(
          (e) => MovieModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessage: ErrorMessage.fromJson(
          response.data,
        ),
      );
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await Dio().get(ApiConstance.TopRatedMoviesPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map(
          (e) => MovieModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessage: ErrorMessage.fromJson(
          response.data,
        ),
      );
    }
  }

  @override
  Future<MovieDetaillls> getMovieDetails(int id) async {
    final Response = await Dio().get(ApiConstance.MovieDetailsPath(id));

    if (Response.statusCode == 200) {
      return MovieDetailsModel.fromjson(Response.data);
    } else {
      throw ServerException(
        errorMessage: ErrorMessage.fromJson(
          Response.data,
        ),
      );
    }
  }

  @override
  Future<List<MovieModel>> getSimilarMovies(int id) async {
    final response = await Dio().get(ApiConstance.SimilarMoviePath(id));

    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map(
          (e) => MovieModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessage: ErrorMessage.fromJson(
          response.data,
        ),
      );
    }
  }
}
