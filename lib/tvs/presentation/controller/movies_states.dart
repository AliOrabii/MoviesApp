// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:equatable/equatable.dart';

import 'package:clean_architecture/tvs/domain/models/models.dart';

class MoviesState extends Equatable {
  final List<Movie> NowPlayingMovies;
  final RequestState NowPlayingState;
  final String NowPlayingmessage;
  final List<Movie> TopRatedMovies;
  final RequestState TopRatedState;
  final String TopRatedmessage;
  final List<Movie> PopularMovies;
  final RequestState PopularState;
  final String Popularmessage;

  const MoviesState({
    this.NowPlayingMovies = const [],
    this.NowPlayingState = RequestState.loading,
    this.NowPlayingmessage = '',
    this.TopRatedMovies = const [],
    this.TopRatedState = RequestState.loading,
    this.TopRatedmessage = '',
    this.PopularMovies = const [],
    this.PopularState = RequestState.loading,
    this.Popularmessage = '',
  });

  MoviesState copyWith({
    List<Movie>? nowPlayingMovies,
    RequestState? nowPlayingState,
    String? nowPlayingmessage,
    List<Movie>? topRatedMovies,
    RequestState? topRatedState,
    String? topRatedmessage,
    List<Movie>? popularMovies,
    RequestState? popularState,
    String? popularmessage,
  }) {
    return MoviesState(
      NowPlayingMovies: nowPlayingMovies ?? this.NowPlayingMovies,
      NowPlayingState: nowPlayingState ?? this.NowPlayingState,
      NowPlayingmessage: nowPlayingmessage ?? this.NowPlayingmessage,
      TopRatedMovies: topRatedMovies ?? this.TopRatedMovies,
      TopRatedState: topRatedState ?? this.TopRatedState,
      TopRatedmessage: topRatedmessage ?? this.TopRatedmessage,
      PopularMovies: popularMovies ?? this.PopularMovies,
      PopularState: popularState ?? this.PopularState,
      Popularmessage: popularmessage ?? this.Popularmessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        NowPlayingMovies,
        NowPlayingState,
        NowPlayingmessage,
        TopRatedMovies,
        TopRatedState,
        TopRatedmessage,
        PopularMovies,
        PopularState,
        Popularmessage,
      ];
}
