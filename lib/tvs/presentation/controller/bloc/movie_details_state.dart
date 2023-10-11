part of 'movie_details_bloc.dart';

class MovieDetailsState {
  const MovieDetailsState({
    this.message = '',
    this.movieModel,
    this.state = RequestState.loading,
    this.similarmessage = '',
    this.similarMovies = const [],
    this.similarstate = RequestState.loading,
  });

  final String message;
  final RequestState state;
  final MovieDetaillls? movieModel;
  final String similarmessage;
  final RequestState similarstate;
  final List<Movie>? similarMovies;

  MovieDetailsState copyWith({
    String? message,
    RequestState? state,
    MovieDetaillls? movieModel,
    String? similarmessage,
    RequestState? similarstate,
    List<Movie>? similarMovies,
  }) =>
      MovieDetailsState(
        message: message ?? this.message,
        state: state ?? this.state,
        movieModel: movieModel ?? this.movieModel,
        similarmessage: similarmessage ?? this.similarmessage,
        similarMovies: similarMovies ?? this.similarMovies,
        similarstate: similarstate ?? this.similarstate,
      );
  @override
  List<dynamic> get props => [
        message,
        state,
        movieModel,
        similarmessage,
        similarstate,
        similarMovies,
      ];
}
