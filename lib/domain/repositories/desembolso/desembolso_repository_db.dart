import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/desembolso_entity.dart';

abstract class DesembolsoRepositoryDB {
  Future<Either<Failure, List<DesembolsoEntity>>> getDesembolsosRepositoryDB();

  Future<Either<Failure, int>> saveDesembolsosRepositoryDB(
      List<DesembolsoEntity> desembolsoEntity);
}
