import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/beneficio_entity.dart';

abstract class BeneficioRepositoryDB {
  Future<Either<Failure, List<BeneficioEntity>>> getBeneficiosRepositoryDB();

  Future<Either<Failure, int>> saveBeneficiosRepositoryDB(
      List<BeneficioEntity> beneficioEntity);
}
