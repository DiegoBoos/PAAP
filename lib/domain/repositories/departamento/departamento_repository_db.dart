import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/departamento_entity.dart';

abstract class DepartamentoRepositoryDB {
  Future<Either<Failure, List<DepartamentoEntity>>>
      getDepartamentosRepositoryDB();

  Future<Either<Failure, int>> saveDepartamentosRepositoryDB(
      List<DepartamentoEntity> departamentoEntity);
}
