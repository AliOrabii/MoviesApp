import 'dart:ffi';

import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/widgets/appWidgets.dart';
import 'package:clean_architecture/tvs/domain/models/models.dart';
import 'package:clean_architecture/tvs/domain/usecases/movie_details.dart';
import 'package:clean_architecture/tvs/domain/usecases/now_playing.dart';
import 'package:clean_architecture/tvs/domain/usecases/popular_movies.dart';
import 'package:clean_architecture/tvs/domain/usecases/similar_movies.dart';
import 'package:clean_architecture/tvs/domain/usecases/top_rated.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

enum ViewState { Loading, Success, Error, Empty }

class MovieProvider extends ChangeNotifier {
  final NowPlayingUsecase nowPlayingUsecase;
  final TopRatedUsecase topRatedUsecase;
  final PopularMoviesUsecase popularMoviesUsecase;
  final MoiveDetailsUsecase moiveDetailsUsecase;
  final SimilarMoviesUsecase similarMoviesUsecase;

  List<Movie> nowPlayingMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> popularMoviesMovies = [];
  List<Movie> similarMoviesMovies = [];
  ViewState _state = ViewState.Empty;
  ViewState get state => _state;
  setstate(ViewState newState) {
    _state = newState;
    print('New State ========  $_state');
    notifyListeners();
  }

  MovieProvider(
      this.moiveDetailsUsecase,
      this.nowPlayingUsecase,
      this.popularMoviesUsecase,
      this.similarMoviesUsecase,
      this.topRatedUsecase);

  Future<Either<Failure, List<Movie>>> getNowplaying() async {
    //setstate(ViewState.Loading);
    var result = await nowPlayingUsecase.call(Void);
    try {
      return result.fold((l) {
        setstate(ViewState.Error);
        getToast(message: l.message, isDark: false, isError: true);
        return Left(ServerFailure(l.message));
      }, (r) {
        getToast(message: 'Loaded', isDark: true);
        //nowPlayingMovies = r;
        setstate(ViewState.Success);
        return Right(r);
      });
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
