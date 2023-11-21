import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/genero_entity.dart';

abstract class GeneroRepositoryDB {
  Future<Either<Failure, List<GeneroEntity>>> getGenerosRepositoryDB();

  Future<Either<Failure, int>> saveGenerosRepositoryDB(
      List<GeneroEntity> generoEntity);
}
