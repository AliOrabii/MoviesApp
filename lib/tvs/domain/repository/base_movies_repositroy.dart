import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/tvs/domain/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class BaseMoviesRepo {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, List<Movie>>> getSimilarMovies(int id);

  Future<Either<Failure, MovieDetaillls>> getMovieDetails(int id);
}
