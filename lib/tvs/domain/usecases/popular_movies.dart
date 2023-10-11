import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/usecase/base_usecase.dart';
import 'package:clean_architecture/tvs/domain/models/models.dart';
import 'package:clean_architecture/tvs/domain/repository/base_movies_repositroy.dart';
import 'package:dartz/dartz.dart';

class PopularMoviesUsecase extends BaseUsecase<void, List<Movie>> {
  final BaseMoviesRepo baseMoviesRepo;

  PopularMoviesUsecase(this.baseMoviesRepo);

  @override
  Future<Either<Failure, List<Movie>>> call(void input) async {
    return await baseMoviesRepo.getPopularMovies();
  }
}
