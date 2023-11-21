import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/unidad_entity.dart';

abstract class UnidadRepositoryDB {
  Future<Either<Failure, List<UnidadEntity>>> getUnidadesRepositoryDB();

  Future<Either<Failure, int>> saveUnidadesRepositoryDB(
      List<UnidadEntity> unidadEntity);
}
