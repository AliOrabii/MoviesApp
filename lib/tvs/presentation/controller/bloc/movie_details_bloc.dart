import 'dart:async';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/tvs/domain/models/models.dart';
import 'package:clean_architecture/tvs/domain/usecases/movie_details.dart';
import 'package:clean_architecture/tvs/domain/usecases/similar_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MoiveDetailsUsecase movieDetailsUsecase;
  final SimilarMoviesUsecase similarMoviesUsecase;
  MovieDetailsBloc(this.movieDetailsUsecase, this.similarMoviesUsecase)
      : super(MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetMovieSimilarEvent>(_getMovieSimilarMovies);
  }

  FutureOr<void> _getMovieSimilarMovies(event, emit) async {
    final result = await similarMoviesUsecase(event.id);

    result.fold(
      (l) =>
          emit(state.copyWith(message: l.message, state: RequestState.error)),
      (r) => emit(
        state.copyWith(
            message: 'Data Loaded',
            similarMovies: r,
            state: RequestState.loaded),
      ),
    );
  }

  FutureOr<void> _getMovieDetails(event, emit) async {
    final result = await movieDetailsUsecase(event.id);

    result.fold(
      (l) =>
          emit(state.copyWith(message: l.message, state: RequestState.error)),
      (r) => emit(
        state.copyWith(
            message: 'Data Loaded', movieModel: r, state: RequestState.loaded),
      ),
    );
  }
}
