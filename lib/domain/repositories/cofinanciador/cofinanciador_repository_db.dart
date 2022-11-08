import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/cofinanciador_entity.dart';

abstract class CofinanciadorRepositoryDB {
  Future<Either<Failure, List<CofinanciadorEntity>>>
      getCofinanciadoresRepositoryDB();

  Future<Either<Failure, CofinanciadorEntity?>> getCofinanciadorRepositoryDB(
      String id);

  Future<Either<Failure, int>> saveCofinanciadoresRepositoryDB(
      List<CofinanciadorEntity> cofinanciadorEntity);
}
