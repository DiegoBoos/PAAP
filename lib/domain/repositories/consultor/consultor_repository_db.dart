import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/consultor_entity.dart';

abstract class ConsultorRepositoryDB {
  Future<Either<Failure, List<ConsultorEntity>>> getConsultoresRepositoryDB();

  Future<Either<Failure, int>> saveConsultoresRepositoryDB(
      List<ConsultorEntity> consultorEntity);
}
