part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
}

class GetMovieDetailsEvent extends MovieDetailsEvent {
  final int id;

  GetMovieDetailsEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class GetMovieSimilarEvent extends MovieDetailsEvent {
  final int id;

  GetMovieSimilarEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
