import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/usecase/base_usecase.dart';
import 'package:clean_architecture/tvs/domain/models/models.dart';
import 'package:clean_architecture/tvs/domain/repository/base_movies_repositroy.dart';
import 'package:dartz/dartz.dart';

class TopRatedUsecase extends BaseUsecase<void, List<Movie>> {
  final BaseMoviesRepo baseMovieRepo;

  TopRatedUsecase(this.baseMovieRepo);
  @override
  Future<Either<Failure, List<Movie>>> call(void Input) async {
    return await baseMovieRepo.getTopRatedMovies();
  }
}
