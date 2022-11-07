import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/aliado_entity.dart';

abstract class AliadoRepositoryDB {
  Future<Either<Failure, List<AliadoEntity>>> getAliadosRepositoryDB();

  Future<Either<Failure, int>> saveAliadosRepositoryDB(
      List<AliadoEntity> aliadoEntity);
}
