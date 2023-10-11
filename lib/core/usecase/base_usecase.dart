import 'package:clean_architecture/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUsecase<In, T> {
  Future<Either<Failure, T>> call(In input);
}
