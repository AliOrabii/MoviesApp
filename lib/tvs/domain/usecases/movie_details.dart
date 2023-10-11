import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/usecase/base_usecase.dart';
import 'package:clean_architecture/tvs/domain/models/models.dart';
import 'package:clean_architecture/tvs/domain/repository/base_movies_repositroy.dart';
import 'package:dartz/dartz.dart';

class MoiveDetailsUsecase extends BaseUsecase<int, MovieDetaillls> {
  BaseMoviesRepo baseMoviesRepo;

  MoiveDetailsUsecase(this.baseMoviesRepo);
  @override
  Future<Either<Failure, MovieDetaillls>> call(int id) async {
    return await baseMoviesRepo.getMovieDetails(id);
  }
}
