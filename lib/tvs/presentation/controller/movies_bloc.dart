import 'dart:ffi';

import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/tvs/domain/usecases/movie_details.dart';

import 'package:clean_architecture/tvs/domain/usecases/now_playing.dart';
import 'package:clean_architecture/tvs/domain/usecases/popular_movies.dart';
import 'package:clean_architecture/tvs/domain/usecases/top_rated.dart';
import 'package:clean_architecture/tvs/presentation/controller/movies_event.dart';
import 'package:clean_architecture/tvs/presentation/controller/movies_states.dart';
import 'package:clean_architecture/tvs/presentation/screens/movie_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final NowPlayingUsecase nowPlayingUsecase;
  final TopRatedUsecase topRatedUsecase;
  final PopularMoviesUsecase popularMoviesUsecases;
  final MoiveDetailsUsecase movieDetailsUsecase;
  MoviesBloc(
    this.nowPlayingUsecase,
    this.topRatedUsecase,
    this.popularMoviesUsecases,
    this.movieDetailsUsecase,
  ) : super(const MoviesState()) {
    on<GetNowPlayingMoviesEvent>((event, emit) async {
      final result = await nowPlayingUsecase(Void);

      result.fold(
        (l) => emit(state.copyWith(
            nowPlayingState: RequestState.error, nowPlayingmessage: l.message)),
        (r) => emit(
          state.copyWith(
              nowPlayingMovies: r,
              nowPlayingState: RequestState.loaded,
              nowPlayingmessage: 'Data loaded'),
        ),
      );
    });
    on<GetPopularMoviesEvent>((event, emit) async {
      final result = await popularMoviesUsecases(Void);

      result.fold(
        (l) => emit(
          state.copyWith(
              popularState: RequestState.error, popularmessage: l.message),
        ),
        (r) => emit(
          state.copyWith(
              popularMovies: r,
              popularState: RequestState.loaded,
              popularmessage: 'Data loaded'),
        ),
      );
    });
    on<GetTopRatedMoviesEvent>((event, emit) async {
      final result = await topRatedUsecase(Void);

      result.fold(
        (l) => emit(state.copyWith(
            topRatedState: RequestState.error, topRatedmessage: l.message)),
        (r) => emit(
          state.copyWith(
              topRatedMovies: r,
              topRatedState: RequestState.loaded,
              topRatedmessage: 'Data loaded'),
        ),
      );
    });
    // on<GetMovieDetailsEvent>((event, emit) async {
    //   final result = await movieDetailsUsecase.call(157336);

    //   result.fold((l) => print('failded'), (r) {
    //     print(r.id);
    //     print(r.title);
    //     print(r.overview);
    //     print(r.releaseDate);
    //     print(r.runtime);
    //     print(r.genres);
    //   });
    // });
  }
}
