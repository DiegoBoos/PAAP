import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/residencia_entity.dart';

abstract class ResidenciaRepositoryDB {
  Future<Either<Failure, List<ResidenciaEntity>>> getResidenciasRepositoryDB();

  Future<Either<Failure, int>> saveResidenciaRepositoryDB(
      List<ResidenciaEntity> residenciaEntity);
}
